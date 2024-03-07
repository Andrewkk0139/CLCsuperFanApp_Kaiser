//
//  ViewController.swift
//  CLCsuperFanApp_Kaiser
//
//  Created by ANDREW KAISER on 3/6/24.
//

import UIKit
import FirebaseCore
import FirebaseDatabase
var ref: DatabaseReference!

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
    }


}

