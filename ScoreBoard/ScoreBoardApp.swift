//
//  ScoreBoardApp.swift
//  ScoreBoard
//
//  Created by Mike Lewis on 10/17/25.
//

import SwiftUI

@main
struct ScoreBoardApp: App {
    // The selected item is shared between both windows
    @State private var selectedItem: MediaItem? = nil
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    var body: some Scene {
        // Main window: for selection
        WindowGroup("Media Browser") {
            ContentView(selectedItem: $selectedItem)
        }

        // Viewer window: always reflects the selected item
        WindowGroup("Viewer") {
            ViewerView(selectedItem: $selectedItem)
        }
        .id("viewer-window")
    }
}
