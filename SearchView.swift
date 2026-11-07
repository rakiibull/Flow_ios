import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var library: LibraryStore
    @State private var query = ""
    @State private var selected: MediaItem?
    private var results: [MediaItem] {
        guard !query.isEmpty else { return library.feed }
        return library.feed.filter { ($0.title + " " + $0.creator).localizedCaseInsensitiveContains(query) }
    }
    var body: some View {
        NavigationStack {
            List(results) { item in
                Button { selected = item } label: {
                    VStack(alignment: .leading, spacing: 4) { Text(item.title).foregroundStyle(.primary); Text(item.creator).font(.caption).foregroundStyle(.secondary) }
                }
            }.searchable(text: $query, prompt: "Search Flow Tube").navigationTitle("Search")
                .sheet(item: $selected) { PlayerView(item: $0) }
        }.preferredColorScheme(.dark)
    }
}
