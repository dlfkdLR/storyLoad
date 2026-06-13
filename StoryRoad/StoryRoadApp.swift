import SwiftUI

@main
struct StoryRoadApp: App {
    @StateObject private var store = AppStore()
    @StateObject private var locationManager = LocationManager()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
                .environmentObject(locationManager)
        }
    }
}

/// 스플래시 → 메인 화면 전환
struct RootView: View {
    @State private var showSplash = true

    var body: some View {
        ZStack {
            MainTabView()

            if showSplash {
                SplashView()
                    .transition(.opacity)
                    .zIndex(1)
                    .onTapGesture { dismissSplash() }
            }
        }
        .onAppear {
            // 지역 경계 GeoJSON을 백그라운드에서 미리 파싱 (전환과 무관)
            Task.detached(priority: .utility) {
                _ = RegionBoundaries.shared
            }
            // 메인 큐 타이머 — 런루프가 도는 한 반드시 발화한다
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                dismissSplash()
            }
        }
    }

    private func dismissSplash() {
        guard showSplash else { return }
        withAnimation(.easeInOut(duration: 0.45)) {
            showSplash = false
        }
    }
}
