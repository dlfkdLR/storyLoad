import SwiftUI

/// 스탬프 수집 현황 — 도장깨기
struct StampsView: View {
    @EnvironmentObject private var store: AppStore
    @State private var selectedRegion: Region?

    private let columns = [GridItem(.adaptive(minimum: 104), spacing: 14)]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    progressHeader

                    LazyVGrid(columns: columns, spacing: 14) {
                        ForEach(store.regions) { region in
                            StampBadge(
                                region: region,
                                unlockDate: store.unlockDate(region.id)
                            )
                            .onTapGesture { selectedRegion = region }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("나의 스탬프")
            .sheet(item: $selectedRegion) { region in
                RegionDetailView(region: region)
            }
        }
    }

    private var progressHeader: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .stroke(Color(.systemGray5), lineWidth: 12)
                Circle()
                    .trim(from: 0, to: store.stampProgress)
                    .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.spring, value: store.stampProgress)

                VStack(spacing: 2) {
                    Text("\(store.unlockedCount)")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                    Text("/ \(store.regions.count) 지역")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .frame(width: 150, height: 150)

            Text(progressMessage)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.top, 8)
    }

    private var progressMessage: String {
        switch store.unlockedCount {
        case 0: return "첫 여행지로 떠나 스탬프를 찍어보세요!"
        case store.regions.count: return "경북 전 지역 정복! 당신은 진정한 스토리로더 🎉"
        default: return "다음 스탬프까지 여행은 계속됩니다"
        }
    }
}

/// 지역 스탬프 배지
struct StampBadge: View {
    let region: Region
    let unlockDate: Date?

    private var isUnlocked: Bool { unlockDate != nil }

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(isUnlocked ? AnyShapeStyle(region.color.gradient) : AnyShapeStyle(Color(.systemGray5)))
                    .frame(width: 64, height: 64)

                if isUnlocked {
                    Circle()
                        .strokeBorder(region.color.opacity(0.4), style: StrokeStyle(lineWidth: 2, dash: [4, 3]))
                        .frame(width: 76, height: 76)
                }

                Image(systemName: isUnlocked ? region.symbol : "lock.fill")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(isUnlocked ? .white : Color(.systemGray2))
            }

            Text(region.name)
                .font(.subheadline.bold())
                .foregroundStyle(isUnlocked ? .primary : .secondary)

            Text(unlockDate?.stampLabel ?? "미방문")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 16))
        .opacity(isUnlocked ? 1 : 0.75)
    }
}
