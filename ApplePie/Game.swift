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
    var openLetters: [Int]
    var isOver = false
    var isWin = false
    var gamesPlayed = 0
    var gamesWon = 0
    var theme: GameTheme
    
    private var dictionary: [String]
    
    init() {
        difficulty = .easy
        turnsLeft = difficulty.maxTurns

        theme = GameTheme.random()
        
        dictionary = theme.words.shuffled()
        
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
        openLetters = []
        
        if gamesPlayed == dictionary.count {
            theme = GameTheme.random()
            dictionary = theme.words.shuffled()
            
            word = Word(dictionary[0])
        }
        else {
            word = Word(dictionary[gamesPlayed % dictionary.count])
        }
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
            letters.append(Letter(label: String(c), tag: n, isHidden: "QWERTYUIOPASDFGHJKLZXCVBNM".contains(c)))
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

enum GameTheme {
    case states
    case cars
    case cities
    
    var name: String {
        switch self {
        case .states: return "US state 🇺🇸"
        case .cars: return "Car brand 🚙"
        case .cities: return "Olympic Games host city 🥇"
        }
    }
    
    var words: [String] {
        switch self {
        case .states: return ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
        case .cars: return ["Toyota", "Honda", "Chevrolet", "Ford", "Mercedes-Benz", "Jeep", "BMW", "Porsche", "Subaru", "Nissan", "Cadillac", "Volkswagen", "Lexus", "Audi", "Ferrari", "Volvo", "Jaguar", "GMC", "Buick", "Acura", "Bentley", "Dodge", "Hyundai", "Lincoln", "Mazda", "Land Rover", "Tesla", "Ram Trucks", "Kia", "Chrysler", "Pontiac", "Infiniti", "Mitsubishi", "Oldsmobile", "Maserati", "Aston Martin", "Bugatti", "Fiat", "Mini", "Alfa Romeo", "Saab", "Genesis", "Suzuki", "Studebaker", "Renault", "Peugeot", "Daewoo", "Hudson", "Citroen"]
        case .cities: return ["Athens", "Paris", "London", "Stockholm", "Antwerp", "Amsterdam", "Los Angeles", "Berlin", "Helsinki", "Melbourne", "Rome", "Tokyo", "Montreal", "Moscow", "Barcelona", "Atlanta", "Sydney", "Beijing", "Chamonix", "Lake Placid", "Oslo", "Innsbruck", "Grenoble", "Sapporo", "Sarajevo", "Calgary", "Albertville", "Lillehammer", "Nagano", "Turin", "Vancouver", "Sochi", "Pyeongchang", "Milan"]
        }
    }
    static func random() -> GameTheme {
        return [GameTheme.states, GameTheme.cars, GameTheme.cities].randomElement()!
    }
}

