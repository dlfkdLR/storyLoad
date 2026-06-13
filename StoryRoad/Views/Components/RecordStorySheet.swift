import SwiftUI

/// 현재 지역에서 오디오 스토리 녹음하기
struct RecordStorySheet: View {
    @EnvironmentObject private var store: AppStore
    @Environment(\.dismiss) private var dismiss

    let region: Region

    @StateObject private var recorder = AudioRecorder()
    @State private var title = ""
    @State private var finishedFileName: String?

    var body: some View {
        NavigationStack {
            VStack(spacing: 28) {
                VStack(spacing: 6) {
                    Text("\(region.name)에서 녹음 중")
                        .font(.headline)
                    Text("이 지역에 온 다른 여행자들이 듣게 될 이야기예요")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 24)

                TextField("스토리 제목 (예: 황리단길 골목에서)", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)

                ZStack {
                    Circle()
                        .fill(recorder.isRecording ? Color.red.opacity(0.15) : region.color.opacity(0.12))
                        .frame(width: 160, height: 160)
                        .scaleEffect(recorder.isRecording ? 1.15 : 1)
                        .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true),
                                   value: recorder.isRecording)

                    Button {
                        if recorder.isRecording {
                            finishedFileName = recorder.stopRecording()
                        } else {
                            finishedFileName = nil
                            recorder.startRecording()
                        }
                    } label: {
                        Image(systemName: recorder.isRecording ? "stop.fill" : "mic.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(.white)
                            .frame(width: 96, height: 96)
                            .background(recorder.isRecording ? Color.red : region.color, in: Circle())
                    }
                    .buttonStyle(.plain)
                }

                Text(recorder.isRecording ? "녹음 중 · \(recorder.elapsedLabel)"
                     : finishedFileName != nil ? "녹음 완료 · \(recorder.elapsedLabel)"
                     : "버튼을 눌러 녹음을 시작하세요")
                    .font(.subheadline)
                    .foregroundStyle(recorder.isRecording ? .red : .secondary)

                if recorder.permissionDenied {
                    Text("설정 > 개인정보 보호에서 마이크 권한을 허용해 주세요")
                        .font(.caption)
                        .foregroundStyle(.red)
                }

                Spacer()

                Button {
                    if let fileName = finishedFileName {
                        store.addStory(
                            regionID: region.id,
                            title: title,
                            fileName: fileName,
                            durationText: recorder.elapsedLabel
                        )
                    }
                    dismiss()
                } label: {
                    Text("스토리 올리기")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                }
                .buttonStyle(.borderedProminent)
                .tint(region.color)
                .disabled(finishedFileName == nil)
                .padding(.horizontal)
                .padding(.bottom, 16)
            }
            .navigationTitle("오디오 스토리")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("취소") {
                        recorder.discardRecording()
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.large])
    }
}
