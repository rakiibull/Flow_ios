import Foundation

struct MediaItem: Identifiable, Codable, Hashable {
    var id: String
    var title: String
    var creator: String
    var subtitle: String
    var mediaURLString: String?
    var thumbnailURLString: String?
    var isShort: Bool
    var addedAt: Date

    var mediaURL: URL? { mediaURLString.flatMap(URL.init(string:)) }
    var thumbnailURL: URL? { thumbnailURLString.flatMap(URL.init(string:)) }

    init(id: String = UUID().uuidString, title: String, creator: String = "Flow Tube", subtitle: String = "Recommended for you", mediaURLString: String? = nil, thumbnailURLString: String? = nil, isShort: Bool = false, addedAt: Date = .now) {
        self.id = id; self.title = title; self.creator = creator; self.subtitle = subtitle
        self.mediaURLString = mediaURLString; self.thumbnailURLString = thumbnailURLString
        self.isShort = isShort; self.addedAt = addedAt
    }

    static let samples: [MediaItem] = [
        .init(title: "Welcome to Flow Tube", creator: "Flow Tube", subtitle: "Your video space"),
        .init(title: "Explore videos you love", creator: "Flow Tube", subtitle: "Discover"),
        .init(title: "Music and more", creator: "Flow Tube", subtitle: "Listen and watch")
    ]
}
