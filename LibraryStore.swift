import Foundation
import Combine

@MainActor
final class LibraryStore: ObservableObject {
    @Published private(set) var saved: [MediaItem] = []
    @Published private(set) var history: [MediaItem] = []
    @Published private(set) var downloads: [MediaItem] = []
    @Published private(set) var feed: [MediaItem] = MediaItem.samples

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private func file(_ name: String) -> URL {
        FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0].appendingPathComponent(name)
    }
    init() {
        try? FileManager.default.createDirectory(at: file("..").deletingLastPathComponent(), withIntermediateDirectories: true)
        saved = load("saved.json") ?? []
        history = load("history.json") ?? []
        downloads = load("downloads.json") ?? []
        feed = load("feed.json") ?? MediaItem.samples
    }
    private func load(_ name: String) -> [MediaItem]? {
        guard let data = try? Data(contentsOf: file(name)) else { return nil }
        return try? decoder.decode([MediaItem].self, from: data)
    }
    private func persist(_ values: [MediaItem], _ name: String) {
        guard let data = try? encoder.encode(values) else { return }
        try? data.write(to: file(name), options: .atomic)
    }
    func add(_ item: MediaItem) { feed.insert(item, at: 0); persist(feed, "feed.json") }
    func toggleSaved(_ item: MediaItem) {
        if saved.contains(where: { $0.id == item.id }) { saved.removeAll { $0.id == item.id } }
        else { saved.insert(item, at: 0) }
        persist(saved, "saved.json")
    }
    func isSaved(_ item: MediaItem) -> Bool { saved.contains { $0.id == item.id } }
    func addToHistory(_ item: MediaItem) {
        history.removeAll { $0.id == item.id }; history.insert(item, at: 0)
        persist(history, "history.json")
    }
    func addDownload(_ item: MediaItem) {
        downloads.removeAll { $0.id == item.id }; downloads.insert(item, at: 0)
        persist(downloads, "downloads.json")
    }
    func removeDownload(_ item: MediaItem) {
        downloads.removeAll { $0.id == item.id }; persist(downloads, "downloads.json")
    }
}
