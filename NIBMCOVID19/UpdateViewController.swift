//
//  UpdateViewController.swift
//  NIBMCOVID19
//
//  Created by Ramesh Sheran on 8/22/20.
//  Copyright © 2020 Ramesh Sheran. All rights reserved.
//

import UIKit
import FirebaseAuth

class  UpdateScrnProcList{
    var SettingTitle: String?
    var SettingSubtitle: String?
    
    init(settingTitle:String , settingSubtitle: String){
        self.SettingTitle = settingTitle
        self.SettingSubtitle = settingSubtitle
    }
}

class UpdateViewController: UIViewController {

    //@IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCNotifi: UILabel!
    @IBOutlet weak var lblGoCNotifi: UIButton!
    var updateArray = [UpdateScrnProcList]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Update")
    }
    override func viewDidAppear(_ animated: Bool) {
        print("Update")
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
