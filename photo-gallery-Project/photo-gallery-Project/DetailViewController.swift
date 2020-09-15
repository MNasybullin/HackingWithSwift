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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedImageName
        
        
        if let imageToLoad = selectedImage {
            imageView.image = imageToLoad
        }
        
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
