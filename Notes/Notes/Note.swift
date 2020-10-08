//
//  Note.swift
//  Notes
//
//  Created by Stomach Diego on 10/8/20.
//  Copyright © 2020 Mansur Nasybullin. All rights reserved.
//

import UIKit

class Note: NSObject, Codable {
    var head: String
    var body: String
    
    init(head: String, body: String) {
        self.head = head
        self.body = body
    }
}
