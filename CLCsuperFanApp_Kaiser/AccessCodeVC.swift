//
//  AccessCodeVC.swift
//  CLCsuperFanApp_Kaiser
//
//  Created by ANDREW KAISER on 3/14/24.
//

import UIKit
import FirebaseCore
import FirebaseDatabase

class AccessCodeVC: UIViewController {
    
    @IBOutlet weak var codeFieldOutlet: UITextField!
    @IBOutlet weak var codeRedOutlet: UILabel!
    @IBOutlet weak var codeInvalidOutlet: UILabel!
    @IBOutlet weak var codeAlrRedeemedOutlet: UILabel!
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
        codeRedOutlet.isHidden = true
        codeInvalidOutlet.isHidden = true
        codeAlrRedeemedOutlet.isHidden = true
    }
    
    @IBAction func redeemAction(_ sender: Any) {
        print(AppData.masterCodes)
        codeRedOutlet.isHidden = true
        codeInvalidOutlet.isHidden = true
        codeAlrRedeemedOutlet.isHidden = true
        
        let tempCode = codeFieldOutlet.text ?? "nil"
        
        for i in 0..<AppData.masterCodes.count {
            // checks to see if the code is valid
            if AppData.masterCodes[i].code == tempCode {
                // if code is valid
                for k in 0..<AppData.user.usedCodes.count {
                    // code isn't used already by user
                    if AppData.user.usedCodes[k] != tempCode{
                        // checks to see if its went thru whole array
                        if k == AppData.user.usedCodes.count - 1 {
                            print("*BEFORE REDEEMED* Username:\(AppData.user.username) Points: \(AppData.user.points)")
                            AppData.user.points += AppData.masterCodes[k].value
                            codeRedOutlet.isHidden = false
                            print("*AFTER REDEEMED* Username:\(AppData.user.username) Points: \(AppData.user.points)")
                            // updating on FireBase with a hard coded firebase key
                            ref.child("Users").child("-NtR8uXx2NTzjfVdkRNx").child("points:").setValue(AppData.user.points)
                            //
                            AppData.user.usedCodes.append(tempCode)
                            return
                        }
                    } else {codeAlrRedeemedOutlet.isHidden = false}
                }
            } else {codeInvalidOutlet.isHidden = false}
        }
    }
    

  

}
