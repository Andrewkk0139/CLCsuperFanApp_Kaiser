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
        codeRedOutlet.isHidden = true
        codeInvalidOutlet.isHidden = true
        codeAlrRedeemedOutlet.isHidden = true
        let tempCode = codeFieldOutlet.text ?? "nil"
        var invalidBool = false
        var alrRedBool = false
        
        for i in 0..<AppData.masterCodes.count {
            // checks to see if the code is valid
            print(tempCode)
            print(AppData.masterCodes[i].code)
            if AppData.masterCodes[i].code == tempCode {
                invalidBool = true
                // if code is valid
                print("code is valid")
                let firebaseCode = AppData.masterCodes[i]
                for k in 0..<AppData.user.usedCodes.count {
                    
                    
                    // code isn't used already by user
                    if AppData.user.usedCodes[k] != tempCode{
                        // checks to see if its went thru whole array
                        print("value of K:\(k), value of count: \(AppData.user.usedCodes.count - 1)")
                        if k == AppData.user.usedCodes.count - 1 {
                            alrRedBool = true
                            print("Code hasn't been used already")
                            print("*BEFORE REDEEMED* Username:\(AppData.user.username) Points: \(AppData.user.points)")
                            AppData.user.points += firebaseCode.value
                            codeRedOutlet.isHidden = false
                            print("*AFTER REDEEMED* Username:\(AppData.user.username) Points: \(AppData.user.points)")
                            // updating on FireBase
                            ref.child("Users").child("\(AppData.user.firebaseKey)").child("points:").setValue(AppData.user.points)
                            AppData.user.usedCodes.append(tempCode)
                            // updating on FireBase
                            ref.child("Users").child("\(AppData.user.firebaseKey)").child("usedCodes:").setValue(AppData.user.usedCodes)
                            // updating leaderboard
                            AppData.masterUsers.sort(by: {$0.points > $1.points})
                            for i in 0..<AppData.masterUsers.count {
                                AppData.masterUsers[i].declareRank(i)
                            }
                            // updating lifespan of code
                                // updates masterCode
                            AppData.masterCodes[i].life -= 1
                                // updates on firebase
                            ref.child("Codes").child("\(firebaseCode.firebaseKey)").child("life:").setValue(firebaseCode.life - 1)

                            return
                        }
                    } else {
                        //codeAlrRedeemedOutlet.isHidden = false
                        print("Code has been already redeemed")
                        //break
                    }
                }
                } else {
                    //codeInvalidOutlet.isHidden = false
                    print("Code is invalid")
                    //break
                }
        }
        if !invalidBool {
            codeInvalidOutlet.isHidden = false
            codeAlrRedeemedOutlet.isHidden = true
        }
        if !alrRedBool {
            codeAlrRedeemedOutlet.isHidden = false
            codeInvalidOutlet.isHidden = true
        }
    }
    

  

}
