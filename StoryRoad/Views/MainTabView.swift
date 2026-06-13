import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var locationManager: LocationManager

    var body: some View {
        TabView {
            MapTabView()
                .tabItem { Label("지도", systemImage: "map.fill") }

            FeedView()
                .tabItem { Label("피드", systemImage: "person.2.wave.2.fill") }

            StampsView()
                .tabItem { Label("스탬프", systemImage: "seal.fill") }

            MemoriesView()
                .tabItem { Label("내 추억", systemImage: "book.closed.fill") }
        }
        .onAppear { locationManager.request() }
    }
}

#Preview {
    MainTabView()
        .environmentObject(AppStore())
        .environmentObject(LocationManager())
}
