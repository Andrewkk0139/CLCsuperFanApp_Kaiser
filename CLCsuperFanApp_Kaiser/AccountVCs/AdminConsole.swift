//
//  AdminConsole.swift
//  CLCsuperFanApp_Kaiser
//
//  Created by ANDREW KAISER on 3/14/24.
//

import UIKit
import FirebaseCore
import FirebaseDatabase

class AdminConsole: UIViewController,UITextFieldDelegate{
    
    var ref: DatabaseReference!
    @IBOutlet weak var codeOutlet: UITextField!
    @IBOutlet weak var lifeOutlet: UITextField!
    @IBOutlet weak var valueOutlet: UITextField!
    @IBOutlet weak var successfullyOutlet: UILabel!
    @IBOutlet weak var titleFieldOutlet: UITextField!
    @IBOutlet weak var dateFieldOutlet: UITextField!
    @IBOutlet weak var eventMadeOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
        //successfullyOutlet.isHidden = true
        eventMadeOutlet.isHidden = true
        codeOutlet.delegate = self
        lifeOutlet.delegate = self
        valueOutlet.delegate = self
        titleFieldOutlet.delegate = self
        dateFieldOutlet.delegate = self
    }
    
    @IBAction func createCodeAction(_ sender: Any) {
        codeOutlet.resignFirstResponder()
        lifeOutlet.resignFirstResponder()
        valueOutlet.resignFirstResponder()
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
        titleFieldOutlet.resignFirstResponder()
        dateFieldOutlet.resignFirstResponder()
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

}
