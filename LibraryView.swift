import SwiftUI

struct LibraryView: View {
    @EnvironmentObject private var library: LibraryStore
    @State private var selected: MediaItem?
    var body: some View {
        NavigationStack {
            List {
                Section("Downloads") {
                    if library.downloads.isEmpty { Text("Your downloads will appear here.").foregroundStyle(.secondary) }
                    ForEach(library.downloads) { item in
                        Button { selected = item } label: { Label(item.title, systemImage: "arrow.down.circle.fill") }
                    }
                }
                Section("Saved") {
                    if library.saved.isEmpty { Text("Saved videos will appear here.").foregroundStyle(.secondary) }
                    ForEach(library.saved) { item in Button { selected = item } label: { Text(item.title) } }
                }
                Section("History") {
                    if library.history.isEmpty { Text("Your watch history will appear here.").foregroundStyle(.secondary) }
                    ForEach(library.history) { item in Button { selected = item } label: { Text(item.title) } }
                }
            }.navigationTitle("Library").sheet(item: $selected) { PlayerView(item: $0) }
        }.preferredColorScheme(.dark)
    }
}
