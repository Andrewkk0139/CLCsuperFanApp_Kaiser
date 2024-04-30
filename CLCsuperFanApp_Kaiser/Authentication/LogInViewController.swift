//
//  LogInViewController.swift
//  CLCsuperFanApp_Kaiser
//
//  Created by Stanislav Stajila on 4/19/24.
//
import UIKit
import FirebaseCore
import FirebaseDatabase
import FirebaseAuth
import AVKit

struct AppData {
    static var user: Student!
    static var masterUsers: [Student] = []
    static var masterCodes: [AccessCode] = []
    static var masterEvents: [Event] = []
    static var count = 0
}


class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailTextFieldOutlet: UITextField!
    @IBOutlet weak var passwordTextFieldOutlet: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    var videoLooper: AVPlayerLooper?
    var queuePlayer: AVQueuePlayer?
    
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
                print("--inital code load has completed and the last user was read--")
        })
        // SETTING UP MASTER EVENT ARRAY
        ref.child("Events").observe(.childAdded, with: { (snapshot) in
            let dict = snapshot.value as! [String:Any]
            let e = Event(dict: dict)
            e.firebaseKey = snapshot.key
            AppData.masterEvents.append(e)
        })
        
        // called after .childAdded
        ref.child("Events").observeSingleEvent(of: .value, with: { snapshot in
                print("--inital event load has completed and the last user was read--")
        })
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpVideo()
    }
    
    func setUpVideo(){
        
        let bundelPath = Bundle.main.path(forResource: "goFan", ofType: "mp4")
        
        guard bundelPath != nil else{
            return
        }
        
        let url = URL(fileURLWithPath: bundelPath!)
        //Create a video player item
        let item = AVPlayerItem(url: url)
        //create the player
        videoPlayer = AVPlayer(playerItem: item)
        //create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        //adjust size of a frame
        videoPlayerLayer?.frame = self.view.frame
        videoPlayerLayer?.videoGravity = .resizeAspectFill
    
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        videoPlayer?.playImmediately(atRate: 1)
    
        
    }
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func validateFields() -> String?{
        
        if emailTextFieldOutlet.text?.trimmingCharacters(in: .whitespaces) == "" || passwordTextFieldOutlet.text?.trimmingCharacters(in: .whitespaces) == ""{
            return "Please fill in all fields"
        }
        
        let cleanedPassword = passwordTextFieldOutlet.text!.trimmingCharacters(in: .whitespaces)
        
        if isPasswordValid(cleanedPassword){
            
        }else{
            let alert = UIAlertController(title: "ERROR", message: "Invalid username or password.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok", style: .default , handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        
        return nil
    }
    
    @IBAction func logInAction(_ sender: Any) {
        
        //validate text fields
        if validateFields() == nil{
            let email = emailTextFieldOutlet.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextFieldOutlet.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if email != "admin@d155.org" {
                //logIn
                Auth.auth().signIn(withEmail: email, password: password) { result, error in
                    if error != nil{
                        
                        if error?.localizedDescription != "The supplied auth credential is malformed or has expired." {
                            
                            self.errorLabel.textColor = UIColor.red
                            self.errorLabel.text = "\(error!.localizedDescription)"
                        }else{
                            self.errorLabel.textColor = UIColor.red
                            self.errorLabel.text = "Invalid email or password."
                        }
                    }else{
                        
                        
                        for stud in AppData.masterUsers{
                            if stud.uid == result?.user.uid{
                                AppData.user = stud
                                break
                            }
                        }
                        
                        //goes to main view countroller if log in is successful
                        let homeViewController = self.storyboard?.instantiateViewController(identifier: "homeVC") as? MainVC
                        
                        self.view.window?.rootViewController = homeViewController
                        self.view.window?.makeKeyAndVisible()
                    }
                }
            }else{
                if password == "admin123!"{
                    performSegue(withIdentifier: "toAdmin", sender: self)
                    return
                    
                }else{
                    self.errorLabel.textColor = UIColor.red
                    self.errorLabel.text = "Invalid email or password."
                }
                
            }
            } else{
                self.errorLabel.textColor = UIColor.red
                self.errorLabel.text = validateFields()
            }
        }
    }

