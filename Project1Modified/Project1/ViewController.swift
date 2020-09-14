//
//  ViewController.swift
//  Project1
//
//  Created by Stomach Diego on 7/30/20.
//  Copyright © 2020 Mansur Nasybullin. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var pictures = [Picture]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Do any additional setup after loading the view.
        //loadNSSL()
        performSelector(inBackground: #selector(loadNSSL), with: nil)
    }
    
    @objc func loadNSSL() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                let picture = Picture(name: item, image: item)
                pictures.append(picture)
                print(item)
            }
        }
        print(pictures.count)
        collectionView.performSelector(onMainThread: #selector(collectionView.reloadData), with: nil, waitUntilDone: false)
        //collectionView.reloadData()
       // pictures = pictures.sorted(by: <)
        //print(pictures)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? PictureCell else {
            // we failed to get a PictureCell – bail out!
            fatalError("Unable to dequeue PictureCell.")
        }
        let picture = pictures[indexPath.item]
        cell.name.text = picture.name
        cell.pictureView.image = UIImage(named: picture.image)
        
        cell.pictureView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.pictureView.layer.borderWidth = 2
        cell.pictureView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7

        // if we're still here it means we got a PictureCell, so we can return it
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
           if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
               // 2: success! Set its selectedImage property
            let picture = pictures[indexPath.item]
            vc.selectedImage = picture.name
               // 2.1: Rather than show image names in the detail title bar, show “Picture X of Y”, where Y is the total number of images and X is the selected picture’s position in the array. Make sure you count from 1 rather than 0.
               vc.imageTitleString = "Picture \(indexPath.item + 1) of \(pictures.count)"
               // 3: now push it onto the navigation controller
               navigationController?.pushViewController(vc, animated: true)
           }
           
       }
    
    /*
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
            // 2.1: Rather than show image names in the detail title bar, show “Picture X of Y”, where Y is the total number of images and X is the selected picture’s position in the array. Make sure you count from 1 rather than 0.
            vc.imageTitleString = "Picture \(indexPath.row + 1) of \(pictures.count)"
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    */
    @objc func shareTapped() {
        let message = "Hey, I recommend you download the cool app - Project1"
        let vc = UIActivityViewController(activityItems: [message], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }


}

