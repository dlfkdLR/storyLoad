import SwiftUI

/// 지역 상세 — 방문 전엔 티저만, 방문(잠금 해제) 후 전체 콘텐츠 공개
struct RegionDetailView: View {
    @EnvironmentObject private var store: AppStore
    @EnvironmentObject private var locationManager: LocationManager
    @Environment(\.dismiss) private var dismiss

    let region: Region

    @StateObject private var player = StoryPlayer()
    @State private var showRecordSheet = false
    @State private var showMemoryCompose = false

    private var isUnlocked: Bool { store.isUnlocked(region.id) }
    private var canUnlockHere: Bool { store.demoMode || locationManager.isInside(region) }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    header

                    if isUnlocked {
                        unlockedContent
                    } else {
                        lockedContent
                    }
                }
                .padding(.bottom, 32)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("닫기") { dismiss() }
                }
            }
            .sheet(isPresented: $showRecordSheet) {
                RecordStorySheet(region: region)
            }
            .sheet(isPresented: $showMemoryCompose) {
                MemoryComposeView(fixedRegionID: region.id)
            }
            .onDisappear { player.stop() }
        }
    }

    // MARK: - 헤더

    private var header: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(isUnlocked ? AnyShapeStyle(region.color.gradient) : AnyShapeStyle(Color(.systemGray4)))
                    .frame(width: 84, height: 84)
                Image(systemName: isUnlocked ? region.symbol : "lock.fill")
                    .font(.system(size: 36, weight: .semibold))
                    .foregroundStyle(.white)
            }

            Text(region.name)
                .font(.largeTitle.bold())
            Text(region.subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            if let date = stampDate {
                Label("스탬프 획득 · \(date.stampLabel)", systemImage: "checkmark.seal.fill")
                    .font(.caption.bold())
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(region.color.opacity(0.15), in: Capsule())
                    .foregroundStyle(region.color)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 20)
    }

    private var stampDate: Date? {
        store.unlockDate(region.id)
    }

    // MARK: - 잠금 상태

    private var lockedContent: some View {
        VStack(spacing: 16) {
            SectionCard(title: "미리보기", symbol: "eye") {
                Text(region.teaser)
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }

            VStack(spacing: 12) {
                Image(systemName: "lock.circle.fill")
                    .font(.system(size: 44))
                    .foregroundStyle(.secondary)

                Text("이 지역의 이야기가 잠겨 있어요")
                    .font(.headline)

                Text("직접 방문하면 현지인의 오디오 스토리,\n숨은 명소와 이벤트 정보가 열립니다")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                // 잠긴 콘텐츠 흐림 미리보기
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(0..<2, id: \.self) { _ in
                        HStack {
                            Circle().fill(.gray.opacity(0.4)).frame(width: 32, height: 32)
                            VStack(alignment: .leading, spacing: 4) {
                                Capsule().fill(.gray.opacity(0.4)).frame(width: 140, height: 10)
                                Capsule().fill(.gray.opacity(0.25)).frame(width: 200, height: 10)
                            }
                            Spacer()
                            Image(systemName: "play.circle").foregroundStyle(.gray)
                        }
                        .padding(10)
                        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 12))
                    }
                }
                .blur(radius: 2.5)
                .overlay {
                    Text("🔒 \(store.posts(in: region.id).count)개의 사진·음성 이야기")
                        .font(.caption.bold())
                        .padding(8)
                        .background(.thinMaterial, in: Capsule())
                }

                unlockButton
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal)
        }
    }

    private var unlockButton: some View {
        VStack(spacing: 6) {
            Button {
                withAnimation(.bouncy) { store.unlock(region) }
            } label: {
                Label(
                    canUnlockHere ? "여기 도착! 스탬프 찍기" : "방문해야 열 수 있어요",
                    systemImage: canUnlockHere ? "seal.fill" : "location.slash"
                )
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 4)
            }
            .buttonStyle(.borderedProminent)
            .tint(region.color)
            .disabled(!canUnlockHere)

            if !canUnlockHere, let distance = locationManager.distanceLabel(to: region) {
                Text("현재 위치에서 \(distance) 떨어져 있어요")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } else if store.demoMode {
                Text("데모 모드: 방문하지 않아도 해제할 수 있어요")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }

    // MARK: - 잠금 해제 상태

    private var unlockedContent: some View {
        VStack(spacing: 16) {
            SectionCard(title: "지역 특색", symbol: "sparkles") {
                Text(region.fullDescription)
                    .font(.callout)
            }

            feedSection

            if !region.events.isEmpty {
                SectionCard(title: "이벤트 · 축제", symbol: "calendar") {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(region.events) { event in
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text(event.title).font(.subheadline.bold())
                                    Spacer()
                                    Text(event.period)
                                        .font(.caption)
                                        .foregroundStyle(region.color)
                                }
                                Text(event.detail)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            if event.id != region.events.last?.id {
                                Divider()
                            }
                        }
                    }
                }
            }

            if !region.localTips.isEmpty {
                SectionCard(title: "현지인 이야기", symbol: "person.wave.2.fill") {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(region.localTips) { tip in
                            VStack(alignment: .leading, spacing: 4) {
                                Label(tip.author, systemImage: "house.fill")
                                    .font(.caption.bold())
                                    .foregroundStyle(region.color)
                                Text(tip.content)
                                    .font(.callout)
                            }
                            if tip.id != region.localTips.last?.id {
                                Divider()
                            }
                        }
                    }
                }
            }

            memorySection
        }
    }

    /// 이 지역에 다녀간 사람들의 SNS 피드 — 사진·음성 게시물
    private var feedSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Label("여행자 피드", systemImage: "person.2.wave.2.fill")
                    .font(.headline)
                Spacer()
                Text("\(store.posts(in: region.id).count)개의 이야기")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal)

            VStack(spacing: 12) {
                Button {
                    showRecordSheet = true
                } label: {
                    Label("이곳에서 내 이야기 녹음해 올리기", systemImage: "mic.fill")
                        .font(.subheadline.bold())
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                }
                .buttonStyle(.borderedProminent)
                .tint(region.color)

                if store.posts(in: region.id).isEmpty {
                    Text("아직 이 지역의 이야기가 없어요.\n첫 번째 이야기를 남겨보세요!")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                }

                ForEach(store.posts(in: region.id)) { post in
                    FeedPostCard(post: post, player: player, showRegionChip: false)
                }
            }
            .padding(.horizontal)
        }
    }

    private var memorySection: some View {
        SectionCard(title: "나만 보는 추억", symbol: "lock.heart") {
            VStack(spacing: 10) {
                let regionMemories = store.memories(in: region.id)

                if regionMemories.isEmpty {
                    Text("이 지역에서의 추억을 기록해 보세요.\n사진·글·음성으로 남기면 나만 볼 수 있어요.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                } else {
                    ForEach(regionMemories) { memory in
                        MemoryRow(memory: memory, player: player)
                    }
                }

                Button {
                    showMemoryCompose = true
                } label: {
                    Label("추억 남기기", systemImage: "plus.circle.fill")
                        .font(.subheadline.bold())
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 4)
                }
                .buttonStyle(.bordered)
                .tint(region.color)
            }
        }
    }
}

/// 공통 섹션 카드
struct SectionCard<Content: View>: View {
    let title: String
    let symbol: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(title, systemImage: symbol)
                .font(.headline)
            content
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }
}
