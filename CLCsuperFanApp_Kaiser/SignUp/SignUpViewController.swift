//
//  SignUpViewController.swift
//  CLCsuperFanApp_Kaiser
//
//  Created by STANISLAV STAJILA on 4/18/24.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func isPasswordValid(password: String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&] {8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func validateFields() -> String?{
      
        if firstNameTextField.text?.trimmingCharacters(in: .whitespaces) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespaces) == "" || emailTextField.text?.trimmingCharacters(in: .whitespaces) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespaces) == ""{
            return "Please fill in all fields"
        }
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespaces)
        if isPasswordValid(password: cleanedPassword){
                
        }
        
        return nil
    }

    @IBAction func signUpTapped(_ sender: Any) {
        
        //validate fields
        //create user
        //transition to the home screen
    }
    

}
