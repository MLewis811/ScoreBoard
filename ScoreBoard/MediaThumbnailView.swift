//
//  MediaThumbnailView.swift
//  ScoreBoard
//
//  Created by Mike Lewis on 10/17/25.
//

import SwiftUI
import AVKit

struct MediaThumbnailView: View {
    let item: MediaItem
    @State private var thumbnailImage: NSImage?

    var body: some View {
        ZStack {
            if item.isVideo {
                if let image = thumbnailImage {
                    Image(nsImage: image)
                        .resizable()
                        .scaledToFill()
                } else {
                    Color.gray
                }
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 30))
                    .foregroundStyle(.white)
                    .shadow(radius: 4)
            } else if let image = NSImage(contentsOf: item.url) {
                Image(nsImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Color.gray
            }
        }
        .clipped()
        .task(id: item.url) {
            if item.isVideo && thumbnailImage == nil {
                await generateThumbnail(for: item.url)
            }
        }
    }
    
    func generateThumbnail(for url: URL) async {
        let asset = AVURLAsset(url: url)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        let time = CMTime(seconds: 0, preferredTimescale: 600)
        await withCheckedContinuation { continuation in
            generator.generateCGImageAsynchronously(for: time) { cgImage, actualTime, error in
                if let cgImage {
                    let image = NSImage(cgImage: cgImage, size: .zero)
                    DispatchQueue.main.async {
                        self.thumbnailImage = image
                        continuation.resume()
                    }
                } else {
                    DispatchQueue.main.async {
                        continuation.resume()
                    }
                }
            }
        }
    }

}
