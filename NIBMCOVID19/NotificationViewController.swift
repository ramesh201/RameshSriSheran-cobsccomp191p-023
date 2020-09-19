//
//  NotificationViewController.swift
//  NIBMCOVID19
//
//  Created by Ramesh Sheran on 9/13/20.
//  Copyright © 2020 Ramesh Sheran. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore
import CoreLocation

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtBody: UITextField!
    
    @IBAction func btnSaveNotifi(_ sender: UIButton) {
        
        
        
        var userID = "1601"
        userID = Auth.auth().currentUser?.email as! String
       
           //guard let uid = Auth.auth().currentUser?.uid else { return }
        let uid = String((Auth.auth().currentUser?.email?.split(separator: "@")[0])!)
        
        let formatter = DateFormatter()
                  // initially set the format based on your datepicker date / server String
                  formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

                  let myString = formatter.string(from: Date()) // string purpose I add here
                  // convert your string to date
                  let yourDate = formatter.date(from: myString)
                  //then again set the date format whhich type of output you need
                  formatter.dateFormat = "dd-MMM-yyyy"
                  // again convert your date to string
                  let myStringafd = formatter.string(from: yourDate!)
        
        
        
        
        userID = Auth.auth().currentUser?.uid as! String
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
          //let value = snapshot.value as? NSDictionary
          //let roleId = value?["roleType"] as? String ?? ""
          //guard let roleId = value?["roleType"] as? String else { return }
            
            guard let value = snapshot.value as? [String: Any] else { return }
                       guard let roleType = value["roleType"] as? Int else { return }
            
            var latestNotifyKey: String
            latestNotifyKey = String(uid.lowercased().split(separator: "@")[0])
            
            let userObj = [
                "notifiTitle": self.txtTitle.text,
                "notifiBody": self.txtBody.text,
            "uid": "",
            "userID": latestNotifyKey,
            "roleType": roleType,
            "createdDate": myStringafd
                ] as [String : Any]
            
            self.uploadUserNotificationsAndShowHomeController(userId: latestNotifyKey, userObj: userObj)
            

            let post = ["uid": Constants().latestNotifyKey,
                        "title": self.txtTitle.text,
                        "body": self.txtBody.text] as [String : Any]
            let childUpdates = ["/latestnotifications/\(Constants().latestNotifyKey)": post
                                //"/user-posts/\(1200)/\(key)/": post
            ]
            DB_REF.updateChildValues(childUpdates)
            
          }) { (error) in
            print(error.localizedDescription)
        }
        
        /*Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
          let value = snapshot.value as? NSDictionary
            var username = "user 01"
            var username2 = value?.allValues//(forKey: userID) as? String ?? ""
            
        }) { (error) in
            print(error.localizedDescription)
        }*/
        
        /*REF_USERS.child(uid).observe(.value) { (snapshot) in
                
                let uid = snapshot.key
                
                guard let dictionary = snapshot.value as? [String: Any] else { return }
            }*/
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//var ref: DatabaseReference!
        // Do any additional setup after loading the view.
    }
    
    func uploadUserNotificationsAndShowHomeController(userId: String, userObj: [String: Any]) {
        REF_NOTIFICATIONS.child(userId).updateChildValues(userObj) { (error, ref) in
           
            self.dismiss(animated: true, completion: nil)
            
            //let vc = FirstViewController()
            //self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
      override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
      }

}
