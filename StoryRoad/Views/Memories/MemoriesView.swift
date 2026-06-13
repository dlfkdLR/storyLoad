import SwiftUI

/// 내 추억 — 나만 볼 수 있는 여행 다이어리
struct MemoriesView: View {
    @EnvironmentObject private var store: AppStore
    @StateObject private var player = StoryPlayer()
    @State private var showCompose = false

    /// 추억이 있는 지역들 (최신 추억 순)
    private var regionIDsWithMemories: [String] {
        var seen = Set<String>()
        return store.memories.compactMap { memory in
            seen.insert(memory.regionID).inserted ? memory.regionID : nil
        }
    }

    var body: some View {
        NavigationStack {
            Group {
                if store.memories.isEmpty {
                    emptyState
                } else {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 20) {
                            ForEach(regionIDsWithMemories, id: \.self) { regionID in
                                if let region = store.region(for: regionID) {
                                    regionSection(region)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("내 추억")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showCompose = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(unlockedRegions.isEmpty)
                }
            }
            .sheet(isPresented: $showCompose) {
                MemoryComposeView(fixedRegionID: nil)
            }
            .onDisappear { player.stop() }
        }
    }

    private var unlockedRegions: [Region] {
        store.regions.filter { store.isUnlocked($0.id) }
    }

    private func regionSection(_ region: Region) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 6) {
                Image(systemName: region.symbol)
                    .foregroundStyle(region.color)
                Text(region.name)
                    .font(.headline)
                Text("\(store.memories(in: region.id).count)개의 추억")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            ForEach(store.memories(in: region.id)) { memory in
                MemoryRow(memory: memory, player: player)
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 14) {
            Image(systemName: "book.closed")
                .font(.system(size: 52))
                .foregroundStyle(.secondary)
            Text("아직 기록한 추억이 없어요")
                .font(.headline)
            Text("여행지에서 사진·글·음성으로 추억을 남기면\n나만 볼 수 있는 다이어리가 됩니다")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            if unlockedRegions.isEmpty {
                Text("먼저 지도에서 지역 스탬프를 찍어보세요")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            } else {
                Button {
                    showCompose = true
                } label: {
                    Label("첫 추억 남기기", systemImage: "plus")
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 4)
            }
        }
        .padding()
    }
}
