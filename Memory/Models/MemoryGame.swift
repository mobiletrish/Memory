//
//  MemoryGame.swift
//  Memory
//
//  Created by Patricia Fulk on 9/1/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent:Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter{ cards[$0].isFaceUp }.oneAndOnly }
        set { cards.indices.forEach{ cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    var score: Int {
        get {
            cards.indices.filter{ cards[$0].isMatched }.count - cards.indices.filter{ cards[$0].numberOfMismatches > 1 }.reduce(0, +)
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                } else {
                    cards[chosenIndex].numberOfMismatches += 1
                    cards[potentialMatchIndex].numberOfMismatches += 1
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2, numberOfMismatches: 0))
            cards.append(Card(content: content, id: pairIndex*2+1, numberOfMismatches: 0))
        }
        cards.shuffle()
    }
    
    struct Card:Identifiable {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        var id: Int
        var numberOfMismatches:Int
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
