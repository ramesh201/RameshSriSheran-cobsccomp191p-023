//
//  ViewController.swift
//  NIBMCOVID19
//
//  Created by Ramesh Sheran on 8/22/20.
//  Copyright © 2020 Ramesh Sheran. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var ref: DatabaseReference!

        ref = Database.database().reference()
        
        guard let key = ref.child("posts").childByAutoId().key else { return }
        let post = ["uid": 1200,
                    "author": "No Name",
                    "title": "No Title",
                    "body": "No Body"] as [String : Any]
        let childUpdates = ["/posts/\(key)": post,
                            "/user-posts/\(1200)/\(key)/": post]
        ref.updateChildValues(childUpdates)
        
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
