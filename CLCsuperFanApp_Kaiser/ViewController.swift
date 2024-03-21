//
//  ViewController.swift
//  CLCsuperFanApp_Kaiser
//
//  Created by ANDREW KAISER on 3/6/24.
//

import UIKit
import FirebaseCore
import FirebaseDatabase

struct AppData {
    static var user: Student!
    static var masterUsers: [Student] = []
    static var masterCodes: [AccessCode] = []
}

class ViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        
        // SETTING MASTER STU ARRAY
        ref.child("Users").observe(.childAdded, with: { (snapshot) in
            let dict = snapshot.value as! [String:Any]
            let u = Student(dict: dict)
            u.firebaseKey = snapshot.key
            AppData.masterUsers.append(u)
        })
        
        // called after .childAdded
        ref.child("Users").observeSingleEvent(of: .value, with: { snapshot in
                print("--inital load has completed and the last user was read--")
            // sorts
            AppData.masterUsers.sort(by: {$0.points > $1.points })
            for i in 0..<AppData.masterUsers.count {
                AppData.masterUsers[i].declareRank(i)
                print("Username: \(AppData.masterUsers[i].username) Rank: #\(AppData.masterUsers[i].globalRank)")
            }
        })
        // sorts the array in decending order based on points
        
        // SETTING UP MASTER CODE ARRAY
        ref.child("Codes").observe(.childAdded, with: { (snapshot) in
            let dict = snapshot.value as! [String:Any]
            let c = AccessCode(dict: dict)
            c.firebaseKey = snapshot.key
            AppData.masterCodes.append(c)
        })
        
        // called after .childAdded
        ref.child("Codes").observeSingleEvent(of: .value, with: { snapshot in
                print("--inital load has completed and the last user was read--")
        })
    }
    
    @IBAction func loginAction(_ sender: Any) {
        performSegue(withIdentifier: "toLogin", sender: self)
    }
    
    @IBAction func createAction(_ sender: Any) {
        performSegue(withIdentifier: "toCreate", sender: self)

    }
    

}

