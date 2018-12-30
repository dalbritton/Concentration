//
//  ViewController.swift
//  Concentration
//
//  Created by davida on 12/26/18.
//  Copyright © 2018 davida. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    var flipCount = 0 {
        didSet { flipCountLabel.text = "Flips: \(flipCount)" }
    }
    var score = 0 {
        didSet { scoreLabel.text = "Score: \(score)" }
    }
    
    @IBOutlet weak var themeNameLabel: UILabel!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
        
    }
    
    @IBAction func newGameButton(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        themeNameLabel.text = game.theme.name
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        flipCount = game.flipCount
        score = game.score
    }
    
    func emoji(for card: Card) -> String {
        if game.emoji[card.identifier] == nil, game.theme.emojiChoices!.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(game.theme.emojiChoices!.count)))
            game.emoji[card.identifier] = game.theme.emojiChoices!.remove(at: randomIndex)
        }
        return game.emoji[card.identifier] ?? "?"
    }
    
}
