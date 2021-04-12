//
//  ViewController.swift
//  ApplePie
//
//  Created by YURY PROSVIRNIN on 05.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet weak var lettersStackView: UIStackView!
    @IBOutlet weak var guessWordStackView: UIStackView!
    
    var game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        startNewGame()
    }
    
    func startNewGame() {
        
        treeImageView.image = UIImage(named: "Tree\(game.turnsLeft)")
        
        for element in guessWordStackView.arrangedSubviews {
            element.removeFromSuperview()
        }
        
        let guessLabel = UILabel()
        guessLabel.text = "Try to guess the name of state!"
        guessLabel.textColor = .black
        guessWordStackView.addArrangedSubview(guessLabel)
        
        let row = UIStackView()
        row.axis = .horizontal
        row.alignment = .fill
        row.distribution = .fillEqually
        row.spacing = 8
  
        guessWordStackView.addArrangedSubview(row)
        
        createWord(word: game.word, stackView: row)
        
        for element in lettersStackView.arrangedSubviews {
            element.removeFromSuperview()
        }
        
        for line in ["QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"]{
            
            let row = UIStackView()
            row.axis = .horizontal
            row.alignment = .fill
            row.distribution = .fillEqually
            row.spacing = 8
            lettersStackView.addArrangedSubview(row)
            
            createButtons(letters: line, stackView: row)
        }
        
        let lettersLabel = UILabel()
        lettersLabel.text = "Games played - \(game.gamesPlayed) won - \(game.gamesWon)"
        lettersLabel.textColor = .black
        lettersStackView.addArrangedSubview(lettersLabel)
        
    }
    
    func createWord(word: Word, stackView: UIStackView) {
        for letter in word.letters {
            if letter.label == " " {
                let label = UILabel()
                label.text = " "
                
                stackView.addArrangedSubview(label)
            }
            else {
                let button = UIButton(type: .roundedRect)
                button.setTitle(letter.isHidden ? " " : letter.label, for: [])
                button.titleLabel?.font = .systemFont(ofSize: 20)
                button.tag = letter.tag
                
                button.backgroundColor = UIColor.white
                button.layer.cornerRadius = 5
                
                button.isEnabled = true
                
                stackView.addArrangedSubview(button)
            }
        }
        
    }
    
    func createButtons(letters: String, stackView: UIStackView) {
        for letter in letters {
            
            let button = UIButton(type: .roundedRect)
            button.setTitle(String(letter).uppercased(), for: [])
            button.titleLabel?.font = .systemFont(ofSize: 20)
            
            button.backgroundColor = UIColor.white
            button.layer.cornerRadius = 5
            
            button.isEnabled = true
            
            button.addTarget(self, action: #selector(letterButtonPressed), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
            
        }
    }
    
    func updateUI() {
        
        treeImageView.image = UIImage(named: "Tree\(game.turnsLeft)")
        
        let element0 = guessWordStackView.arrangedSubviews[0]
        let element1 = guessWordStackView.arrangedSubviews[1]
        
        for index in game.openLetters {
            if let button = element1.subviews[index] as? UIButton {
                button.setTitle(game.word.letters[index].label, for: [])
            }
        }
        
        if let label = element0 as? UILabel {
            if game.isWin {
                label.text = "That's right!"
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.game.newGame()
                    self.startNewGame()
                }
            }
            if game.isOver {
                
                label.text = "Sorry, the right word is \(game.word.name)"
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.game.newGame()
                    self.startNewGame()
                }
            }
        }
    }
    
    @objc func letterButtonPressed(sender: UIButton) {
        if !game.isOver && !game.isWin {
            
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
            sender.isEnabled = false
            
            if let title = sender.title(for: .normal) {
                game.checkLetter(title)
                
                updateUI()

            }
        }
    }

}

