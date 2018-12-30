//
//  Concentration.swift
//  Concentration
//
//  Created by davida on 12/27/18.
//  Copyright © 2018 davida. All rights reserved.
//

import Foundation
import GameplayKit

struct Concentration
{
    var cards = [Card]()
    var theme = Theme()
    var emoji: Dictionary<Int, String> = [:]
    var flipCount = 0
    var score = 0

    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        self.theme = Theme()
        shuffleCards()
    }
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            flipCount += 1
            //Subtract one point if they've seen this card already
            score += cards[index].isAlreadyRevealed ? -1 : 0
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    //Two points for a match
                    score += 2;
                }
                cards[index].isFaceUp = true
            } else {
                //either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
            //Remember that we've seen this card
            cards[index].isAlreadyRevealed = true
        }
    }
    
    mutating func shuffleCards() {
        // Get a new "shuffled" sequence
        let shuffled = GKShuffledDistribution(forDieWithSideCount: cards.count)
        let originalCards = cards
        for index in 0..<originalCards.count {
            let shuffledIndex = shuffled.nextInt() - 1
            cards[index] = originalCards[shuffledIndex]
        }
    }
    
}
