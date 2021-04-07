//
//  ViewController.swift
//  ApplePie
//
//  Created by YURY PROSVIRNIN on 05.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lettersStackView: UIStackView!
    @IBOutlet weak var guessWordStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let guessWord = "qwertyuiop"
        
        let row = UIStackView()
        row.axis = .horizontal
        row.alignment = .fill
        row.distribution = .fillEqually
        row.spacing = 10
  
        guessWordStackView.addArrangedSubview(row)
        
        for _ in guessWord {
            let button = UIButton(type: .roundedRect)
            button.setTitle(" ", for: [])
            button.backgroundColor = UIColor.white
            button.layer.cornerRadius = 5
            button.isEnabled = false
            
            row.addArrangedSubview(button)
        }
        
        let letters = [["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
                       ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
                       ["Z", "X", "C", "V", "B", "N", "M"]]
        
        for line in letters {
            
            let row = UIStackView()
            row.axis = .horizontal
            row.alignment = .fill
            row.distribution = .fillEqually
            row.spacing = 10
            //row.contentMode = .scaleToFill
            lettersStackView.addArrangedSubview(row)
            
            for letter in line {
                
                let button = UIButton(type: .roundedRect)
                button.setTitle(letter, for: [])
                button.titleLabel?.font = .systemFont(ofSize: 20)
                button.backgroundColor = UIColor.white
                button.layer.cornerRadius = 5
                
                row.addArrangedSubview(button)
                
            }
        }
        
        
    }
    
    
    
    
}

