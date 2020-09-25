//
//  ViewController.swift
//  Project13-15Challenge
//
//  Created by Stomach Diego on 9/25/20.
//  Copyright © 2020 Mansur Nasybullin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Countries"
        
        loadJson()
        // Do any additional setup after loading the view.
    }
    
    func loadJson() {
        if let jsonURL = Bundle.main.url(forResource: "countries", withExtension: "json") {
            if let data = try? Data(contentsOf: jsonURL) {
                parse(json: data)
                return
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonCountries = try? decoder.decode(Countries.self, from: json) {
            countries = jsonCountries.countries
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.country
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.detailCountry = countries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}

