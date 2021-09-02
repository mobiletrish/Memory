//
//  MemoryGameView.swift
//  Memory
//
//  Created by Patricia Fulk on 9/1/21.
//

import SwiftUI

struct MemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        
        VStack {
            VStack {
                Text(viewModel.theme.name)
                    .font(.largeTitle)
                Text("Score: " + viewModel.score)
            }
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(.green)
            .padding(.horizontal)
            Spacer()
            newGameButton
            Spacer()
        }
    }
    // 10. add new game button
    var newGameButton: some View {
        Button(action: {
            viewModel.newGame()
        }, label: {
          Text("New Game")
            .foregroundColor(.black)
        })
        .buttonStyle(RoundedRectangleButtonStyle())
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

struct RoundedRectangleButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      Spacer()
      configuration.label.foregroundColor(.black)
      Spacer()
    }
    .padding()
    .background(Color.gray.cornerRadius(20))
    .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}


struct MemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        MemoryGameView(viewModel: game)
    }
}
