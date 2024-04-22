//
//  LeaderboardVC.swift
//  CLCsuperFanApp_Kaiser
//
//  Created by ANDREW KAISER on 3/8/24.
//

import UIKit

class LeaderboardVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var rankUsernameTextOutlet: UILabel!
    
    @IBOutlet weak var rankOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        rankUsernameTextOutlet.text = "Username: \(AppData.user.username)"
        rankOutlet.text = "Rank: #\(AppData.user.globalRank)"
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.masterUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel!.text = AppData.masterUsers[indexPath.row].username
        cell.detailTextLabel!.text = "#\(AppData.masterUsers[indexPath.row].globalRank)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let blah = indexPath.row
        print(blah)
        AppData.count = blah
      
            //performSegue(withIdentifier: "toOne", sender: self)
        performSegue(withIdentifier: "toBlah", sender: self)
        
    }
    

    
}
