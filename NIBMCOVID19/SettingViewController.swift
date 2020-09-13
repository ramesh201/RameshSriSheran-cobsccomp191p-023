//
//  SettingViewController.swift
//  NIBMCOVID19
//
//  Created by Ramesh Sheran on 8/20/20.
//  Copyright © 2020 Ramesh Sheran. All rights reserved.
//
import UIKit
import Foundation
import FirebaseAuth

class  SettingList{
    var SettingTitle: String?
    var SettingSubtitle: String?
    
    init(settingTitle:String , settingSubtitle: String){
        self.SettingTitle = settingTitle
        self.SettingSubtitle = settingSubtitle
    }
}
class SettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblSettingList: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    var settingArray = [SettingList]()
    var setting: SettingList?
    var statusUser: Bool = false
    var SettingIconList = ["person.badge.plus.fill","phone.down.circle.fill","person.3.fill","doc.text.fill","person.circle.fill"]

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
        print("Setting")
        
          let createAccount = SettingList(settingTitle: "SignUp", settingSubtitle: "Create a new account")
           
           
           let contactUs = SettingList(settingTitle: "Contact Us", settingSubtitle: "Contact NIBM for help")
           
           
           let shareNow = SettingList(settingTitle: "Share with friends", settingSubtitle: "Let to know your freinds")
           
           
           let surveyResult = SettingList(settingTitle: "Survey Result", settingSubtitle: "View survey results")
           
           
           let userProfile = SettingList(settingTitle: "User Profile", settingSubtitle: "Visit your profile")
           
           
           
        
        settingArray.append(createAccount)
        settingArray.append(contactUs)
        settingArray.append(shareNow)
        settingArray.append(surveyResult)
        settingArray.append(userProfile)
        
        tblSettingList.dataSource = self
        tblSettingList.delegate = self
        
        
    }
        
        
    
    override func viewDidAppear(_ animated: Bool) {
        print("Setting")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        let currUser = Auth.auth().currentUser
        
        if (currUser?.isAnonymous != nil){
            
                if indexPath.row == 0 || indexPath.row == 4 {
                    return 0
                }
                else{
                    return 73
                }
            
            
            
        }
        else{
            
                 if indexPath.row == 3 {
                               return 0
                           }
                 else{
                    return 73
                }
            
            /*else if indexPath.row == 4 {
                if indexPath.row == 4 {
                    return 0
                }
                else{
                    return 100
                }
            }*/
        }
            
            /*_ = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if (auth.currentUser?.isAnonymous != nil){
               //performSegue(withIdentifier: "showUpdateView", sender: self)
               print("logged in")
                self.statusUser = true
                //self.settingArray.inde//(at: 0)
            //(contactUs)
               /*self.settingArray.append(shareNow)
               self.settingArray.append(surveyResult)
               self.settingArray.append(userProfile)*/
                
             /*if indexPath.row == 1 {
                       return 0
                   }
                DispatchQueue.main.async {
                   self.tblSettingList.reloadData()
                   
               }*/
                
                
        }
           else{
               print("not logged in")
                self.statusUser = false
               
           }
            
        }*/

        /*DispatchQueue.main.async {
            self.tblSettingList.reloadData()
        }*/
        
        return -1.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*var cell = tableView.dequeueReusableCell(withIdentifier: "settingstable2")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle,reuseIdentifier: "settingstable2")
            cell?.textLabel?.text = settingArray[indexPath.row].SettingTitle
            cell?.detailTextLabel?.text = settingArray[indexPath.row].SettingSubtitle
            
        }*/
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "settingstable2") as! CustomTableViewCell
        cell.lblTitle.text = settingArray[indexPath.row].SettingTitle
        cell.lblSubtitle.text = settingArray[indexPath.row].SettingSubtitle
        cell.imgBullet.image = UIImage(systemName: SettingIconList[indexPath.row])/*UIImage(named: SettingIconList[indexPath.row])*/
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        var selectedIdx: Int?
        selectedIdx = tblSettingList.indexPathForSelectedRow?.row
        //var idx: Int = 1
        if selectedIdx == 0{
            performSegue(withIdentifier: "showSignup", sender: self)
        }
        else if selectedIdx == 1{
            performSegue(withIdentifier: "showContactUs", sender: self) //showContactUs
            
        }
        else if selectedIdx == 2{
            performSegue(withIdentifier: "showShareApp", sender: self)
        }
        else if selectedIdx == 3{
            performSegue(withIdentifier: "showSurveyResult", sender: self)
        }
        else if selectedIdx == 4{
            performSegue(withIdentifier: "showUserProfile", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSignup"
        {
            if let destination = segue.destination as? AuthenticationViewController {
                
                print(destination)
                /*destination.lblHeader = settingArray[(tblSettingList.indexPathForSelectedRow?.row)!].SettingSubtitle*/
                //destination.settingObj = settingArray[(tblSettingList.indexPathForSelectedRow?.row)!]
                
                tblSettingList.deselectRow(at: tblSettingList.indexPathForSelectedRow!, animated: true)
                
            }
        }
        else if segue.identifier == "showContactUs"
        {
            if let destination = segue.destination as? ContactUsViewController {
                
                print(destination)
                /*destination.lblHeader = settingArray[(tblSettingList.indexPathForSelectedRow?.row)!].SettingSubtitle*/
                //destination.settingObj = settingArray[(tblSettingList.indexPathForSelectedRow?.row)!]
                
                tblSettingList.deselectRow(at: tblSettingList.indexPathForSelectedRow!, animated: true)
                
            }
        }
        else if segue.identifier == "showShareApp"
        {
            if let destination = segue.destination as? ShareAppViewController {
                
                print(destination)
                /*destination.lblHeader = settingArray[(tblSettingList.indexPathForSelectedRow?.row)!].SettingSubtitle*/
                //destination.settingObj = settingArray[(tblSettingList.indexPathForSelectedRow?.row)!]
                
                tblSettingList.deselectRow(at: tblSettingList.indexPathForSelectedRow!, animated: true)
                
            }
        }
        else if segue.identifier == "showSurveyResult"
        {
            if let destination = segue.destination as? SurveyResultViewController {
                
                print(destination)
                /*destination.lblHeader = settingArray[(tblSettingList.indexPathForSelectedRow?.row)!].SettingSubtitle*/
                //destination.settingObj = settingArray[(tblSettingList.indexPathForSelectedRow?.row)!]
                
                tblSettingList.deselectRow(at: tblSettingList.indexPathForSelectedRow!, animated: true)
                
            }
        }
        else if segue.identifier == "showUserProfile"
        {
            if let destination = segue.destination as? UserProfileViewController {
                
                print(destination)
                /*destination.lblHeader = settingArray[(tblSettingList.indexPathForSelectedRow?.row)!].SettingSubtitle*/
                //destination.settingObj = settingArray[(tblSettingList.indexPathForSelectedRow?.row)!]
                
                tblSettingList.deselectRow(at: tblSettingList.indexPathForSelectedRow!, animated: true)
                
            }
        }
    }
}
