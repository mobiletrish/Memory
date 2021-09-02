//
//  MemoryApp.swift
//  Memory
//
//  Created by Patricia Fulk on 9/1/21.
//

import SwiftUI

@main
struct MemoryApp: App {
    var body: some Scene {
        WindowGroup {
            let game = EmojiMemoryGame()
            MemoryGameView(viewModel: game)
        }
    }
}
