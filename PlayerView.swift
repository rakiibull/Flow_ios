import SwiftUI
import AVKit

struct PlayerView: View {
    let item: MediaItem
    @EnvironmentObject private var library: LibraryStore
    @State private var player: AVPlayer?
    @State private var status = ""
    @State private var isDownloading = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Group {
                        if let player { VideoPlayer(player: player).frame(height: 235) }
                        else { RoundedRectangle(cornerRadius: 14).fill(Color.white.opacity(0.10)).frame(height: 235).overlay(Image(systemName: "play.circle").font(.system(size: 55))) }
                    }
                    Text(item.title).font(.title2.bold())
                    Text(item.creator).foregroundStyle(.secondary)
                    HStack(spacing: 12) {
                        Button { library.toggleSaved(item) } label: { Label(library.isSaved(item) ? "Saved" : "Save", systemImage: library.isSaved(item) ? "bookmark.fill" : "bookmark") }.buttonStyle(.borderedProminent)
                        Button { download() } label: { Label(isDownloading ? "Downloading…" : "Download", systemImage: "arrow.down.circle") }.buttonStyle(.bordered)
                            .disabled(isDownloading || item.mediaURL == nil)
                    }
                    if !status.isEmpty { Text(status).font(.footnote).foregroundStyle(.secondary) }
                    Text("Related videos").font(.headline).padding(.top, 8)
                }.padding()
            }.navigationTitle("Now playing").navigationBarTitleDisplayMode(.inline)
        }
        .task {
            library.addToHistory(item)
            if let url = item.mediaURL { player = AVPlayer(url: url) }
        }
        .onDisappear { player?.pause() }
        .preferredColorScheme(.dark)
    }

    private func download() {
        guard let url = item.mediaURL else { return }
        isDownloading = true; status = "Starting download…"
        URLSession.shared.downloadTask(with: url) { temporaryURL, _, error in
            Task { @MainActor in
                defer { isDownloading = false }
                guard let temporaryURL, error == nil else { status = "Download failed. Check the link and try again."; return }
                do {
                    let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("FlowDownloads", isDirectory: true)
                    try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
                    let destination = folder.appendingPathComponent(url.lastPathComponent.isEmpty ? UUID().uuidString + ".mp4" : url.lastPathComponent)
                    if FileManager.default.fileExists(atPath: destination.path) { try FileManager.default.removeItem(at: destination) }
                    try FileManager.default.moveItem(at: temporaryURL, to: destination)
                    let saved = MediaItem(id: item.id, title: item.title, creator: item.creator, subtitle: "Downloaded", mediaURLString: destination.absoluteString)
                    library.addDownload(saved); status = "Downloaded to Flow Tube Library."
                } catch { status = "Could not save downloaded file." }
            }
        }.resume()
    }
}
