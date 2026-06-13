import SwiftUI

/// SNS 스타일 게시물 카드 — 사진·오디오·좋아요·댓글
/// 잠긴 지역의 게시물은 사진이 흐려지고 오디오가 비공개 처리된다
struct FeedPostCard: View {
    @EnvironmentObject private var store: AppStore
    let post: FeedPost
    @ObservedObject var player: StoryPlayer
    var showRegionChip = true
    var onRegionTap: ((Region) -> Void)? = nil

    @State private var liked = false

    private var region: Region? { store.region(for: post.regionID) }
    private var isRegionUnlocked: Bool {
        region.map { store.isUnlocked($0.id) } ?? false
    }
    private var accent: Color { region?.color ?? .gray }
    private var isMine: Bool { post.author == "나" }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            authorHeader

            if let photo = post.photo {
                photoView(photo)
            }

            if let storyID = post.audioStoryID, let story = store.story(id: storyID) {
                if isRegionUnlocked {
                    AudioStoryRow(story: story, accent: accent, player: player)
                } else {
                    lockedAudioRow
                }
            }

            actionRow

            (Text(post.author).bold() + Text("  ") + Text(post.text))
                .font(.callout)
                .lineSpacing(3)

            if post.comments > 0 {
                Text("댓글 \(post.comments)개 모두 보기")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(14)
        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 16))
    }

    // MARK: - 작성자

    private var authorHeader: some View {
        HStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(isMine ? Color.accentColor.opacity(0.2) : accent.opacity(0.2))
                    .frame(width: 40, height: 40)
                Text(String(post.author.prefix(1)))
                    .font(.headline)
                    .foregroundStyle(isMine ? Color.accentColor : accent)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(post.author).font(.subheadline.bold())
                HStack(spacing: 4) {
                    Text(post.authorBadge)
                        .font(.caption2.bold())
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(accent.opacity(0.12), in: Capsule())
                        .foregroundStyle(accent)
                    Text(post.timeAgo)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()

            if !isMine {
                followButton
            }
        }
    }

    private var followButton: some View {
        Button {
            store.toggleFollow(post.author)
        } label: {
            let isFollowing = store.following.contains(post.author)
            Text(isFollowing ? "팔로잉" : "팔로우")
                .font(.caption.bold())
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    isFollowing ? AnyShapeStyle(Color(.systemGray5)) : AnyShapeStyle(Color.accentColor),
                    in: Capsule()
                )
                .foregroundStyle(isFollowing ? Color.primary : Color.white)
        }
        .buttonStyle(.plain)
    }

    // MARK: - 사진

    @ViewBuilder
    private func photoView(_ photo: PostPhoto) -> some View {
        if isRegionUnlocked {
            PostPhotoView(photo: photo)
        } else {
            PostPhotoView(photo: photo, hideCaption: true)
                .blur(radius: 14)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .overlay {
                    VStack(spacing: 6) {
                        Image(systemName: "lock.fill")
                            .font(.title2)
                        Text("\(region?.name ?? "이 지역")에 방문하면 볼 수 있어요")
                            .font(.caption.bold())
                    }
                    .foregroundStyle(.white)
                    .padding(12)
                    .background(.black.opacity(0.35), in: RoundedRectangle(cornerRadius: 12))
                }
        }
    }

    private var lockedAudioRow: some View {
        HStack(spacing: 10) {
            Image(systemName: "lock.fill")
                .foregroundStyle(.secondary)
            VStack(alignment: .leading, spacing: 2) {
                Text("오디오 스토리가 잠겨 있어요")
                    .font(.caption.bold())
                Text("\(region?.name ?? "이 지역")에 방문하면 들을 수 있어요")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "headphones")
                .foregroundStyle(.tertiary)
        }
        .padding(10)
        .background(Color(.tertiarySystemBackground), in: RoundedRectangle(cornerRadius: 12))
    }

    // MARK: - 좋아요 · 댓글 · 지역

    private var actionRow: some View {
        HStack(spacing: 18) {
            Button {
                withAnimation(.bouncy) { liked.toggle() }
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: liked ? "heart.fill" : "heart")
                        .foregroundStyle(liked ? .red : .primary)
                    Text("\(post.likes + (liked ? 1 : 0))")
                }
            }
            .buttonStyle(.plain)

            HStack(spacing: 4) {
                Image(systemName: "bubble.right")
                Text("\(post.comments)")
            }

            Image(systemName: "paperplane")

            Spacer()

            if showRegionChip, let region {
                Button {
                    onRegionTap?(region)
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: store.isUnlocked(region.id) ? region.symbol : "lock.fill")
                        Text(region.name)
                    }
                    .font(.caption.bold())
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(region.color.opacity(0.12), in: Capsule())
                    .foregroundStyle(region.color)
                }
                .buttonStyle(.plain)
            }
        }
        .font(.subheadline)
    }
}

/// 게시물 사진 — 데모용 그라데이션 풍경 카드
struct PostPhotoView: View {
    let photo: PostPhoto
    var hideCaption = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: photo.topColorHex), Color(hex: photo.bottomColorHex)],
                startPoint: .top, endPoint: .bottom
            )
            Image(systemName: photo.symbol)
                .font(.system(size: 64))
                .foregroundStyle(.white.opacity(0.9))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 210)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(alignment: .bottomLeading) {
            if !hideCaption {
                Label(photo.caption, systemImage: "camera.fill")
                    .font(.caption.bold())
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(.black.opacity(0.35), in: Capsule())
                    .padding(10)
            }
        }
    }
}
