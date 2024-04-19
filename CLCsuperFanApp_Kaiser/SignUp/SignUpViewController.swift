//
//  SignUpViewController.swift
//  CLCsuperFanApp_Kaiser
//
//  Created by STANISLAV STAJILA on 4/18/24.
//

import UIKit
import FirebaseAuth
import Firebase

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
                
        }else{
            return "Ensure your password is at least 8 characters, contains a special character and a number"
        }
        
        return nil
    }

    @IBAction func signUpTapped(_ sender: Any) {
        
        //validate fields
        let error =  validateFields()
        
        if error == nil{
            Auth.auth().createUser(withEmail: "", password: "") { result, err in
                //checks for errors
                if let err = err{
                    //There was an error creating the user
                    print(err)
                }else{
                    //User was added successfully
                    let db = Firestore.firestore()
                    //db.collection("users").addDocument(data: )
                }
            }
        }else{
            print(error!)
        }
        //create user
        //transition to the home screen
    }
    

}
