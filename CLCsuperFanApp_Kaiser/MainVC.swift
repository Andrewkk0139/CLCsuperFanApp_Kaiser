//
//  MainVC.swift
//  CLCsuperFanApp_Kaiser
//
//  Created by ANDREW KAISER on 3/8/24.
//

import UIKit
import FirebaseCore
import FirebaseDatabase

class MainVC: UIViewController {
    @IBOutlet weak var usernameTextOutlet: UILabel!
    @IBOutlet weak var pointsOutlet: UILabel!
    var ref: DatabaseReference!
// setup for firebase
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        logOutButton.tintColor = UIColor.red
        print("view loaded")
        super.viewDidLoad()
        print("Users firebase key: \(AppData.user.firebaseKey)")

        // Do any additional setup after loading the view.
        usernameTextOutlet.text = AppData.user.username
        pointsOutlet.text =  "Points: \(AppData.user.points)"
        print("ALL VALID CODES BELOW:")
        for i in 0..<AppData.masterCodes.count{
            print(AppData.masterCodes[i].code)
        }
        
    }
    
    @IBAction func upcomingAction(_ sender: Any) { 
        performSegue(withIdentifier: "toUpcomingEvents", sender: self)
    }
    @IBAction func leaderboardAction(_ sender: Any) { 
        performSegue(withIdentifier: "toLeaderboard", sender: self)
    }
    @IBAction func redeemAction(_ sender: Any) {
        performSegue(withIdentifier: "toCode", sender: self)
    }
    @IBAction func statsAction(_ sender: Any) { 
        performSegue(withIdentifier: "toStats", sender: self)
    }
    
    
    
    
    @IBAction func logOutAction(_ sender: Any) {
    
        let introViewController = self.storyboard?.instantiateViewController(identifier: "navigationViewController") as? UINavigationController
        
        self.view.window?.rootViewController = introViewController
        self.view.window?.makeKeyAndVisible()
        
    }
    
}
