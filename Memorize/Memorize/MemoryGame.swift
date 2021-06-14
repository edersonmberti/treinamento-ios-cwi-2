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
        let cardsFaceUp = cards.filter { $0.isFaceUp }
                
        if index == indexOfFaceUpCard { return }
        
        if cardsFaceUp.isEmpty {
            cards[index].isFaceUp = true
            indexOfFaceUpCard = index
        } else if cardsFaceUp.count == 1 {
            if cards[index].identifier == cardsFaceUp.first!.identifier {
                cards[index].isFaceUp = true
                cards[index].isMatched = true
                cards[indexOfFaceUpCard!].isMatched = true
                
                indexOfFaceUpCard = nil
            } else {
                cards[index].isFaceUp = true
                indexOfFaceUpCard = index
            }
            
            attempts += 1
        } else {
            for i in cards.indices {
                cards[i].isFaceUp = i == index
            }
            
            indexOfFaceUpCard = index
        }
        
        finish = cards.filter { !$0.isMatched }.isEmpty
    }
    
    init(of contents: [T]) {
        for index in contents.indices {
            let card = Card<T>(content: contents[index], identifier: index)
    
            cards.append(contentsOf: [card, card])
        }
        
//        cards.shuffle()
    }
}
