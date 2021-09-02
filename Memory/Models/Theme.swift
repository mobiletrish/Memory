//
//  Theme.swift
//  Memory
//
//  Created by Patricia Fulk on 9/1/21.
//

import Foundation

struct Theme {
    private(set) var name: String
    private(set) var emoji: Array<String>
    private(set) var color: String
    private(set) var numberOfPairsOfCardsToShow: Int
        
    init(name: String, emoji: Array<String>, numberOfPairsOfCardsToShow: Int, color: String)
    {
        self.name = name
        self.emoji = emoji
        self.color = color
        self.numberOfPairsOfCardsToShow = min(numberOfPairsOfCardsToShow,emoji.count)
    }
    
    static let themeTypes: Array<Theme> = [
        Theme(name: "Vehicles", emoji: ["🚔","🛴","🚞","🚡","🚖","🚛","🚚","🛻","🚗","🚕","🚓"], numberOfPairsOfCardsToShow: 1, color: "blue"),
        Theme(name: "Animals", emoji: ["🐶","🐥","🐙","🪱","🐤","🐸","🐺"], numberOfPairsOfCardsToShow: 20, color: "yellow"),
        Theme(name: "Faces", emoji: ["😀","😘","😗","😛","😎","🙁","😇","🥰","🥺"], numberOfPairsOfCardsToShow: 9, color: "red"),
        Theme(name: "Sports", emoji: ["⚽️","🏀","🏈","⚾️","🎾","🏉"], numberOfPairsOfCardsToShow: 6, color: "green"),
        Theme(name: "Flags", emoji: ["🏳️","🏴","🇦🇫","🇧🇴","🇨🇬","🇨🇰","🇨🇮","🇧🇾","🇧🇼","🇦🇿","🇧🇸"], numberOfPairsOfCardsToShow: 11, color: "orange"),
        Theme(name: "Food", emoji: ["🍏","🍎","🧇","🫒","🥩","🥨","🧀","🍖","🧈","🥬"], numberOfPairsOfCardsToShow: 10, color: "yellow"),
    ]
}
