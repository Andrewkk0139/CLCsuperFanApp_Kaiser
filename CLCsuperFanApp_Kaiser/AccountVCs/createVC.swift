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
        invalidTextOutlet.isHidden = true
    }
    // Need to check for dupe accounts/ dupe username or passwords
    @IBAction func createAction(_ sender: Any) {
        var check = AppData.masterUsers.count
        let newStud = Student(username: (usernameFieldOutlet.text!.lowercased()) , password: (passwordFieldOutlet.text!.lowercased()) , points: 0)
        for i in 0..<AppData.masterUsers.count {
            if (newStud.username == AppData.masterUsers[i].username){
                if (newStud.password == AppData.masterUsers[i].password) {
                    check -= 1
                }
            }
        }
            if check == AppData.masterUsers.count {
                // No dupe accounts found
                print("No dupes found, account made")
                newStud.saveToFirebase()
                AppData.user = newStud
                performSegue(withIdentifier: "createToMain", sender: self)
                return
            } else {
                invalidTextOutlet.isHidden = false
            }
    }
    

}
