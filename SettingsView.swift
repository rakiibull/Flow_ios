import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Flow Tube") {
                    Label("Playback", systemImage: "play.rectangle")
                    Label("Downloads", systemImage: "arrow.down.circle")
                    Label("Appearance", systemImage: "moon.stars")
                }
                Section("About") {
                    Text("Flow Tube for iOS")
                    Text("Native SwiftUI foundation. More original Flow features will be ported in stages.").font(.footnote).foregroundStyle(.secondary)
                }
            }.navigationTitle("You")
        }.preferredColorScheme(.dark)
    }
}
