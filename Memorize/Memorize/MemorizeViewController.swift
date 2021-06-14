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
    @IBOutlet weak var restartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    @IBAction func cardPressed(_ sender: UIButton) {
        let buttonIndex = cardButtons.firstIndex(of: sender)!
        memoryGame.chooseCard(at: buttonIndex)
        
        updateUI()
    }
    
    @IBAction func restartPressed(_ sender: Any) {
        newGame()
    }
    
    private func newGame() {
        memoryGame = MemoryGame<String>(of: classImages)
        updateUI()
    }
    
    private func updateUI() {
        for index in cardButtons.indices {
            var image: UIImage?
            let button = cardButtons[index]
            let card = memoryGame.cards[index]
            let view = cardViews[index]
            
            if card.isFaceUp {
                image = UIImage(named: card.content)
                button.setImage(image, for: .normal)
                button.isHidden = false
                view.layer.shadowColor = UIColor.black.cgColor
            } else if card.isMatched {
                view.layer.shadowColor = UIColor.clear.cgColor
                button.isHidden = true
            } else {
                image = UIImage(named: "card-default")
                button.setImage(image, for: .normal)
                button.isHidden = false
                view.layer.shadowColor = UIColor.black.cgColor
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
        restartButton.semanticContentAttribute = .forceRightToLeft
        
        cardViews.forEach { card in
            card.layer.shadowColor = UIColor.black.cgColor
            card.layer.shadowOffset = .zero
            card.layer.shadowRadius = 4
            card.layer.shadowOpacity = 0.3
            card.layer.cornerRadius = 8
        }
    }
}

let classImages = ["knight", "wizard", "barbarian", "witch", "cleric"]
