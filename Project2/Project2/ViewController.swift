//
//  ViewController.swift
//  Project2
//
//  Created by Stomach Diego on 7/31/20.
//  Copyright © 2020 Mansur Nasybullin. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var scoreMax = 0
    var numberOfQuestions = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerLocalNotification()
        scheduleLocal()
        let defaults = UserDefaults.standard
        
        if let savedScore = defaults.object(forKey: "score") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                scoreMax = try jsonDecoder.decode(Int.self, from: savedScore)
            } catch {
                print("Failed to load score.")
            }
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(scoreInfo))
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        askQuestion()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // pull out the buried userInfo dictionary
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")

            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                print("Default identifier")

            case "open":
                scheduleLocal()
                print("Show more information…")

            default:
                break
            }
        }

        // you must call the completion handler when you're done
        completionHandler()
    }
    
    @objc func registerLocalNotification() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }

    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self

        let show = UNNotificationAction(identifier: "open", title: "Open game", options: .foreground)

        let category = UNNotificationCategory(identifier: "remind", actions: [show], intentIdentifiers: [])

        center.setNotificationCategories([category])
    }
    
    func scheduleLocal() {
        registerCategories()
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.title = "Hey"
        content.body = "We are waiting for you in the game!"
        content.categoryIdentifier = "remind"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(scoreMax) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "score")
        } else {
            print("Failed to save score.")
        }
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
            self.button1.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.button2.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.button3.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        
        var titleText: String = countries[correctAnswer].uppercased()
        titleText += " | Score: \(score)"
        
        title = titleText
        
        numberOfQuestions += 1
            }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        })
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong. This is the flag of "
            title += countries[sender.tag].uppercased()
            score -= 1
        }
        if numberOfQuestions == 10 {
            title += ". You have answered 10 questions!"
        }
        if score > scoreMax {
            scoreMax = score
            save()
            message = "You have broken your last record!"
        } else {
            message = "Your score is \(score)."
        }
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
        
    }
    
    @objc func scoreInfo() {
        let ac = UIAlertController(title: "Your score: \(score).", message: "Top score: \(scoreMax).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    

}

