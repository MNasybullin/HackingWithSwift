//
//  Person.swift
//  Project10
//
//  Created by Stomach Diego on 9/7/20.
//  Copyright © 2020 Mansur Nasybullin. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init (name: String, image: String) {
        self.name = name
        self.image = image
    }
}
