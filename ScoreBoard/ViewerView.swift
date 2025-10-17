//
//  ViewerView.swift
//  ScoreBoard
//
//  Created by Mike Lewis on 10/17/25.
//

import SwiftUI
import AVKit

struct ViewerView: View {
    @Binding var selectedItem: MediaItem?
    
    var body: some View {
        ZStack {
            if let item = selectedItem {
                if item.isVideo {
                    VideoPlayer(player: AVPlayer(url: item.url))
                        .aspectRatio(contentMode: .fit)
                } else if let image = NSImage(contentsOf: item.url) {
                    Image(nsImage: image)
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("Unable to load media")
                        .foregroundStyle(.secondary)
                }
            } else {
                Text("No media selected")
                    .foregroundStyle(.secondary)
            }
        }
        .frame(minWidth: 600, minHeight: 400)
        .background(Color(NSColor.windowBackgroundColor))
    }
}

//#Preview {
//    ViewerView()
//}
