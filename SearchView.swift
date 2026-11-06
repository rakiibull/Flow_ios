import SwiftUI

struct SearchView: View {
    @State private var query = ""
    private var results: [MediaItem] {
        guard !query.isEmpty else { return MediaItem.samples }
        return MediaItem.samples.filter { ($0.title + $0.creator).localizedCaseInsensitiveContains(query) }
    }
    var body: some View {
        NavigationStack {
            List(results) { item in
                VStack(alignment: .leading) {
                    Text(item.title)
                    Text(item.creator).font(.caption).foregroundStyle(.secondary)
                }
            }
            .searchable(text: $query, prompt: "Search videos and music")
            .navigationTitle("Search")
        }
    }
}
