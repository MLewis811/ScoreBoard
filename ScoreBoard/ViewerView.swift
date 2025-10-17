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
    @StateObject private var playerManager = PlayerManager()
    
    var body: some View {
        ZStack {
            if let item = selectedItem {
                if item.isVideo {
                    VideoPlayer(player: playerManager.player)
                        .aspectRatio(contentMode: .fill)
                        .onChange(of: item.url) { oldValue, newValue in
                            playerManager.loadVideo(url: newValue)
                        }
                        .onAppear {
                            playerManager.loadVideo(url: item.url)
                        }
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
    }
}

//#Preview {
//    ViewerView()
//}
