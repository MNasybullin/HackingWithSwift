//
//  ViewController.swift
//  Hangman_game
//
//  Created by Stomach Diego on 9/3/20.
//  Copyright © 2020 Mansur Nasybullin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var wrongAnswers = 0
    var usedLetters = [String]()
    var scoreLabel: UILabel!
    var currentAnswers: UITextField!
    var word: UILabel!
    var usedWords: UITextView!
    var words = [String]()
    var answer = String()
    var level = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadLevel()
    }
    
    func loadLevel() {
        if let wordFileURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let wordContents = try? String(contentsOf: wordFileURL) {
                var lines = wordContents.components(separatedBy: "\n")
                lines.shuffle()
                level = 0
                words = lines

                answer = lines[level].lowercased()
                for _ in answer {
                    word.text?.append("?")
                }
            }
        }
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        currentAnswers = UITextField()
        currentAnswers.translatesAutoresizingMaskIntoConstraints = false
        currentAnswers.placeholder = "Write the whole word or letter"
        currentAnswers.textAlignment = .center
        currentAnswers.font = UIFont.systemFont(ofSize: 25)
        currentAnswers.isUserInteractionEnabled = true
        view.addSubview(currentAnswers)
        
        word = UILabel()
        word.translatesAutoresizingMaskIntoConstraints = false
        word.textAlignment = .center
        word.text = ""
        word.font = UIFont.systemFont(ofSize: 44)
        view.addSubview(word)
        word.layer.borderWidth = 1
        word.layer.borderColor = UIColor.lightGray.cgColor
        
        usedWords = UITextView()
        usedWords.translatesAutoresizingMaskIntoConstraints = false
        usedWords.textAlignment = .center
        usedWords.text = ""
        usedWords.isUserInteractionEnabled = false
        usedWords.font = UIFont.systemFont(ofSize: 25)
        view.addSubview(usedWords)
        
        usedWords.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        view.addSubview(submit)
        submit.addTarget(self, action: #selector(submitTrapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            word.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            word.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            word.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 45),
            
            currentAnswers.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswers.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            currentAnswers.topAnchor.constraint(equalTo: word.bottomAnchor, constant: 20),
            
            submit.topAnchor.constraint(equalTo: currentAnswers.bottomAnchor),
            submit.heightAnchor.constraint(equalToConstant: 44),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            usedWords.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            usedWords.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usedWords.topAnchor.constraint(equalToSystemSpacingBelow: submit.bottomAnchor, multiplier: 1),
            usedWords.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
            
            
        ])
    }
    
    @objc func submitTrapped() {
        guard let answerText = currentAnswers.text?.lowercased() else { return }
        var promptWord = ""
        usedLetters.append(answerText)
        if answerText.count == 1 {
            for letter in answer{
                let strLetter = String(letter)
                if usedLetters.contains(strLetter) {
                    promptWord += strLetter
                } else {
                    promptWord += "?"
                }
            }
            //let promptWordLow = promptWord.uppercased()
            if word.text == promptWord {
                wrongWord()
            }
            word.text = promptWord.uppercased()
            let wordsLetters = usedLetters.joined(separator: ", ")
            usedWords.text = wordsLetters.uppercased()
            if word.text?.contains("?") == false {
                levelComplite()
            }
            currentAnswers.text = ""
            return
        } else if answerText.count == answer.count {
            let answerTextLow = answerText.lowercased()
            let answerLow = answer.lowercased()
            if answerTextLow == answerLow {
                levelComplite()
            }
        }
        wrongWord()
    }
    
    func wrongWord() {
        wrongAnswers += 1
        let wordsLetters = usedLetters.joined(separator: ", ")
        usedWords.text = wordsLetters.uppercased()
        currentAnswers.text = ""
        let ac = UIAlertController(title: "Wrong!", message: "Try another word or letter", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    func levelComplite() {
        word.text = ""
        let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUP))
        present(ac, animated: true)
    }
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    func levelUP(action: UIAlertAction) {
        level += 1
        score += 1
        wrongAnswers = 0
        usedWords.text = ""
        usedLetters.removeAll(keepingCapacity: true)
        if level >= words.count {
            level = 0
        }
        answer = words[level].lowercased()
        for _ in answer {
            word.text?.append("?")
        }
    }

}

