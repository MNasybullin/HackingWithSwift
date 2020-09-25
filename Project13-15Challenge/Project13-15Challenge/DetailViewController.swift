//
//  DetailViewController.swift
//  Project13-15Challenge
//
//  Created by Stomach Diego on 9/25/20.
//  Copyright © 2020 Mansur Nasybullin. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    var detailCountry: Country?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = detailCountry?.country
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Capital:"
                cell.detailTextLabel?.text = detailCountry?.capital
            case 1:
                cell.textLabel?.text = "Language:"
                cell.detailTextLabel?.text = detailCountry?.language
            case 2:
                cell.textLabel?.text = "Population:"
                cell.detailTextLabel?.text = detailCountry?.population
            case 3:
                cell.textLabel?.text = "Currency:"
                cell.detailTextLabel?.text = detailCountry?.currency
            default:
                break
        }
        
        return cell
    }

   

}
