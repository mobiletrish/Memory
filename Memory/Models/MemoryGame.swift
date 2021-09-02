//
//  MemoryGame.swift
//  Memory
//
//  Created by Patricia Fulk on 9/1/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent:Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    cards[chosenIndex].numberOfMismatches += 1
                    if cards[chosenIndex].numberOfMismatches > 1 {
                        score -= 1
                    }
                    
                    cards[potentialMatchIndex].numberOfMismatches += 1
                    if cards[potentialMatchIndex].numberOfMismatches > 1 {
                        score -= 1
                    }
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2, numberOfMismatches: 0))
            cards.append(Card(content: content, id: pairIndex*2+1, numberOfMismatches: 0))
        }
        cards.shuffle()
        score = 0
    }
    
    struct Card:Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
        var numberOfMismatches:Int
    }
}

