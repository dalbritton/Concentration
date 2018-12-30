//
//  Theme.swift
//  Concentration
//
//  Created by davida on 12/27/18.
//  Copyright © 2018 davida. All rights reserved.
//

import Foundation

class Theme {
    var name: String?
    var emojiChoices: [String]?
    
    static var library: [(name: String, emojiChoices:[String])] = [
        //Define as many lines of emoji as desired
        ("Halloween", ["🎃","👻","🦇","🕷","🕸","👾","👹","😼","👽","🤖"]),
        ("Oceans", ["🧜‍♀️", "🧜‍♂️", "👙", "🕶", "🐌", "🐚", "🐡", "🐬", "🌴", "🌊"]),
        ("Smilies", ["😃", "🙃", "😍", "😎", "🤓", "🤪", "😢", "🙄", "😬", "🤠"]),
        ("Travel", ["🚕", "🚌", "🏍", "🛵", "🛩", "🚂", "🚁", "⛵️", "🛶", "🚲"]),
        ("Food", ["🍎", "🥨", "🍋", "🌽", "🥓", "🥩", "🍔", "🌮", "🍦", "🍹"]),
        ("Sports", ["⚽️", "🏈", "🎱", "🏓", "🏒", "⛳️", "⛷", "🏄‍♂️", "🏌️‍♂️", "⛸"]),
        ("Animals", ["🐰", "🦁", "🐯", "🦆", "🦉", "🐷", "🐒", "🐻", "🐼", "🐶"]),
    ]

    init() {
        self.pickRandom()
    }
    
    func pickRandom() {
        //Randomly pick a theme
        let randomIndex = Int(arc4random_uniform(UInt32(Theme.library.count)))
        self.name = Theme.library[randomIndex].name
        self.emojiChoices = Theme.library[randomIndex].emojiChoices
    }
}
