//
//  UpdateViewController.swift
//  NIBMCOVID19
//
//  Created by Ramesh Sheran on 8/22/20.
//  Copyright © 2020 Ramesh Sheran. All rights reserved.
//

import UIKit
import FirebaseAuth

class UpdateViewController: UIViewController {

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
            }
            else{
                self.performSegue(withIdentifier: "showAuthentication", sender: self)
                                print("not logged in")
                
            }
        }
        
        
        
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

}
