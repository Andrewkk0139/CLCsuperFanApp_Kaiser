//
//  SignUpViewController.swift
//  CLCsuperFanApp_Kaiser
//
//  Created by STANISLAV STAJILA on 4/18/24.
//
import UIKit
import FirebaseAuth
import Firebase
class SignUpViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.delegate = self
        lastNameTextField.delegate = self
        ref = Database.database().reference()
        firstNameTextField.autocorrectionType = .no
        lastNameTextField.autocorrectionType = .no
        passwordTextField.autocorrectionType = .no
       emailTextField.autocorrectionType = .no
    }
    
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func validateFields() -> String?{
        
        if firstNameTextField.text?.trimmingCharacters(in: .whitespaces) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespaces) == "" || emailTextField.text?.trimmingCharacters(in: .whitespaces) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespaces) == ""{
            return "Please fill in all fields"
        }
        
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespaces)
            
            if isPasswordValid(cleanedPassword){
                
            }else{
                return "Ensure your password is at least 8 characters, contains a special character and a number"
            }
            
            return nil
    }
    @IBAction func signUpTapped(_ sender: Any) {
        lastNameTextField.resignFirstResponder()
        firstNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        //validate fields
        let error =  validateFields()
        if (lastNameTextField.text != nil || firstNameTextField.text != nil || emailTextField.text != nil || passwordTextField.text != nil){
            if error == nil{
                
                let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                
                
                Auth.auth().createUser(withEmail: email, password: password) { result, err in
                    //checks for errors
                    if let err = err{
                        //There was an error creating the user
                        self.errorLabel.textColor = UIColor.red
                        self.errorLabel.text = "\(err.localizedDescription)"
                        print(err)
                    }else{
                        //User was added successfully
                        //create user
                        let student = Student(firstName: firstName, lastName: lastName, email: email, uid: result!.user.uid, points: 0)
                        
                        student.saveToFirebase()
                        AppData.user = student
                        
                        
                        let db = Firestore.firestore()
                        db.collection("users").addDocument(data: ["firstName" : firstName, "lastName" : lastName, "uid" : result!.user.uid]) { error in
                            if error != nil{
                                let alert = UIAlertController(title: "ERROR", message: "Error saving user", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "ok", style: .default , handler: nil)
                                alert.addAction(okAction)
                                self.present(alert, animated: true, completion: nil)
                            }else{
                                //transition to the home screen
                                self.transitionToHome()
                            }
                        }
                    }
                }
            }else{
                self.errorLabel.textColor = UIColor.white
                self.errorLabel.text = "\(error!)"
            }
        }
        else{
            let alert = UIAlertController(title: "ERROR", message: "Please fill in all text fields.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok", style: .default , handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        
       
    }
    
    func transitionToHome(){
        let homeViewController = self.storyboard?.instantiateViewController(identifier: "homeVC") as? MainVC
        
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

