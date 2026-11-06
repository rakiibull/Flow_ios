import SwiftUI

struct LibraryView: View {
    @EnvironmentObject private var library: LibraryStore
    var body: some View {
        NavigationStack {
            List {
                Section("Saved") {
                    if library.saved.isEmpty { Text("Your saved items will appear here").foregroundStyle(.secondary) }
                    ForEach(library.saved) { Text($0.title) }
                }
                Section("Recently watched") {
                    if library.history.isEmpty { Text("Your watch history will appear here").foregroundStyle(.secondary) }
                    ForEach(library.history) { Text($0.title) }
                }
            }.navigationTitle("Library")
        }
    }
}
