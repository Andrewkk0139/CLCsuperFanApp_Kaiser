//
//  MainVC.swift
//  CLCsuperFanApp_Kaiser
//
//  Created by ANDREW KAISER on 3/8/24.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var usernameTextOutlet: UILabel!
    @IBOutlet weak var pointsOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameTextOutlet.text = AppData.user.username
        pointsOutlet.text =  "Points: \(AppData.user.points)"
    }
    
    @IBAction func upcomingAction(_ sender: Any) { 
        performSegue(withIdentifier: "toUpcomingEvents", sender: self)
    }
    @IBAction func leaderboardAction(_ sender: Any) { 
        performSegue(withIdentifier: "toLeaderboard", sender: self)
    }
    @IBAction func redeemAction(_ sender: Any) {
        performSegue(withIdentifier: "toRedeem", sender: self)
    }
    @IBAction func statsAction(_ sender: Any) { 
        performSegue(withIdentifier: "toStats", sender: self)
    }
    

}
