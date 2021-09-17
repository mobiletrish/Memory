//
//  EmojiMemoryGame.swift
//  Memory
//
//  Created by Patricia Fulk on 9/1/21.
//

import SwiftUI

class EmojiMemoryGame : ObservableObject {
    typealias Card = MemoryGame<String>.Card
    static func createMemoryGame(_ theme: Theme) -> MemoryGame<String> {
        let emoji = Array(Set(theme.emoji)).shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCardsToShow) { pairIndex in
            emoji[pairIndex]
        }
    }
        
    @Published private var model: MemoryGame<String>
    
    private(set) var theme: Theme
    
    init(theme: Theme? = nil) {
        self.theme = theme ?? Theme.themeTypes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(self.theme)
    }
    
    var cards: Array<Card> {
        model.cards
    }
    
    var score: String {
        String(model.score)
    }
        
    // MARK: - Intent(s)
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func newGame()
    {
        theme = Theme.themeTypes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme)
    }
}
