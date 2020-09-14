//
//  ViewController.swift
//  Project1
//
//  Created by Stomach Diego on 7/30/20.
//  Copyright © 2020 Mansur Nasybullin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var numberOfImpressions = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Do any additional setup after loading the view.
        performSelector(inBackground: #selector(loadNSSL), with: nil)
        
        let defaults = UserDefaults.standard
        
        if let savedNumber = defaults.object(forKey: "number") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                numberOfImpressions = try jsonDecoder.decode([Int].self, from: savedNumber)
            } catch {
                print("Failed to load numbers.")
            }
        }
        
        
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(numberOfImpressions) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "number")
        } else {
            print("Failed to save number.")
        }
    }
    
    @objc func loadNSSL() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
                numberOfImpressions.append(0)
            }
        }
        //pictures = pictures.sorted(by: <)
        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            numberOfImpressions[indexPath.row] += 1
            save()
            // 2.1: Rather than show image names in the detail title bar, show “Picture X of Y”, where Y is the total number of images and X is the selected picture’s position in the array. Make sure you count from 1 rather than 0.
            vc.imageTitleString = "Picture \(indexPath.row + 1) of \(pictures.count)"
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func shareTapped() {
        let message = "Hey, I recommend you download the cool app - Project1"
        let vc = UIActivityViewController(activityItems: [message], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }


}

