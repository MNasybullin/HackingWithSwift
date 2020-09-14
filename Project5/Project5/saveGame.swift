//
//  saveGame.swift
//  Project5
//
//  Created by Stomach Diego on 9/14/20.
//  Copyright © 2020 Mansur Nasybullin. All rights reserved.
//

import UIKit

class saveGame: NSObject, Codable {
    var word = String()
    var usedWords = [String]()
    
    init (word: String, usedWords: [String]) {
        self.word = word
        self.usedWords = usedWords
    }
}
