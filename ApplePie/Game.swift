//
//  Game.swift
//  ApplePie
//
//  Created by YURY PROSVIRNIN on 07.04.2021.
//

import Foundation

struct Game {
    var turnsLeft: Int
    var difficulty: GameDifficulty
    var word: Word
    var dictionary: [String]
    var openLetters: [Int]
    var isOver = false
    var isWin = false
    var gamesPlayed = 0
    var gamesWon = 0
    
    init() {
        difficulty = .easy
        turnsLeft = difficulty.maxTurns

        dictionary = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"].shuffled()
        
        word = Word(dictionary[0])
        
        openLetters = []
    }
    
    mutating func checkLetter(_ letter: String) {
        
        var newOpenLetters = [Int]()
        if let elements = word.contains(letter) {
            for index in elements {
                word.letters[index].isHidden = false
                newOpenLetters.append(index)
            }
        }
        openLetters = newOpenLetters
        
        if openLetters.count == 0 {
            turnsLeft -= 1
        }
        
        if turnsLeft == 0 {
            isOver = true
        }
        
        if word.letters.firstIndex(where: {$0.isHidden}) == nil {
            isWin = true
            gamesWon += 1
        }
    }
    
    mutating func newGame() {
        gamesPlayed += 1
        turnsLeft = difficulty.maxTurns
        isOver = false
        isWin = false
        word = Word(dictionary[gamesPlayed])
        openLetters = []
    }
}

struct Letter {
    var label: String
    var tag: Int
    var isHidden: Bool
}

struct Word {
    var name: String
    var letters: [Letter]
    
    init(_ string: String) {
        name = string.uppercased()
        letters = [Letter]()

        for (n, c) in name.enumerated() {
            letters.append(Letter(label: String(c), tag: n, isHidden: String(c) != " "))
        }
    }
    
    func contains(_ element: String) -> [Int]? {
        
        if name.contains(element) {
            var result = [Int]()
            for (n, c) in letters.enumerated() {
                if c.label == element {
                    result.append(n)
                }
            }
            return result
        }
        else {
            return nil
        }
    }
}



enum GameDifficulty {
    case easy
    case medium
    case expert

    var maxTurns: Int {
        switch self {
        case .easy: return 7
        case .medium: return 6
        case .expert: return 5
        }
    }
}
