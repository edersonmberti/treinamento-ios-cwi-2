//
//  MemorizeViewController.swift
//  Memorize
//
//  Created by Ederson Machado Berti on 06/06/21.
//

import UIKit

class MemorizeViewController: UIViewController {
    
    private lazy var memoryGame = MemoryGame<String>(of: classImages)
    
    @IBOutlet var cardViews: [UIView]!
    @IBOutlet var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    @IBAction func cardPressed(_ sender: UIButton) {
        memoryGame.chooseCard(at: cardButtons.firstIndex(of: sender)!)
        
        updateUI()
    }
    
    @IBAction func restartPressed(_ sender: Any) {
        newGame()
    }
    
    private func newGame() {
        memoryGame = MemoryGame<String>(of: classImages)
        setupLayout()
        updateUI()
    }
    
    private func updateUI() {
        for index in cardButtons.indices {
            let card = memoryGame.cards[index]
            
            if card.isFaceUp {
                flipOver(at: index)
            } else if card.isMatched {
                matchCard(at: index)
            } else {
                flipDown(at: index)
            }
        }
        
        if memoryGame.finish {
            notifyEndGame()
        }
    }
    
    private func notifyEndGame() {
        let alert = UIAlertController(title: "Boa, você terminou!",
                                      message: "Você precisou de \(memoryGame.attempts) tentativas para finalizar o jogo",
                                      preferredStyle: .alert)
        let playAgainAction = UIAlertAction(title: "Bacana, bora de novo", style: .default) { _ in self.newGame() }
        
        
        alert.addAction(playAgainAction)
        
        present(alert, animated: true)
    }
    
    private func setupLayout() {
        cardViews.forEach { card in
            card.layer.shadowColor = UIColor.black.cgColor
            card.layer.shadowOffset = .zero
            card.layer.shadowRadius = 4
            card.layer.shadowOpacity = 0.3
            card.layer.cornerRadius = 8
        }
        
        cardButtons.forEach { button in
            button.isHidden = false
        }
    }
}

extension MemorizeViewController {
    
    func flipOver(at index: Int) {
        let button = cardButtons[index]
        let card = memoryGame.cards[index]

        button.setImage(UIImage(named: card.content), for: .normal)
    }
    
    func matchCard(at index: Int) {
        let view = cardViews[index]
        let button = cardButtons[index]
        
        view.layer.shadowColor = UIColor.clear.cgColor
        button.isHidden = true
    }
    
    func flipDown(at index: Int) {
        let button = cardButtons[index]

        button.setImage(UIImage(named: "card-default"), for: .normal)
    }
}

let classImages = ["knight", "wizard", "barbarian", "witch", "cleric"]
