//
//  AdminConsole.swift
//  CLCsuperFanApp_Kaiser
//
//  Created by ANDREW KAISER on 3/14/24.
//

import UIKit
import FirebaseCore
import FirebaseDatabase

class AdminConsole: UIViewController {
    
    var ref: DatabaseReference!
    @IBOutlet weak var codeOutlet: UITextField!
    @IBOutlet weak var lifeOutlet: UITextField!
    @IBOutlet weak var valueOutlet: UITextField!
    @IBOutlet weak var successfullyOutlet: UILabel!
    @IBOutlet weak var titleFieldOutlet: UITextField!
    @IBOutlet weak var dateFieldOutlet: UITextField!
    @IBOutlet weak var eventMadeOutlet: UILabel!
    var keyboardShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
        //successfullyOutlet.isHidden = true
        eventMadeOutlet.isHidden = true
        setUpKeyboard()
    }
    
    @IBAction func createCodeAction(_ sender: Any) {
        var check = AppData.masterCodes.count
        var newCode = AccessCode(code: codeOutlet.text!, life: Int(lifeOutlet.text!) ?? 5, value: Int(valueOutlet.text!) ?? 5)
        for i in 0..<AppData.masterCodes.count {
            if (newCode.code == AppData.masterCodes[i].code ) {
                // we want it to check the whole array, so we don't break/return in this loop.
                check -= 1
            }
        }
        if check == AppData.masterCodes.count {
            // No dupe codes found
            print("Code made!")
            newCode.saveToFirebase()
            AppData.masterCodes.append(newCode)
            successfullyOutlet.isHidden = false
        } else {
            print("Code already exists")
        }
    }
    
    @IBAction func makeEventButtonAction(_ sender: Any) {
        var check = AppData.masterEvents.count
        var newEvent = Event(title: titleFieldOutlet.text!, date: dateFieldOutlet.text!)
        for i in 0..<AppData.masterEvents.count{
            if (newEvent.title == AppData.masterEvents[i].title){
                check -= 1
            }
        }
        if check == AppData.masterEvents.count {
            // No dupe events found
            print("Event made!")
            newEvent.saveToFirebase()
            //AppData.masterEvents.append(newEvent)
            eventMadeOutlet.isHidden = false
        } else {
            print("Event already exists")
        }
        

    }
    
    func setUpKeyboard(){
        //listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(sender: NSNotification){
        //view.frame.origin.y = view.frame.origin.y-200
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else{
            return
        }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, to: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > keyboardTopY && keyboardShown == false{
            keyboardShown = true
            let newFrameY = keyboardTopY - view.frame.height
            view.frame.origin.y = newFrameY
        }
    }
    
    @objc func keyboardWillHide(sender: NSNotification){
        keyboardShown = false
        view.frame.origin.y = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }


}
