//
//  Event.swift
//  CLCsuperFanApp_Kaiser
//
//  Created by ANDREW KAISER on 4/25/24.
//

import Foundation
import FirebaseCore
import FirebaseDatabase

class Event {
    
    var title: String
    var date: String
    var firebaseKey = ""
    var ref = Database.database().reference()

    
    init(title: String, date: String) {
        self.title = title
        self.date = date
    }
    
    init(dict: [String:Any]){
        // Safely unwrapping values from dictionary
        if let t = dict["title:"] as? String{
            title = t
        }
        else{
            title = "nill"
        }
        if let d = dict["date:"] as? String{
            date = d
        } else {
            date = "n/a"
        }
    }
    func saveToFirebase() {
        // in func makes a dictionary
        let dict = ["title:":title,"date:":date] as [String:Any]
        // saves the dictionary to the child, Students2
        ref.child("Events").childByAutoId().setValue(dict)
    }
    
}
