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
        invalidTextOutlet.isHidden = true
    }
    
    @IBAction func loginAction(_ sender: Any) {
        let tempUser = (usernameFieldOutlet.text ?? "nil").lowercased()
        let tempPass = (passwordFieldOutlet.text ?? "nil").lowercased()
        
        for i in 0..<AppData.masterUsers.count {
            if tempUser == AppData.masterUsers[i].username && tempPass == AppData.masterUsers[i].password {
                print("Successfully logged user in!")
                AppData.user = AppData.masterUsers[i]
                performSegue(withIdentifier: "loginToMain", sender: self)
                invalidTextOutlet.isHidden = true
                return
            } else {
                invalidTextOutlet.isHidden = false
            }
        }
        
    }
    

}
