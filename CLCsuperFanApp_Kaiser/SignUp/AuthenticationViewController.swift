//
//  AuthenticationViewController.swift
//  CLCsuperFanApp_Kaiser
//
//  Created by STANISLAV STAJILA on 4/17/24.
//

import UIKit


class AuthenticationViewController: UIViewController {

    @IBOutlet weak var emailTextFieldOutlet: UITextField!
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
        
        var email = emailTextFieldOutlet.text!
        var password = passwordFieldOutlet.text!
        
        
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
        
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            
            var authResult = authDataResult
            self.invalidTextOutlet.text = "\(error)"
        }
        
    }
}
