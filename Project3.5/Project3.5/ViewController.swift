//
//  ViewController.swift
//  Project3.5
//
//  Created by Stomach Diego on 8/3/20.
//  Copyright © 2020 Mansur Nasybullin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var countries = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Countries"
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].uppercased()
        cell.imageView?.image = UIImage(named: countries[indexPath.row])
        cell.imageView?.layer.borderWidth = 1
        cell.imageView?.layer.borderColor = UIColor.darkGray.cgColor
           return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
           if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
               // 2: success! Set its selectedImage property
               vc.selectedImage = countries[indexPath.row]
               // 2.1: Rather than show image names in the detail title bar, show “Picture X of Y”, where Y is the total number of images and X is the selected picture’s position in the array. Make sure you count from 1 rather than 0.
            vc.imageTitleString = countries[indexPath.row].uppercased()
               // 3: now push it onto the navigation controller
               navigationController?.pushViewController(vc, animated: true)
           }
       }


}

