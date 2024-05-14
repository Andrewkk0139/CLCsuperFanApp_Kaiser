//
//  ViewControllerEventInfor.swift
//  CLCsuperFanApp_Kaiser
//
//  Created by JAKE KENEFICK on 5/13/24.
//

import UIKit

class ViewControllerEventInfor: UIViewController {

    @IBOutlet weak var LocationOutlet: UILabel!
    @IBOutlet weak var pointsOutelt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pointsOutelt.text = "Points: \((AppData.masterUsers[AppData.count].points))"
     
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
