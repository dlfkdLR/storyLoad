import SwiftUI

/// 단방향 SNS 피드 — 현지인·여행자의 사진과 음성 이야기
struct FeedView: View {
    @EnvironmentObject private var store: AppStore
    @StateObject private var player = StoryPlayer()
    @State private var selectedRegion: Region?

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 14) {
                    ForEach(store.posts) { post in
                        FeedPostCard(post: post, player: player) { region in
                            selectedRegion = region
                        }
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("피드")
            .sheet(item: $selectedRegion) { region in
                RegionDetailView(region: region)
            }
            .onDisappear { player.stop() }
        }
    }
}
