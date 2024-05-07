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
    var firstName: String
    var lastName: String
    var email: String
    var uid: String
//  var password: String
    var points: Int
    var firebaseKey = ""
    var globalRank = 0
    var usedCodes: [String] = []

     
    var ref = Database.database().reference()

    
     init(firstName: String, lastName: String, email: String, uid: String, points: Int) {
//      self.username = username
        username = "\(firstName.lowercased())_\(lastName.lowercased())"
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.uid = uid
//        self.password = password
        self.points = points
        firebaseKey = ref.child("Users").childByAutoId().key ?? "0"
        usedCodes.append("nil")
         
    }
    
     init(dict: [String:Any]){
         // Safely unwrapping values from dictionary
//         if let a = dict["username:"] as? String{
//             username = a.lowercased()
//         }
//         else{
//             username = "nill"
//         }
//         if let n = dict["password:"] as? String{
//             password = n.lowercased()
//         } else {
//             password = ""
//         }
         if let fn = dict["firstName"] as? String{
             firstName = fn
         } else {
             firstName = ""
         }
         if let ln = dict["lastName"] as? String{
             lastName = ln
         } else {
             lastName = ""
         }
         if let e = dict["email"] as? String{
             email = e
         } else {
             email = ""
         }
         if let u = dict["uid"] as? String{
             uid = u
         } else {
             uid = ""
         }
         if let p = dict["points:"] as? Int{
             points = p
         } else {
             points = 0
         }
         if let u = dict["usedCodes"] as? [String]{
             usedCodes = u
         }
         
         username = "\(firstName.lowercased())_\(lastName.lowercased())"
     }
     
     func saveToFirebase() {
         print("saveToFirebase")
         // in func makes a dictionary
         let dict = ["firstName" : firstName, "lastName" : lastName, "email" : email, "uid" : uid, "points" : points, "usedCodes" : usedCodes] as [String:Any]
         // saves the dictionary to the child, Students2
         ref.child("Users").childByAutoId().setValue(dict)

     }
   
     
     func declareRank(_ i: Int) {
         globalRank = i + 1
     }
}
class Blah{
    var count = 0
    
}
