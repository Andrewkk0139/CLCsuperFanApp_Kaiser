//
//  VCScoreName.swift
//  CLCsuperFanApp_Kaiser
//
//  Created by JAKE KENEFICK on 4/22/24.
//

import UIKit

class VCScoreName: UIViewController {

    @IBOutlet weak var nameOutlet: UILabel!
    
    @IBOutlet weak var scoreOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameOutlet.text = "Name:"
        scoreOutlet.text = "Score:"
       
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
