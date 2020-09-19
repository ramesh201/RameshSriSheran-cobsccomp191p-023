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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("user profile")
        
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
