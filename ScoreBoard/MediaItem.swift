//
//  MediaItem.swift
//  ScoreBoard
//
//  Created by Mike Lewis on 10/17/25.
//

import SwiftUI

struct MediaItem: Identifiable, Hashable {
    let id = UUID()
    let url: URL
    
    var isVideo: Bool {
        ["mp4", "mov", "m4v"].contains(url.pathExtension.lowercased())
    }
}
