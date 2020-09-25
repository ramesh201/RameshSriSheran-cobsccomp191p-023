//
//  UpdateViewController.swift
//  NIBMCOVID19
//
//  Created by Ramesh Sheran on 8/22/20.
//  Copyright © 2020 Ramesh Sheran. All rights reserved.
//

import UIKit
import FirebaseAuth
import LocalAuthentication

class  UpdateScrnProcList{
    var SettingTitle: String?
    var SettingSubtitle: String?
    
    init(settingTitle:String , settingSubtitle: String){
        self.SettingTitle = settingTitle
        self.SettingSubtitle = settingSubtitle
    }
}

class UpdateViewController: UIViewController {
let currUser = Auth.auth().currentUser
    //@IBOutlet weak var lblTitle: UILabel!
    var latestTempUId = ""
    
    @IBOutlet weak var lblCNotifi: UILabel!
    @IBOutlet weak var lblGoCNotifi: UIButton!
    var updateArray = [UpdateScrnProcList]()
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblTemperatureLastUpdate: UILabel!
    @IBOutlet weak var txtTemperature: UITextField!
    @IBAction func btnUpdateTemp(_ sender: UIButton) {
        
      latestTempUId  = String((Auth.auth().currentUser?.email?.split(separator: "@")[0])!)
        
        
                  let formatter = DateFormatter()
                  formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

                  let myString = formatter.string(from: Date())
                  let yourDate = formatter.date(from: myString)
                  
                  formatter.dateFormat = "dd-MMM-yyyy"
                  let myStringafd = formatter.string(from: yourDate!)
        
        
        let post = ["uid": latestTempUId,
                    "temperature": txtTemperature.text,
                    "createdDate": myStringafd] as [String : Any]
        let childUpdates = ["/userTemperature/\(latestTempUId)": post
                            //"/user-posts/\(1200)/\(key)/": post
        ]
        DB_REF.updateChildValues(childUpdates)
        
        
        
          let context = LAContext()
          var error: NSError?

          if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
              let reason = "Identify yourself!"

              context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                  [weak self] success, authenticationError in

                  DispatchQueue.main.async {
                      if success {
                          let ac = UIAlertController(title: "Authentication success", message: "You have got permission to update body temperature", preferredStyle: .alert)
                          ac.addAction(UIAlertAction(title: "Continue", style: .default))
                          self?.present(ac, animated: true)
                        
                        self!.updateUserTemperature(latestTempUId: self!.latestTempUId)
                        
                      } else {
                          let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                          ac.addAction(UIAlertAction(title: "OK", style: .default))
                          self?.present(ac, animated: true)
                      }
                  }
              }
          } else {
              let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
              ac.addAction(UIAlertAction(title: "OK", style: .default))
              self.present(ac, animated: true)
          }
        
        
        
        /*DB_REF.child("userTemperature/\(latestTempUId)").observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
            guard let value = snapshot.value as? [String: Any] else { return }
            guard let temperature = value["temperature"] as? String else { return }
            guard let updatedDate = value["createdDate"] as? String else { return }
            //let username = ""
            //var username2 = value as? String ?? ""
            
            self.lblTemperature.text = temperature
            self.lblTemperatureLastUpdate.text = self.lblTemperatureLastUpdate.text!.appending((" "+updatedDate))
            
        }) { (error) in
            print(error.localizedDescription)
        }*/
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Update")
        if(Auth.auth().currentUser?.isAnonymous != nil){
            latestTempUId  = String((Auth.auth().currentUser?.email?.split(separator: "@")[0])!)
            
            updateUserTemperature(latestTempUId: latestTempUId)
        
        DB_REF.child("users/\(latestTempUId)").observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
            guard let value = snapshot.value as? [String: Any] else { return }
            guard let roleType = value["roleType"] as? Int else { return }
            
            if(roleType == 0){
                self.lblCNotifi.isHidden = true
                self.lblGoCNotifi.isHidden = true
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
            
        }
        
        
    }
    
    func updateUserTemperature(latestTempUId: String) {
        
        DB_REF.child("userTemperature/\(latestTempUId)").observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
            guard let value = snapshot.value as? [String: Any] else { return }
            guard let temperature = value["temperature"] as? String else { return }
            guard let updatedDate = value["createdDate"] as? String else { return }
            //let username = ""
            //var username2 = value as? String ?? ""
            
            self.lblTemperature.text = temperature
            self.lblTemperatureLastUpdate.text = "Last Update: " + updatedDate
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Update")
        if(Auth.auth().currentUser?.isAnonymous != nil){
            latestTempUId  = String((Auth.auth().currentUser?.email?.split(separator: "@")[0])!)
            
            updateUserTemperature(latestTempUId: latestTempUId)
        
        DB_REF.child("users/\(latestTempUId)").observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
            guard let value = snapshot.value as? [String: Any] else { return }
            guard let roleType = value["roleType"] as? Int else { return }
            
            if(roleType == 0){
                self.lblCNotifi.isHidden = true
                self.lblGoCNotifi.isHidden = true
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            //((user?.isAnonymous) != nil)
            //self.isLoggedin = (auth.currentUser != nil)
             if (auth.currentUser?.isAnonymous != nil){
                //performSegue(withIdentifier: "showUpdateView", sender: self)
                print("logged in")
                //self.lblCNotifi.isHidden = true
                //self.lblGoCNotifi.isHidden = false
            }
            else{
                self.performSegue(withIdentifier: "showAuthentication", sender: self)
                print("not logged in")
                
            }
        }
        
        let Notification = UpdateScrnProcList (settingTitle: "User Profile", settingSubtitle: "Visit your profile")
        
        updateArray.append(Notification)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*var cell = tableView.dequeueReusableCell(withIdentifier: "settingstable2")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle,reuseIdentifier: "settingstable2")
            cell?.textLabel?.text = settingArray[indexPath.row].SettingTitle
            cell?.detailTextLabel?.text = settingArray[indexPath.row].SettingSubtitle
            
        }*/
        
        /*var cell = tableView.dequeueReusableCell(withIdentifier: "updatestable2") as! CustomTableViewCell
        
        cell.lblTitle.text =
           
        updateArray[indexPath.row].SettingTitle
        */
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "updatestable2")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle,reuseIdentifier: "notificationstable")
            cell?.textLabel?.text = updateArray[indexPath.row].SettingTitle
            

            
    }
        return cell!
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AuthenticationViewController {
            
            print(destination)
            /*destination.lblHeader = settingArray[(tblSettingList.indexPathForSelectedRow?.row)!].SettingSubtitle*/
            //destination.settingObj = settingArray[(tblSettingList.indexPathForSelectedRow?.row)!]
            
            //tblSettingList.deselectRow(at: tblSettingList.indexPathForSelectedRow!, animated: true)
            
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
