//
//  Picture.swift
//  Project1
//
//  Created by Stomach Diego on 9/8/20.
//  Copyright © 2020 Mansur Nasybullin. All rights reserved.
//

import UIKit

class Picture: NSObject {
    var name: String
    var image: String
    
    init (name: String, image: String) {
        self.name = name
        self.image = image
    }
}
