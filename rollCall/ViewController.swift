//
//  ViewController.swift
//  rollCall
//
//  Created by Kevin Vallejo on 2/18/18.
//  Copyright © 2018 Vallejo. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        #if swift(>=5.0)
            print("Hello, Swift 5.0")
        #elseif swift(>=4.1)
            print("Hello, Swift 4.1")
        #elseif swift(>=4.0)
            print("Hello, Swift 4.0")
        #elseif swift(>=3.0)
            print("Hello, Swift 3.0")
        #elseif swift(>=2.2)
            print("Hello, Swift 2.2")
        #elseif swift(>=2.1)
            print("Hello, Swift 2.1")
        #endif
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

