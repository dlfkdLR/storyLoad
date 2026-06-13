import SwiftUI

/// 오디오 스토리 한 줄 — 재생/정지 버튼 포함
struct AudioStoryRow: View {
    let story: AudioStory
    let accent: Color
    @ObservedObject var player: StoryPlayer

    private var isPlaying: Bool { player.playingID == story.id }

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(accent.opacity(0.15))
                    .frame(width: 40, height: 40)
                Image(systemName: story.isMine ? "person.fill" : "person.wave.2.fill")
                    .font(.system(size: 16))
                    .foregroundStyle(accent)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(story.title)
                    .font(.subheadline.bold())
                    .lineLimit(1)
                HStack(spacing: 4) {
                    Text(story.author)
                    Text("·")
                    Text(story.durationText)
                    if story.isMine {
                        Text("· 내 녹음")
                            .foregroundStyle(accent)
                    }
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }

            Spacer()

            Button {
                player.toggle(story)
            } label: {
                Image(systemName: isPlaying ? "stop.circle.fill" : "play.circle.fill")
                    .font(.system(size: 32))
                    .foregroundStyle(accent)
                    .symbolEffect(.pulse, isActive: isPlaying)
            }
            .buttonStyle(.plain)
        }
        .padding(10)
        .background(Color(.tertiarySystemBackground), in: RoundedRectangle(cornerRadius: 12))
    }
}

/// 추억 한 줄 — 사진·글·음성
struct MemoryRow: View {
    @EnvironmentObject private var store: AppStore
    let memory: Memory
    @ObservedObject var player: StoryPlayer

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let photoFileName = memory.photoFileName,
               let image = store.photo(named: photoFileName, maxPixelSize: 900) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            if !memory.text.isEmpty {
                Text(memory.text)
                    .font(.callout)
            }

            HStack {
                Text(memory.createdAt.memoryLabel)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Spacer()

                if let audioFileName = memory.audioFileName {
                    Button {
                        let voiceMemo = AudioStory(
                            id: memory.id, regionID: memory.regionID, author: "나",
                            title: "음성 메모", transcript: "", durationText: "",
                            fileName: audioFileName, isMine: true
                        )
                        player.toggle(voiceMemo)
                    } label: {
                        Label(
                            player.playingID == memory.id ? "정지" : "음성 메모",
                            systemImage: player.playingID == memory.id ? "stop.fill" : "waveform"
                        )
                        .font(.caption.bold())
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.small)
                }
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.tertiarySystemBackground), in: RoundedRectangle(cornerRadius: 12))
        .contextMenu {
            Button(role: .destructive) {
                store.deleteMemory(memory)
            } label: {
                Label("삭제", systemImage: "trash")
            }
        }
    }
}
