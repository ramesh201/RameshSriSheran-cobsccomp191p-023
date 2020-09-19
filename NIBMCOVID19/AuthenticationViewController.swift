//
//  AuthenticationViewController.swift
//  NIBMCOVID19
//
//  Created by Ramesh Sheran on 8/22/20.
//  Copyright © 2020 Ramesh Sheran. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {

    @IBAction func btnExit(_ sender: UIButton) {
        /*_ = self.navigationController?.popViewController(animated: true)*/
        
        //_ = self.dismiss(animated: true)
        
        /*navigationController?.popToRootViewController(animated: true)*/
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FirstViewController {
            
            print(destination)
            /*destination.lblHeader = settingArray[(tblSettingList.indexPathForSelectedRow?.row)!].SettingSubtitle*/
            //destination.settingObj = settingArray[(tblSettingList.indexPathForSelectedRow?.row)!]
            
            //tblSettingList.deselectRow(at: tblSettingList.indexPathForSelectedRow!, animated: true)
            
        }
    }    /*
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
