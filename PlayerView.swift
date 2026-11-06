import SwiftUI
import AVKit

struct PlayerView: View {
    let item: MediaItem
    @EnvironmentObject private var library: LibraryStore
    var body: some View {
        VStack(spacing: 20) {
            if let url = item.mediaURL {
                VideoPlayer(player: AVPlayer(url: url)).frame(height: 240)
            } else {
                RoundedRectangle(cornerRadius: 18)
                    .fill(.white.opacity(0.10))
                    .frame(height: 240)
                    .overlay VStack(spacing: 10) {
                        Image(systemName: "play.circle").font(.system(size: 54))
                        Text("Add an authorized media URL to enable playback")
                            .font(.caption).foregroundStyle(.secondary)
                    }
            }
            Text(item.title).font(.title2.bold())
            Text(item.creator).foregroundStyle(.secondary)
            Button {
                library.toggleSaved(item)
            } label: {
                Label(library.isSaved(item) ? "Saved" : "Save to Library",
                      systemImage: library.isSaved(item) ? "bookmark.fill" : "bookmark")
            }
            Spacer()
        }.padding().navigationTitle("Now Playing")
            .onAppear { library.addToHistory(item) }
    }
}
