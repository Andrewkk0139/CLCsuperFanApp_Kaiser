//
//  logInVC.swift
//  CLCsuperFanApp_Kaiser
//
//  Created by ANDREW KAISER on 3/8/24.
//

import UIKit
import FirebaseCore
import FirebaseDatabase

class logInVC: UIViewController {

    @IBOutlet weak var usernameFieldOutlet: UITextField!
    @IBOutlet weak var passwordFieldOutlet: UITextField!
    @IBOutlet weak var invalidTextOutlet: UILabel!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
    }
    

}
