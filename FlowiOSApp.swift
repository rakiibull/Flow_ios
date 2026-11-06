import SwiftUI

@main
struct FlowiOSApp: App {
    @StateObject private var library = LibraryStore()
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(library)
                .preferredColorScheme(.dark)
        }
    }
}
