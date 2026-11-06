import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("App") {
                    Label("Appearance", systemImage: "moon.stars")
                    Label("Playback", systemImage: "play.rectangle")
                }
                Section("About") {
                    Text("FlowiOS Starter v0.2")
                    Text("An independent SwiftUI starter project.")
                }
            }.navigationTitle("Settings")
        }
    }
}
