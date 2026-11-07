import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView().tabItem { Label("Home", systemImage: "house.fill") }
            ShortsView().tabItem { Label("Shorts", systemImage: "play.rectangle") }
            SearchView().tabItem { Label("Search", systemImage: "magnifyingglass") }
            LibraryView().tabItem { Label("Library", systemImage: "books.vertical") }
            SettingsView().tabItem { Label("You", systemImage: "person.crop.circle") }
        }
        .tint(Color(red: 1, green: 0.22, blue: 0.32))
    }
}

struct ShortsView: View {
    @EnvironmentObject private var library: LibraryStore
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack(spacing: 16) {
                    Image(systemName: "play.rectangle.fill").font(.system(size: 58)).foregroundStyle(.pink)
                    Text("Shorts").font(.largeTitle.bold()).foregroundStyle(.white)
                    Text("Short-form video feed will connect to the Flow content source in the next integration stage.")
                        .multilineTextAlignment(.center).foregroundStyle(.white.opacity(0.65)).padding(.horizontal, 30)
                }
            }.navigationBarTitleDisplayMode(.inline).toolbar { ToolbarItem(placement: .principal) { Text("Flow Tube").bold() } }
        }
    }
}
