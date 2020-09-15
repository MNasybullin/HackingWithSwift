//
//  DetailViewController.swift
//  photo-gallery-Project
//
//  Created by Stomach Diego on 9/15/20.
//  Copyright © 2020 Mansur Nasybullin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: UIImage?
    var selectedImageName: String?
    var deletePicture = {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedImageName
        
        if let imageToLoad = selectedImage {
            imageView.image = imageToLoad
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(deleteImage))
        
    }
    
    @objc func deleteImage() {
        let ac = UIAlertController(title: "Delete image?", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "No", style: .cancel))
        ac.addAction(UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
            self?.deletePicture()
        })
        present(ac, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    

}
