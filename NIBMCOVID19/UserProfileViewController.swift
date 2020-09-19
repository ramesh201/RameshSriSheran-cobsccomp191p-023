//
//  UserProfileViewController.swift
//  NIBMCOVID19
//
//  Created by Ramesh Sheran on 8/23/20.
//  Copyright © 2020 Ramesh Sheran. All rights reserved.
//

import UIKit
import FirebaseAuth

class UserProfileViewController: UIViewController {

    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblFN: UILabel!
    @IBOutlet weak var lblLN: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblIndexCode: UILabel!
    @IBOutlet weak var lblRole: UILabel!
    @IBAction func btnLogout(_ sender: UIButton) {
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        super.viewDidLoad()
    }
    var roleId: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        print("user profile")
        let currUser = Auth.auth().currentUser
        
        /*var imageView = UIImageView(frame: )
        // Do any additional setup after loading the view.
        let urlStr = "sliderImagesArray.object(at: i)"
            //print(scrollView,imageView, urlStr)
        imageView.af_se(with: URL(string: urlStr as! String), placeholderImage: UIImage(named: "placeholder.png"))
        imageView .contentMode = UIView.ContentMode.scaleToFill
        
        imgUser.image =  imageView.af_se(with: URL(string: urlStr as! String), placeholderImage: UIImage(named: "placeholder.png"))
        */
        let urlStr = "https://www.apple.com/ac/structured-data/images/knowledge_graph_logo.png?202009101814"
        getImageFromWeb(urlStr as! String) { (image) in
            if let image = image {
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
                //imageView.image = image
                self.imgUser.image = image
                //self.view.addSubview(imageView)
                //self.scrollView.addSubview(imageView)
            } // if you use an Else statement, it will be in background
        }
        
        var uid = String((currUser?.email!.lowercased().split(separator: "@")[0])!)
        
        
        REF_USERS.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                // Get user value
            guard let value = snapshot.value as? [String: Any] else { return }
            guard let fullName = value["userFullName"] as? String else { return }
            guard let address = value["address"] as? String else { return }
            guard let indexCode = value["userIndexCode"] as? String else { return }
            guard let role = value["roleType"] as? Int else { return }
            //roleId = role
            
            let fName = fullName.split(separator: " ")[0]
            let lName = fullName.split(separator: " ").count == 2 ?  fullName.split(separator: " ")[1] : "-"
            
            var username2 = value as? String ?? ""
           
            
                
            //print(username)
            self.lblFN.text = String(fName)
            self.lblLN.text = String(lName)
            self.lblAddress.text = String(address)
            self.lblIndexCode.text = String(indexCode)
            
            self.roleId = role
            
            var roleName: String = ""
            DB_REF.child("roles").child(String(self.roleId)).observeSingleEvent(of: .value, with: { (snapshot) in
                guard let value2 = snapshot.value as? [String: Any] else { return }
                guard let userRole = value2["roleName"] as? String else { return }
                
                roleName = userRole
                self.lblRole.text = String(roleName)
            }) { (error) in
                print(error.localizedDescription)
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        
        
        
    }
    
    func getImageFromWeb(_ urlString: String, closure: @escaping (UIImage?) -> ()) {
               guard let url = URL(string: urlString) else {
       return closure(nil)
               }
               let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                   guard error == nil else {
                       print("error: \(String(describing: error))")
                       return closure(nil)
                   }
                   guard response != nil else {
                       print("no response")
                       return closure(nil)
                   }
                   guard data != nil else {
                       print("no data")
                       return closure(nil)
                   }
                   DispatchQueue.main.async {
                       closure(UIImage(data: data!))
                   }
               }; task.resume()
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
