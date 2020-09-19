//
//  FirstViewController.swift
//  NIBMCOVID19
//
//  Created by Ramesh Sheran on 8/19/20.
//  Copyright © 2020 Ramesh Sheran. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth
import FirebaseFirestore

class  NotificationList{
    var NotificationTitle: String?
    var NotificationSubtitle: String?
    
    init(notificationTitle:String , notificationSubtitle: String){
        self.NotificationTitle = notificationTitle
        self.NotificationSubtitle = notificationSubtitle
    }
}

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let db = Firestore.firestore()
    
    @IBOutlet var txtUsername: UITextField!
    @IBOutlet weak var tblNotification: UITableView!
    @IBOutlet var lblUserName: UILabel!
    @IBAction func btnSafeAction(_ sender: UIButton) {
        
    }
    @IBAction func btnLogout(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        super.viewDidLoad()
        
    }
    @IBAction func btnLogin(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: "mac@book.pro", password: "123456") { [weak self] authResult, error in
          guard let strongSelf = self else { return }
          // ...
        }
        super.viewDidLoad()
    }
    var notificationArray = [NotificationList]()
    //var notificationDetails = String? ?? ""// = "" ?? ""
    var notificationDetails : String = "My name"
    var isLoggedin = Bool()
    
    
  
    @IBOutlet weak var lblTitleNotifi: UILabel!
    @IBOutlet weak var lblSubtitleNoti: UILabel!
    @IBAction func btnCreateLatestNotify(_ sender: UIButton) {
        
        let post = ["uid": Constants().latestNotifyKey,
                    "title": "NIBM Closed",
                    "body": "Keep in touch to get our latest NEWS updates"] as [String : Any]
        let childUpdates = ["/latestnotifications/\(Constants().latestNotifyKey)": post
                            //"/user-posts/\(1200)/\(key)/": post
        ]
        DB_REF.updateChildValues(childUpdates)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        /*let notification2 = NotificationList(notificationTitle: self.notificationDetails, notificationSubtitle: "Visit your profile")
        
        self.notificationArray.append(notification2)*/
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        self.tblNotification?.dataSource = self
        self.tblNotification?.delegate = self       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var ref: DatabaseReference!

        ref = Database.database().reference()
        //FirebaseApp.configure()
        //print("ref ok")
        /*ref.child("users").child("1600").setValue(["username": "username 005"])
        ref.child("users").child("1601").setValue(["username": "username 006"])
*/
        /*
        guard let key = ref.child("roles").childByAutoId().key else { return }
        let userRole = ["uid": 2000,
                    "roleId": 1,
                    "createdDate": "2020-09-11 10:00:00",
                    "isActive": true,
                    "ModifiedDate": "2020-09-11 11:00:00"] as [String : Any]
        var childUpdates = [
                            "/user-roles/\(2000)/": userRole]
        ref.updateChildValues(childUpdates)
        
        
        let userID = "1500"//Auth.auth().currentUser?.uid
        ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
          let value = snapshot.value as? NSDictionary
            var username = value?["username"] as? String ?? ""
            self.presentWinningAlert(title: username)
            //let user = (uid: self.presentWinningAlert(title: username))
            print(username)
            self.txtUsername?.text = username
            self.notificationDetails = username
            
            //print(self.isLoggedin)
            
        }) { (error) in
            print(error.localizedDescription)
        }
        */
        
       /* FirebaseDatabase.database().ref("users/" + 1500).set({
            username : "name",
            email : "email",
          profile_picture : "imageUrl"
        });
        */
        
        //guard let userId = result?.user.uid else { return }
       
        /*
        let userObj = [
        "userEmail": "emailvghjgvhj",
        "userFullName": "fullName",
        "roleType": 1,
        "address": "address",
        "userIndexCode": "userIndexCode",
        "userImage": Constants().userImage
        ] as [String : Any]
        
         childUpdates = [
        "/users/\(1600)/": userRole]
        */
        
        
        
       /* ref.child("user-roles").child("1500").observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
          let value = snapshot.value as? NSDictionary
            var username = "user 01"
            var username2 = value?.allValues//(forKey: userID) as? String ?? ""
            
            self.presentWinningAlert(title: username)
            //let user = (uid: self.presentWinningAlert(title: username))
            print(username)
            self.txtUsername?.text = self.txtUsername?.text?.appending(username) //username
            self.notificationDetails = username
            
            //print(self.isLoggedin)
            
        }) { (error) in
            print(error.localizedDescription)
        }*/
        
        var x = ref.child("roles")
        var y = ref.child("user-roles/\("1500")/roleId").setValue(2)
        
        /*ref.child("user-roles/\("1500")").observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
          let value = snapshot.value as? NSDictionary
            let username = ""
            var username2 = value as? String ?? ""
            //var x = username2
            self.presentWinningAlert(title: username)
            //let user = (uid: self.presentWinningAlert(title: username))
            print(username)
            self.txtUsername?.text = self.txtUsername?.text?.appending(username) //username
            self.notificationDetails = username
            
            //print(self.isLoggedin)
            
        }) { (error) in
            print(error.localizedDescription)
        }*/
        
        let uid = "mac" //Auth.auth().currentUser!.isAnonymous ?; return : String((Auth.auth().currentUser?.email?.split(separator: "@")[0])!)  //"mac"
        
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
        
        
        ref.child("latestnotifications/\(Constants().latestNotifyKey)").observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
          let value = snapshot.value as? NSDictionary
            //let username = ""
            var username2 = value as? String ?? ""
            //var x = username2
            //self.presentWinningAlert(title: username)
            //let user = (uid: self.presentWinningAlert(title: username))
            //print(username)
            self.txtUsername?.text = self.txtUsername?.text?.appending(value?["title"] as? String ?? "").appending(value?["body"] as? String ?? "") //username
            //self.notificationDetails = username
            let title  = value?["title"]! // as? String ?? ""
            let subTitle  = value?["body"]!

            //let tempVal = value?.value(forKeyPath: "notifiTitle")
            guard let titleNotify = title as? String else { return }
            guard let subTitleNotify = subTitle as? String else { return }
            
            self.lblTitleNotifi?.text = title as! String //titleNotify
            self.lblSubtitleNoti?.text = subTitle as! String
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        /*userID = Auth.auth().currentUser?.uid as! String
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
          let value = snapshot.value as? NSDictionary
          let roleId = value?["roleType"] as? String ?? ""

            let userObj = [
                "notifiTitle": self.txtTitle.text,
                "notifiBody": self.txtBody.text,
            "uid": value?["uid"] as? String ?? "",
            "userID": String(uid.lowercased().split(separator: "@")[0]),
            "roleType": roleId,
            "createdDate": myStringafd
                ] as [String : Any]
            
            self.uploadUserNotificationsAndShowHomeController(userId: String(uid.lowercased().split(separator: "@")[0]), userObj: userObj)
            
          }) { (error) in
            print(error.localizedDescription)
        }*/
        
        //ref.child("users/\("1500")/username").setValue("hello 01")

        /*guard let key = ref.child("posts").childByAutoId().key else { return }
        let post = ["uid": 1500,
                    "author": "No Name 01",
                    "title": "No Title",
                    "body": "No Body"] as [String : Any]
        let childUpdates = ["/posts/\(key)": post
                            //"/user-posts/\(1200)/\(key)/": post
        ]
        ref.updateChildValues(childUpdates)*/
        //print("update ok")

        /*Auth.auth().signIn(withEmail: "gametrainer2013@gmail.com", password: "iosapp") { [weak self] authResult, error in
          guard let strongSelf = self else { return }
          // ...
        }*/
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
           //((user?.isAnonymous) != nil)
           //self.isLoggedin = (auth.currentUser != nil)
            if (auth.currentUser?.isAnonymous != nil){
                self.lblUserName?.text  = user!.email
           }
           else{
            self.lblUserName?.text = "Guest User"
               
           }
       }
          /*  let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }*/
              }

    func presentWinningAlert(title: String){
    var moveCounter = 0
        _ = UIAlertController(title: title, message: "byr", preferredStyle: UIAlertController.Style.alert)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "notificationstable")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle,reuseIdentifier: "notificationstable")
            cell?.textLabel?.text = notificationArray[indexPath.row].NotificationTitle
            cell?.detailTextLabel?.text = notificationArray[indexPath.row].NotificationSubtitle
            
        }
        return cell!
    }
    
    func configure(){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

