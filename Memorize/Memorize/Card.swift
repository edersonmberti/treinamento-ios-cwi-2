//
//  Card.swift
//  Memorize
//
//  Created by Ederson Machado Berti on 07/06/21.
//

import Foundation

struct Card<T> : Equatable {
    let identifier: Int
    var isFaceUp = false
    var isMatched = false
    var content: T
    
    static func == (lhs: Card<T>, rhs: Card<T>) -> Bool {
        lhs.identifier == rhs.identifier
    }
}
