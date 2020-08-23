//
//  LoginViewController.swift
//  NIBMCOVID19
//
//  Created by Ramesh Sheran on 8/22/20.
//  Copyright © 2020 Ramesh Sheran. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        Auth.auth().signIn(withEmail: "gametrainer2013@gmail.com", password: "iosapp") { [weak self] authResult, error in
            guard self != nil else { return }
          // ...
        }    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        Auth.auth().signIn(withEmail: "gametrainer2013@gmail.com", password: "iosapp") { [weak self] authResult, error in
            guard self != nil else { return }
          // ...
        } 
            //((user?.isAnonymous) != nil)
            //self.isLoggedin = (auth.currentUser != nil)
             _ = Auth.auth().addStateDidChangeListener { (auth, user) in
                 //((user?.isAnonymous) != nil)
                 //self.isLoggedin = (auth.currentUser != nil)
                  if (auth.currentUser?.isAnonymous != nil){
                      print("logged in")
                 }
                 else{
                  print("not logged in")
                     
                 }
             }
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


