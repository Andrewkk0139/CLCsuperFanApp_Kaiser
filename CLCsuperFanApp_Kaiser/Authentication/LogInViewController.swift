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
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func validateFields() -> String?{
        
        if emailTextFieldOutlet.text?.trimmingCharacters(in: .whitespaces) == "" || passwordTextFieldOutlet.text?.trimmingCharacters(in: .whitespaces) == ""{
            return "Please fill in all fields"
        }
        
        let cleanedPassword = passwordTextFieldOutlet.text!.trimmingCharacters(in: .whitespaces)
        
        if isPasswordValid(cleanedPassword){
            
        }else{
            return "Ensure your password is at least 8 characters, contains a special character and a number"
        }
        
        return nil
    }
    
    @IBAction func logInAction(_ sender: Any) {
        
        //validate text fields
        if validateFields() == nil{
            let email = emailTextFieldOutlet.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextFieldOutlet.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            //logIn
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error != nil{
                    self.errorLabel.textColor = UIColor.red
                    self.errorLabel.text = "\(error!)"
                }else{
                   
                        
                        for stud in AppData.masterUsers{
                            if stud.uid == result?.user.uid{
                                AppData.user = stud
                                break
                            }
                        }
                        
                        //goes to main view countroller if log in is successful
                        let homeViewController = self.storyboard?.instantiateViewController(identifier: "homeVC") as? MainVC
                        
                        self.view.window?.rootViewController = homeViewController
                        self.view.window?.makeKeyAndVisible()
                    }
            }
        } else{
            self.errorLabel.textColor = UIColor.red
            self.errorLabel.text = validateFields()
        }
    }
}
