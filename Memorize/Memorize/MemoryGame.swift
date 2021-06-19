//
//  MemoryGame.swift
//  Memorize
//
//  Created by Ederson Machado Berti on 07/06/21.
//

import Foundation

class MemoryGame<T> {
    
    private(set) var cards: [Card<T>] = []
    private(set) var finish = false
    private(set) var attempts = 0
    
    private var indexOfFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        guard !cards[index].isFaceUp else { return }
        
        if indexOfFaceUpCard == nil {
            flipDownAllCards(except: index)
            indexOfFaceUpCard = index
        } else {
            let itsAMatch = cards[index] == cards[indexOfFaceUpCard!]
            
            cards[indexOfFaceUpCard!].isMatched = itsAMatch
            cards[index].isMatched = itsAMatch
            cards[index].isFaceUp = true
            indexOfFaceUpCard = nil
            attempts += 1
        }
        
        finish = allCardsMatched()
    }
    
    private func flipDownAllCards(except index: Int) {
        for cardIndex in cards.indices {
            cards[cardIndex].isFaceUp = cardIndex == index
        }
    }
    
    private func allCardsMatched() -> Bool {
        cards.filter { !$0.isMatched }.isEmpty
    }
    
    init(of contents: [T]) {
        for index in contents.indices {
            let card = Card<T>(identifier: index, content: contents[index])
            
            cards.append(contentsOf: [card, card])
        }
        
        cards.shuffle()
    }
}
