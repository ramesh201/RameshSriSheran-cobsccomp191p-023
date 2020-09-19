//
//  NotificationListViewController.swift
//  NIBMCOVID19
//
//  Created by Ramesh Sheran on 9/18/20.
//  Copyright © 2020 Ramesh Sheran. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth
import FirebaseFirestore

class  NotificationListArr{
    var NotificationListTitle: String?
    var NotificationListSubtitle: String?
    
    init(notificationListTitle:String , notificationListSubtitle: String){
        self.NotificationListTitle = notificationListTitle
        self.NotificationListSubtitle = notificationListSubtitle
    }
}

class NotificationListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var notifyArray = [NotificationListArr]()
    var notific: NotificationListArr?
    var list: String = ""
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var tblNotification: UITableView!
    
    @IBOutlet weak var lblTitleNotifi1: UILabel!
    @IBOutlet weak var lblSubtitleNoti1: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        
       
              
    }
    
    override func viewDidLoad() {
        
        DB_REF.child("notifications").observe(.value) { snapshot in
                   for child in snapshot.children.allObjects as! [DataSnapshot] {
                   //print(child.value)
                   let dict = child.value as? [String : AnyObject] ?? [:]
                       
                       //guard let dict2 = child.value as? String else { [:] }
                       print(dict , " - ",String((dict["notifiTitle"] as? String ?? "")))
                        let dictVal = ""//dict["notifiTitle"] as? String else { return }
                       
                       let userProfile = NotificationListArr(notificationListTitle: String((dict["notifiTitle"] as? String ?? "")), notificationListSubtitle:String((dict["notifiBody"] as? String ?? "")))
                       
                       self.notifyArray.append(userProfile)
                       self.tblNotification.reloadData()
                       
                 }
               }
        
        super.viewDidLoad()
        
        
       
        
      
        
        tblNotification.dataSource = self
        tblNotification.delegate = self
       
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationtable") as! CustomTableViewCell
        

        cell.lblNotifiTitle.text = notifyArray[indexPath.row].NotificationListTitle
        
        cell.lblNotifiSubtitle.text = notifyArray[indexPath.row].NotificationListSubtitle

        cell.backgroundColor = indexPath.row % 2 == 0 ? .black : .darkGray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { 
        //tableView.deselectRow(at: indexPath, animated: true)
        var selectedIdx: Int?
        selectedIdx = tblNotification.indexPathForSelectedRow?.row
        
        showAlert(title:  notifyArray[selectedIdx!].NotificationListTitle!,
                  message:
            notifyArray[selectedIdx!].NotificationListSubtitle!
        )
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return 70
        
    }
    
     func showAlert(title: String, message: String) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let action = UIAlertAction(title: "OK", style: .default, handler: nil)
           alert.addAction(action)
           present(alert, animated: true, completion: nil)
       }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
