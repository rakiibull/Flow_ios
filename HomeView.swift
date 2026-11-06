import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var library: LibraryStore
    @State private var selected: MediaItem?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    Text("Discover").font(.largeTitle.bold())
                    Text("A fresh place for video and music").foregroundStyle(.secondary)
                    ForEach(MediaItem.samples) { item in
                        Button { selected = item } label: {
                            HStack(spacing: 14) {
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(.white.opacity(0.10))
                                    .frame(width: 112, height: 72)
                                    .overlay(Image(systemName: item.imageName).font(.largeTitle))
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(item.title).font(.headline).foregroundStyle(.primary)
                                    Text(item.creator).font(.subheadline).foregroundStyle(.secondary)
                                    Text(item.subtitle).font(.caption).foregroundStyle(.secondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.right").foregroundStyle(.secondary)
                            }
                        }.buttonStyle(.plain)
                    }
                }.padding()
            }
            .navigationTitle("FlowiOS")
            .navigationDestination(item: $selected) { PlayerView(item: $0) }
        }
    }
}
