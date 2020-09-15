//
//  Pictures.swift
//  photo-gallery-Project
//
//  Created by Stomach Diego on 9/15/20.
//  Copyright © 2020 Mansur Nasybullin. All rights reserved.
//

import UIKit

class Pictures: NSObject, Codable {
    var image: String
    var name: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
