//
//  AccessCodeVC.swift
//  CLCsuperFanApp_Kaiser
//
//  Created by ANDREW KAISER on 3/14/24.
//

import UIKit
import FirebaseCore
import FirebaseDatabase
import MapKit

class AccessCodeVC: UIViewController,CLLocationManagerDelegate,UITextFieldDelegate {
    
    
    var other : MainVC!
    @IBOutlet weak var codeFieldOutlet: UITextField!
    @IBOutlet weak var codeRedOutlet: UILabel!
    @IBOutlet weak var codeInvalidOutlet: UILabel!
    @IBOutlet weak var codeAlrRedeemedOutlet: UILabel!
    @IBOutlet weak var adminPasswordOutlet: UITextField!
    var ref: DatabaseReference!
    var latitude = 0.0
    var longitude = 0.0
    let locationManager = CLLocationManager()
    var currentLocaiton : CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        codeFieldOutlet.delegate = self
        adminPasswordOutlet.delegate = self
        codeFieldOutlet.autocorrectionType = .no
        adminPasswordOutlet.autocorrectionType = .no
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
        codeRedOutlet.isHidden = true
        codeInvalidOutlet.isHidden = true
        codeAlrRedeemedOutlet.isHidden = true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        other.pointsOutlet.text = "Points: \(AppData.user.points)"
    }
    
    @IBAction func redeemAction(_ sender: Any) {
        codeFieldOutlet.resignFirstResponder()
        adminPasswordOutlet.resignFirstResponder()
        latitude = Double(locationManager.location!.coordinate.latitude)
        longitude = Double(locationManager.location!.coordinate.longitude)
        var adminPassword = adminPasswordOutlet.text ?? ""
        
        if((42.231 ... 42.238).contains(latitude) && (-88.327 ... -88.320).contains(longitude) || adminPassword == "d155Admin"){
            print("these r the codes used by user: ")
            for i in 0..<AppData.user.usedCodes.count{
                print(AppData.user.usedCodes[i])
            }
            codeRedOutlet.isHidden = true
            codeInvalidOutlet.isHidden = true
            codeAlrRedeemedOutlet.isHidden = true
            let tempCode = codeFieldOutlet.text ?? "nil"
            var validBool = false
            var foundUsed = false
            for i in 0..<AppData.masterCodes.count {
                // checks to see if the code is valid
               
                if AppData.masterCodes[i].code == tempCode {
                    validBool = true
                    var checkCodeLife = AppData.masterCodes[i].life
                    // if code is valid
                    print("code is valid")
                    print("THESE ARE THE USERS CODES")
                    for i in 0..<AppData.user.usedCodes.count{
                        print("\(i): \(AppData.user.usedCodes[i])")
                    }
                    let firebaseCode = AppData.masterCodes[i]
                    for k in 0..<AppData.user.usedCodes.count {
                        
                        
                        // code isn't used already by user
                        if AppData.user.usedCodes[k] != tempCode && checkCodeLife > 0 {
                            // checks to see if its went thru whole array
                            if k == AppData.user.usedCodes.count - 1 && !foundUsed{
                                print("Code hasn't been used already")
                                print("*BEFORE REDEEMED* Username:\(AppData.user.username) Points: \(AppData.user.points)")
                                AppData.user.points += firebaseCode.value
                                codeRedOutlet.isHidden = false
                                print("*AFTER REDEEMED* Username:\(AppData.user.username) Points: \(AppData.user.points)")
                                // updating on FireBase
                                ref.child("Users").child("\(AppData.user.firebaseKey)").child("points").setValue(AppData.user.points)
                                AppData.user.usedCodes.append(tempCode)
                                // updating on FireBase
                                ref.child("Users").child("\(AppData.user.firebaseKey)").child("usedCodes").setValue(AppData.user.usedCodes)
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
                            print("THIS ISNT RUNNING")
                            foundUsed = true
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
            if !validBool {
                codeInvalidOutlet.isHidden = false
                codeAlrRedeemedOutlet.isHidden = true
            }
            if foundUsed {
                codeAlrRedeemedOutlet.isHidden = false
                codeInvalidOutlet.isHidden = true
            }
        }
        else{
            let alert = UIAlertController(title: "ERROR", message: "You must be on campus to redeem points", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok", style: .default , handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        // end of func
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocaiton = locations[0]
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // end of class
}
