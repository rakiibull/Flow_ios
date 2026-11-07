import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var library: LibraryStore
    @State private var selected: MediaItem?
    @State private var showAdd = false
    @State private var filter = "For you"
    private let filters = ["For you", "Music", "Gaming", "News", "Live"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(filters, id: \.self) { value in
                                Button(value) { filter = value }
                                    .font(.subheadline.weight(.semibold))
                                    .padding(.horizontal, 15).padding(.vertical, 9)
                                    .background(filter == value ? Color.white : Color.white.opacity(0.10))
                                    .foregroundStyle(filter == value ? Color.black : Color.white)
                                    .clipShape(Capsule())
                            }
                        }.padding(.horizontal)
                    }
                    ForEach(library.feed) { item in
                        Button { selected = item } label: { VideoFeedCard(item: item) }
                            .buttonStyle(.plain)
                    }
                }.padding(.vertical, 8)
            }
            .background(Color.black)
            .navigationTitle("Flow Tube")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { showAdd = true } label: { Image(systemName: "plus.circle.fill").font(.title2) }
                }
            }
            .sheet(item: $selected) { PlayerView(item: $0) }
            .sheet(isPresented: $showAdd) { AddVideoSheet() }
        }
        .preferredColorScheme(.dark)
    }
}

struct VideoFeedCard: View {
    let item: MediaItem
    var body: some View {
        VStack(alignment: .leading, spacing: 9) {
            ZStack {
                RoundedRectangle(cornerRadius: 14).fill(Color.white.opacity(0.10))
                if let url = item.thumbnailURL {
                    AsyncImage(url: url) { image in image.resizable().scaledToFill() } placeholder: { Image(systemName: "play.rectangle.fill").font(.largeTitle).foregroundStyle(.white.opacity(0.55)) }
                        .frame(height: 205).clipped().clipShape(RoundedRectangle(cornerRadius: 14))
                } else {
                    Image(systemName: "play.rectangle.fill").font(.system(size: 46)).foregroundStyle(.white.opacity(0.65))
                }
            }.frame(height: 205).padding(.horizontal, 12)
            HStack(alignment: .top, spacing: 11) {
                Circle().fill(Color.pink.opacity(0.9)).frame(width: 38, height: 38).overlay(Text(String(item.creator.prefix(1))).bold())
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title).font(.headline).foregroundStyle(.white).multilineTextAlignment(.leading)
                    Text("\(item.creator) · \(item.subtitle)").font(.caption).foregroundStyle(.white.opacity(0.58))
                }
                Spacer()
                Image(systemName: "ellipsis").foregroundStyle(.white.opacity(0.7))
            }.padding(.horizontal, 14).padding(.bottom, 8)
        }
    }
}

struct AddVideoSheet: View {
    @EnvironmentObject private var library: LibraryStore
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var url = ""
    @State private var error = ""
    var body: some View {
        NavigationStack {
            Form {
                Section("Add a video link") {
                    TextField("Video title", text: $title)
                    TextField("Direct video URL (.mp4, .m4v, .mov)", text: $url).keyboardType(.URL).textInputAutocapitalization(.never)
                    if !error.isEmpty { Text(error).foregroundStyle(.red) }
                    Button("Add to Flow Tube") {
                        guard let parsed = URL(string: url), ["http", "https"].contains(parsed.scheme?.lowercased() ?? ""), ["mp4", "m4v", "mov"].contains(parsed.pathExtension.lowercased()) else { error = "Enter a direct, supported video-file URL."; return }
                        library.add(MediaItem(title: title.isEmpty ? "My video" : title, creator: "Added by you", mediaURLString: parsed.absoluteString))
                        dismiss()
                    }
                }
                Section { Text("Only add media you own or are authorized to access. This does not extract videos from YouTube or bypass platform restrictions.").font(.footnote).foregroundStyle(.secondary) }
            }.navigationTitle("Add video").toolbar { ToolbarItem(placement: .topBarTrailing) { Button("Done") { dismiss() } } }
        }.preferredColorScheme(.dark)
    }
}
