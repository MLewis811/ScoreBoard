//
//  ContentView.swift
//  ScoreBoard
//
//  Created by Mike Lewis on 10/17/25.
//

import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @Binding var selectedItem: MediaItem?
    @State private var mediaItems: [MediaItem] = []
    @State private var viewerIsOpen = false
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    var body: some View {
        VStack {
            Button {
                if viewerIsOpen {
                    dismissWindow(id: "viewer-window")
                    viewerIsOpen = false
                } else {
                    openWindow(id: "viewer-window")
                    viewerIsOpen = true
                }
            } label: {
                if viewerIsOpen {
                    Label("Close Viewer", systemImage: "rectangle.portrait.and.arrow.right")
                } else {
                    Label("Open Viewer", systemImage: "rectangle.on.rectangle")
                }
            }
            .padding(.bottom, 5)
            
            HStack {
                Button("Select Media") {
                    selectMedia()
                }
                Spacer()
            }
            .padding()
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(mediaItems) { item in
                        Button {
                            selectedItem = item
                        } label: {
                            MediaThumbnailView(item: item)
                                .frame(width: 100, height: 100)
                                .cornerRadius(8)
                                .shadow(radius: 2)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            Spacer()
        }
        .frame(minWidth: 600, minHeight: 400)
    }
    
    func selectMedia() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = true
        panel.allowedContentTypes = [.image, .movie]
        panel.begin { response in
            if response == .OK {
                mediaItems = panel.urls.map { MediaItem(url: $0) }
                selectedItem = mediaItems.first
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
