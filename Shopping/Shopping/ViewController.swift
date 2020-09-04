//
//  ViewController.swift
//  Shopping
//
//  Created by Stomach Diego on 8/26/20.
//  Copyright © 2020 Mansur Nasybullin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var productName = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addShopping))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(startApp))
        
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        navigationItem.rightBarButtonItems = [share, add]
        
        startApp()
    }
    
    @objc func shareTapped() {
        let list = productName.joined(separator: "\n")

        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    @objc func startApp() {
        title = "Shopping list"
        productName.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func addShopping() {
        let ac = UIAlertController(title: "The Product's name", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
         let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
                   guard let word = ac?.textFields?[0].text else { return }
                   self?.submit(word)
               }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productName.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = productName[indexPath.row]
        return cell
    }
    
    func submit(_ word: String) {
        productName.insert(word, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        return
    }

}

