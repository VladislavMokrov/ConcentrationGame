//
//  ViewController.swift
//  Concentration
//
//  Created by Влад on 19/10/2020.
//  Copyright © 2020 Влад. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   private lazy var game = ConcentrationGame(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return buttonCollection.count / 2 // тут убрал count +1
    }
    
    private func updateTouches() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.red
        ]
        let attributedString = NSAttributedString(string: "Touches: \(touches)", attributes: attributes)
         touchLabel.attributedText = attributedString
    }
    
    private(set) var touches = 0 {
        didSet{
            updateTouches()
        }
    }
    
//    private var emojiCollection = ["🦊", "🐵", "🐸", "🐷", "🦁", "🐯", "🐨", "🐼", "🐻", "🐰", "🐭", "🐶"]
    private var emojiCollection = "🦊🐵🐸🐷🦁🐯🐨🐼🐻🐰🐭🐶"
    
    private var emojiDictionary = [Card:String]()
    
    private func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card] == nil {
            let randomStringIndex = emojiCollection.index(emojiCollection.startIndex, offsetBy: emojiCollection.count.arc4radomExtension)
            emojiDictionary[card] = String (emojiCollection.remove(at: randomStringIndex))
        }
 /*       if emojiDictionary[card.identifier] != nil {
            return emojiDictionary[card.identifier]!
        }else{
            return "?"
        } */
//все что закоменчено выше, обшинал байндинг, можно заменить этой строкой
        return emojiDictionary[card] ?? "?"
    }
    
    private func updateViewFromModel() {
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
            }
        }
    }
    
    @IBOutlet private var buttonCollection: [UIButton]!
    @IBOutlet private weak var touchLabel: UILabel! {
        didSet {
            updateTouches()
        }
    }
    @IBAction private func buttonAction(_ sender: UIButton) {
        touches += 1
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
        }
    }
}

extension Int {
    var arc4radomExtension: Int {
        if self > 0 {
           return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
          return -Int(arc4random_uniform(UInt32(abs(self)))) // abs - это абсолютное значение, всегда положительное
        } else {
            return 0
        }
    }
}
