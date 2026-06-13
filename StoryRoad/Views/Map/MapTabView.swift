import SwiftUI
import MapKit

/// 메인 지도 — 시·군 경계를 면으로 표시
/// 안 가본 곳은 연한 회색, 가본 곳은 지역 색 + 그곳에서 찍은 사진
struct MapTabView: View {
    @EnvironmentObject private var store: AppStore
    @EnvironmentObject private var locationManager: LocationManager

    @State private var camera: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 36.25, longitude: 128.85),
            span: MKCoordinateSpan(latitudeDelta: 2.3, longitudeDelta: 2.4)
        )
    )
    @State private var selectedRegion: Region?

    private let boundaries = RegionBoundaries.shared

    var body: some View {
        NavigationStack {
            Map(position: $camera) {
                UserAnnotation()

                // 행정구역 경계 면 — 잠금: 연한 회색 / 해제: 지역 색
                ForEach(store.regions) { region in
                    let isUnlocked = store.isUnlocked(region.id)
                    let polygons = boundaries.polygons(for: region.id)

                    ForEach(polygons.indices, id: \.self) { index in
                        MapPolygon(coordinates: polygons[index])
                            .foregroundStyle(
                                isUnlocked
                                ? Color.stampLight.opacity(0.55)
                                : Color(white: 0.78).opacity(0.62)
                            )
                            .stroke(
                                isUnlocked ? Color.stampDeep : Color(white: 0.42).opacity(0.95),
                                lineWidth: isUnlocked ? 3 : 2
                            )
                    }
                }

                // 지역 마커 — 해제: 그곳에서 찍은 사진 / 잠금: 옅은 자물쇠
                ForEach(store.regions) { region in
                    Annotation(region.name, coordinate: region.coordinate) {
                        RegionMapMarker(
                            region: region,
                            isUnlocked: store.isUnlocked(region.id),
                            photo: store.isUnlocked(region.id) ? store.coverPhoto(for: region.id) : nil
                        )
                        .onTapGesture { selectedRegion = region }
                    }
                }
            }
            .mapStyle(.standard(elevation: .flat, pointsOfInterest: .excludingAll))
            .safeAreaInset(edge: .bottom) {
                if let nearby = locationManager.currentRegion(from: store.regions),
                   !store.isUnlocked(nearby.id) {
                    ArrivalBanner(region: nearby) {
                        store.unlock(nearby)
                        selectedRegion = nearby
                    }
                }
            }
            .navigationTitle("스토리로드")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Toggle(isOn: $store.demoMode) {
                            Label("데모 모드", systemImage: "wand.and.stars")
                        }
                        Text("데모 모드에서는 실제 방문 없이도\n지역 잠금을 해제할 수 있어요")
                    } label: {
                        Image(systemName: store.demoMode ? "wand.and.stars" : "location.fill")
                    }
                }
            }
            .sheet(item: $selectedRegion) { region in
                RegionDetailView(region: region)
            }
        }
    }
}

/// 지도 위 지역 마커
/// - 잠금: 옅은 회색 자물쇠
/// - 해제 + 사진 있음: 그 지역에서 찍은 사진 썸네일
/// - 해제 + 사진 없음: 지역 색 스탬프
struct RegionMapMarker: View {
    let region: Region
    let isUnlocked: Bool
    let photo: UIImage?

    var body: some View {
        if !isUnlocked {
            ZStack {
                Circle()
                    .fill(Color(.systemGray4).opacity(0.85))
                    .frame(width: 32, height: 32)
                Image(systemName: "lock.fill")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color(.systemGray))
            }
            .shadow(color: .black.opacity(0.12), radius: 2, y: 1)
        } else if let photo {
            Image(uiImage: photo)
                .resizable()
                .scaledToFill()
                .frame(width: 58, height: 58)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(Color.stampCream, lineWidth: 3)
                }
                .overlay(alignment: .topTrailing) {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 16))
                        .foregroundStyle(.white, Color.stampMid)
                        .offset(x: 6, y: -6)
                }
                .shadow(color: .black.opacity(0.3), radius: 4, y: 2)
        } else {
            ZStack {
                Circle()
                    .fill(Color.stampMid.gradient)
                    .frame(width: 44, height: 44)
                Image(systemName: region.symbol)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.stampCream)
            }
            .overlay(alignment: .topTrailing) {
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 15))
                    .foregroundStyle(.white, Color.stampDeep)
                    .offset(x: 4, y: -4)
            }
            .shadow(color: .black.opacity(0.25), radius: 4, y: 2)
        }
    }
}

/// "지금 이 지역에 있어요" 도착 배너
struct ArrivalBanner: View {
    let region: Region
    let onUnlock: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "location.fill")
                .font(.title3)
                .foregroundStyle(.white)

            VStack(alignment: .leading, spacing: 2) {
                Text("지금 \(region.name)에 있어요!")
                    .font(.subheadline.bold())
                    .foregroundStyle(.white)
                Text("스탬프를 찍고 숨은 이야기를 들어보세요")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.85))
            }

            Spacer()

            Button(action: onUnlock) {
                Text("잠금 해제")
                    .font(.subheadline.bold())
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(.white, in: Capsule())
                    .foregroundStyle(region.color)
            }
        }
        .padding(14)
        .background(region.color.gradient, in: RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
}
