//
//  ViewController.swift
//  Project5
//
//  Created by Stomach Diego on 8/6/20.
//  Copyright © 2020 Mansur Nasybullin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]() {
        didSet {
            saveWords.usedWords = usedWords.self
            save()
        }
    }
    var saveWords: saveGame!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        saveWords = saveGame(word: "", usedWords: usedWords)
        let defaults = UserDefaults.standard
        
        if let savedPeople = defaults.object(forKey: "game") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                saveWords = try jsonDecoder.decode(saveGame.self, from: savedPeople)
            } catch {
                print("Failed to load game.")
            }
        }
        if saveWords.word.isEmpty {
            startGame()
        } else {
            title = saveWords.word
            usedWords = saveWords.usedWords
            tableView.reloadData()
            saveWords.word.removeAll()
            saveWords.usedWords.removeAll(keepingCapacity: true)
        }
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(saveWords) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "game")
        } else {
            print("Failed to save game.")
        }
    }
    
    @objc func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        saveWords.word = title!
        saveWords.usedWords = usedWords
        save()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }

    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }

    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        if (word.count < 3) {
            return false
        }
        if (title?.hasPrefix(word) == true) {
            return false
        }
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(lowerAnswer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)

                    return
                } else {
                    showErrorMessage(errorTitle: "Word not recognised", errorMessage: "You can't just make them up, you know!")
                }
            } else {
                showErrorMessage(errorTitle: "Word used already", errorMessage: "Be more original!")
            }
        } else {
            guard let title = title?.lowercased() else { return }
            showErrorMessage(errorTitle: "Word not possible", errorMessage: "You can't spell that word from \(title)")
        }
    }
    
    func showErrorMessage(errorTitle: String, errorMessage: String) {
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    

}

