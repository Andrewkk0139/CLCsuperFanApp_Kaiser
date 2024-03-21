//
//  AccessCode.swift
//  CLCsuperFanApp_Kaiser
//
//  Created by ANDREW KAISER on 3/14/24.
//

import Foundation
import FirebaseCore
import FirebaseDatabase

class AccessCode {
    var code: String
    var life: Int
    var value: Int
    var firebaseKey = ""
    
    var ref = Database.database().reference()

    
    init(code: String, life: Int, value: Int) {
        self.code = code
        self.life = life
        self.value = value
        firebaseKey = ref.child("Users").childByAutoId().key ?? "0"
    }
    init(dict: [String:Any]){
        // Safely unwrapping values from dictionary
        if let c = dict["code:"] as? String{
            code = c
        }
        else{
            code = "nill"
        }
        if let l = dict["life:"] as? Int{
            life = l
        } else {
            life = 5
        }
        if let v = dict["value:"] as? Int{
            value = v
        } else {
            value = 5
        }
    }
    func saveToFirebase() {
        // in func makes a dictionary
        let dict = ["code:":code,"life:":life,"value:":value] as [String:Any]
        // saves the dictionary to the child, Students2
        ref.child("Codes").childByAutoId().setValue(dict)
    }
    
    
}
