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
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func validateFields() -> String?{
      
        if firstNameTextField.text?.trimmingCharacters(in: .whitespaces) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespaces) == "" || emailTextField.text?.trimmingCharacters(in: .whitespaces) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespaces) == ""{
            return "Please fill in all fields"
        }
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespaces)
        
        if isPasswordValid(cleanedPassword){
                
        }else{
            return "Ensure your password is at least 8 characters, contains a special character and a number"
        }
        
        return nil
    }

    @IBAction func signUpTapped(_ sender: Any) {
        
        //validate fields
        let error =  validateFields()
        
        if error == nil{
            
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { result, err in
                //checks for errors
                if let err = err{
                    //There was an error creating the user
                    print(err)
                }else{
                    //User was added successfully
                    //create user
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstName" : firstName, "lastName" : lastName, "uid" : result!.user.uid]) { error in
                        if error != nil{
                            print("Error saving user")
                        }else{
                            //transition to the home screen
                            self.transitionToHome()
                        }
                    }
                }
            }
        }else{
            print(error!)
        }
        
       
    }
    
    func transitionToHome(){
        if let homeViewController = storyboard?.instantiateViewController(withIdentifier: "homeVC") as? MainVC{
            
            //transition(from: self, to: homeViewController, duration: 1) {
                
            //}
        }
    }
    

}

