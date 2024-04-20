//
//  LogInViewController.swift
//  CLCsuperFanApp_Kaiser
//
//  Created by Stanislav Stajila on 4/19/24.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextFieldOutlet: UITextField!
    @IBOutlet weak var passwordTextFieldOutlet: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func logInAction(_ sender: Any) {
        //validate text fields
        
        
        let email = emailTextFieldOutlet.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextFieldOutlet.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //logIn
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil{
                print(error)
            }else{
                
                //goes to main view countroller if log in is successful
                let homeViewController = self.storyboard?.instantiateViewController(identifier: "homeVC") as? MainVC
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
}
