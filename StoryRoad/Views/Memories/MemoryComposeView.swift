import SwiftUI
import PhotosUI

/// 추억 기록 — 사진 + 글 + 음성 메모 (비공개)
struct MemoryComposeView: View {
    @EnvironmentObject private var store: AppStore
    @Environment(\.dismiss) private var dismiss

    /// 지역 상세에서 들어온 경우 해당 지역으로 고정
    let fixedRegionID: String?

    @State private var selectedRegionID = ""
    @State private var text = ""
    @State private var photoItem: PhotosPickerItem?
    @State private var photoData: Data?
    @StateObject private var recorder = AudioRecorder()
    @State private var audioFileName: String?

    private var unlockedRegions: [Region] {
        store.regions.filter { store.isUnlocked($0.id) }
    }

    private var canSave: Bool {
        !selectedRegionID.isEmpty && (!text.isEmpty || photoData != nil || audioFileName != nil)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("어디에서의 추억인가요?") {
                    if let fixedRegionID, let region = store.region(for: fixedRegionID) {
                        Label(region.name, systemImage: region.symbol)
                            .foregroundStyle(region.color)
                    } else {
                        Picker("지역", selection: $selectedRegionID) {
                            Text("선택").tag("")
                            ForEach(unlockedRegions) { region in
                                Text(region.name).tag(region.id)
                            }
                        }
                    }
                }

                Section("이야기") {
                    TextField("그날의 기분, 만난 사람, 먹은 것…", text: $text, axis: .vertical)
                        .lineLimit(4...8)
                }

                Section("사진") {
                    PhotosPicker(selection: $photoItem, matching: .images) {
                        if let photoData, let image = UIImage(data: photoData) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity)
                                .frame(height: 180)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        } else {
                            Label("사진 추가", systemImage: "photo.on.rectangle.angled")
                        }
                    }
                    .onChange(of: photoItem) { _, newItem in
                        Task {
                            photoData = try? await newItem?.loadTransferable(type: Data.self)
                        }
                    }
                }

                Section("음성 메모") {
                    HStack {
                        Button {
                            if recorder.isRecording {
                                audioFileName = recorder.stopRecording()
                            } else {
                                recorder.startRecording()
                            }
                        } label: {
                            Label(
                                recorder.isRecording ? "녹음 중지 (\(recorder.elapsedLabel))"
                                : audioFileName != nil ? "다시 녹음하기"
                                : "음성 메모 녹음",
                                systemImage: recorder.isRecording ? "stop.circle.fill" : "mic.fill"
                            )
                            .foregroundStyle(recorder.isRecording ? .red : .accentColor)
                        }

                        Spacer()

                        if audioFileName != nil && !recorder.isRecording {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                        }
                    }

                    if recorder.permissionDenied {
                        Text("설정에서 마이크 권한을 허용해 주세요")
                            .font(.caption)
                            .foregroundStyle(.red)
                    }
                }

                Section {
                    Label("이 기록은 나만 볼 수 있어요", systemImage: "lock.fill")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("추억 남기기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("취소") {
                        recorder.discardRecording()
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("저장") { saveMemory() }
                        .disabled(!canSave)
                }
            }
            .onAppear {
                if let fixedRegionID {
                    selectedRegionID = fixedRegionID
                }
            }
        }
    }

    private func saveMemory() {
        if recorder.isRecording {
            audioFileName = recorder.stopRecording()
        }

        var photoFileName: String?
        if let photoData {
            // 원본 대신 화면용 크기로 줄여 저장 — 디스크와 로딩 시간 절약
            let dataToWrite: Data
            if let image = UIImage(data: photoData),
               let resized = image.jpegDataResized(maxPixelSize: 1600, quality: 0.82) {
                dataToWrite = resized
            } else {
                dataToWrite = photoData
            }
            let fileName = "photo-\(UUID().uuidString).jpg"
            let url = AppStore.photoDirectory.appendingPathComponent(fileName)
            if (try? dataToWrite.write(to: url, options: .atomic)) != nil {
                photoFileName = fileName
            }
        }

        let memory = Memory(
            id: UUID(),
            regionID: selectedRegionID,
            text: text,
            createdAt: Date(),
            photoFileName: photoFileName,
            audioFileName: audioFileName
        )
        store.addMemory(memory)
        dismiss()
    }
}
