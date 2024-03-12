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
            AppData.masterUsers.append(u)
        })
        
        // called after .childAdded
        ref.child("Users").observeSingleEvent(of: .value, with: { snapshot in
                print("--inital load has completed and the last user was read--")
                print(AppData.masterUsers.count)
            })
    }
    
    @IBAction func loginAction(_ sender: Any) {
        performSegue(withIdentifier: "toLogin", sender: self)
    }
    
    @IBAction func createAction(_ sender: Any) {
        performSegue(withIdentifier: "toCreate", sender: self)

    }
    

}

