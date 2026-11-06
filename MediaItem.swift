import Foundation

struct MediaItem: Identifiable, Hashable {
    let id: UUID
    let title: String
    let creator: String
    let subtitle: String
    let imageName: String
    let mediaURL: URL?

    init(id: UUID = UUID(), title: String, creator: String, subtitle: String = "Recommended for you", imageName: String = "play.rectangle", mediaURL: URL? = nil) {
        self.id = id
        self.title = title
        self.creator = creator
        self.subtitle = subtitle
        self.imageName = imageName
        self.mediaURL = mediaURL
    }

    static let samples = [
        MediaItem(title: "Discover something new", creator: "FlowiOS", subtitle: "Sample video"),
        MediaItem(title: "Music for your day", creator: "FlowiOS", subtitle: "Sample music"),
        MediaItem(title: "Explore the world", creator: "FlowiOS", subtitle: "Travel")
    ]
}
