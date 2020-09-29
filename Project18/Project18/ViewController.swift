//
//  ViewController.swift
//  Project18
//
//  Created by Stomach Diego on 9/29/20.
//  Copyright © 2020 Mansur Nasybullin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(1 == 1, "Fail 1 == 1")
        assert(1 == 2, "Fail 1 == 2")
        
        for i in 1 ... 100 {
            print("Got number \(i)")
        }
        
        // Exeption Breakpoint останавливает перед ошибкой
    }


}

