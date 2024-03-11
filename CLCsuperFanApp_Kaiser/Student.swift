//
//  Student.swift
//  CLCsuperFanApp_Kaiser
//
//  Created by ANDREW KAISER on 3/8/24.
//

import Foundation
import FirebaseCore
import FirebaseDatabase

 class Student {
    var username: String
    var password: String
    var points: Int
    var firebaseKey = ""
     
    var ref = Database.database().reference()

    
    init(username: String, password: String, points: Int) {
        self.username = username
        self.password = password
        self.points = points
        firebaseKey = ref.child("Users").childByAutoId().key ?? "0"
    }
    
     init(dict: [String:Any]){
         // Safely unwrapping values from dictionary
         if let a = dict["username:"] as? String{
             username = a
         }
         else{
             username = "nill"
         }
         if let n = dict["password:"] as? String{
             password = n
         } else {
             password = ""
         }
         if let p = dict["points:"] as? Int{
             points = p
         } else {
             points = 0
         }
     }
     
     func saveToFirebase() {
         print("saveToFirebase")
         // in func makes a dictionary
         let dict = ["username:":username,"password:":password,"points:":points] as [String:Any]
         // saves the dictionary to the child, Students2
         ref.child("Users").childByAutoId().setValue(dict)
     }
}
