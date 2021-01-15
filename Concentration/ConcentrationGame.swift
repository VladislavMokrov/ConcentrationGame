//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Влад on 19/10/2020.
//  Copyright © 2020 Влад. All rights reserved.
//

import Foundation

struct ConcentrationGame {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    }else{
                        return nil //1*
                    }
                }
            }
            return foundIndex
        }
        set {
            for  index in cards.indices {
                cards[index].isFaceUp = (index == newValue) //2*
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchingIndex = indexOfOneAndOnlyFaceUpCard, matchingIndex != index {
                if cards[matchingIndex] == cards[index] {
                    cards[matchingIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                //1* indexOfOneAndOnlyFaceUpCard = nil (учтено выше в геттере)
            }else{
/*                for flipDown in cards.indices {
                    cards[flipDown].isFaceUp = false
                }
                cards[index].isFaceUp = true */ //2* это происходит выше в сеттере
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "ConcentrationGam.init(\(numberOfPairsOfCards): must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards.append(card)
            cards.append(card)
            //или cards += [card, card]
        }
        if cards != nil {
            cards.shuffle()
        }
        }
    }
