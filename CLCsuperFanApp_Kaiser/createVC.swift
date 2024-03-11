//
//  createVC.swift
//  CLCsuperFanApp_Kaiser
//
//  Created by ANDREW KAISER on 3/8/24.
//

import UIKit
import FirebaseCore
import FirebaseDatabase

class createVC: UIViewController {

    @IBOutlet weak var usernameFieldOutlet: UITextField!
    @IBOutlet weak var passwordFieldOutlet: UITextField!
    @IBOutlet weak var invalidTextOutlet: UILabel!
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
    }
    // Need to check for dupe accounts/ dupe username or passwords
    @IBAction func createAction(_ sender: Any) {
        let newStud = Student(username: (usernameFieldOutlet.text!.lowercased()) , password: (passwordFieldOutlet.text!.lowercased()) , points: 0)
        newStud.saveToFirebase()
        AppData.user = newStud
        performSegue(withIdentifier: "createToMain", sender: self)
        
    }
    

}
