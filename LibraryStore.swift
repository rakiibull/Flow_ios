import Foundation

@MainActor
final class LibraryStore: ObservableObject {
    @Published private(set) var saved: [MediaItem] = []
    @Published private(set) var history: [MediaItem] = []

    private let savedKey = "flowios.saved"
    private let historyKey = "flowios.history"

    init() {
        // Starter keeps in-memory model data. Persistent model encoding can be added next.
    }

    func toggleSaved(_ item: MediaItem) {
        if saved.contains(item) { saved.removeAll { $0 == item } }
        else { saved.insert(item, at: 0) }
    }

    func addToHistory(_ item: MediaItem) {
        history.removeAll { $0 == item }
        history.insert(item, at: 0)
    }

    func isSaved(_ item: MediaItem) -> Bool { saved.contains(item) }
}
