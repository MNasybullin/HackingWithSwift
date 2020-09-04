//
//  ViewController.swift
//  Project7
//
//  Created by Stomach Diego on 8/27/20.
//  Copyright © 2020 Mansur Nasybullin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var petitionsBeforeFiltering = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(creditsButton))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchPetitions))

        performSelector(inBackground: #selector(fetchJSON), with: nil)
        
    }
    
    @objc func fetchJSON() {
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    @objc func searchPetitions() {
           let ac = UIAlertController(title: "Filter the petitions", message: nil, preferredStyle: .alert)
           ac.addTextField()
           
            let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
                      guard let word = ac?.textFields?[0].text else { return }
                      self?.filterPetitions(word)
                  }
            let cancelFilter = UIAlertAction(title: "Cancel filter", style: .default) { action in
                self.cancelFilterPetitions()
        }
    
           ac.addAction(cancelFilter)
           ac.addAction(submitAction)
           present(ac, animated: true)
       }
    
    func cancelFilterPetitions()
    {
        petitions = petitionsBeforeFiltering
        tableView.reloadData()
    }
    
    func filterPetitions(_ word: String) {
        if word.isEmpty {
            return
        }
        let lowerWord = word.lowercased()
        petitions.removeAll(keepingCapacity: true)
        for petition in petitionsBeforeFiltering {
            let lowerPetitionTitle = petition.title.lowercased()
            let lowerPetitionBody = petition.body.lowercased()
            if lowerPetitionTitle.contains(lowerWord) {
                petitions.insert(petition, at: 0)
            }
            if lowerPetitionBody.contains(lowerWord) {
                petitions.insert(petition, at: 0)
            }
        }
        tableView.reloadData()
    }
    
    @objc func creditsButton() {
        let ac = UIAlertController(title: "The data comes from the We The People API of the Whitehouse.", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            petitionsBeforeFiltering = petitions
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        }
        
    }
    
    @objc func showError() {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

