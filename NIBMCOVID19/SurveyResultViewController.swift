//
//  SurveyResultViewController.swift
//  NIBMCOVID19
//
//  Created by Ramesh Sheran on 8/23/20.
//  Copyright © 2020 Ramesh Sheran. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth
import FirebaseFirestore




class  SurveyArr{
    var SurveyTitle: String?
    var SurveyResult: String?
    
    init(surveyTitle:String , surveyResult: String){
        self.SurveyTitle = surveyTitle
        self.SurveyResult = surveyResult
    }
}

class SurveyResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var surveyArray = [SurveyArr]()
    var survey: SurveyArr?
    
    var q1Tot: Int = 0
    var q2Tot: Int = 0
    var q3Tot: Int = 0
    var q4Tot: Int = 0
    
    @IBOutlet weak var tblSurveyResults: UITableView!
    override func viewDidLoad() {
        
        
         
               DB_REF.child("surveys").observe(.value) { snapshot in
                for child in snapshot.children.allObjects as! [DataSnapshot] {
                          //print(child.value)
                          let dict = child.value as? [String : AnyObject] ?? [:]
                              
                              //guard let dict2 = child.value as? String else { [:] }
                              print(dict)
                            let q1 = dict["question1"] as! Int
                            let q2 = dict["question2"] as! Int
                            let q3 = dict["question3"] as! Int
                            let q4 = dict["question4"] as! Int
                            
                            self.q1Tot = self.q1Tot + q1
                            self.q2Tot = self.q2Tot + q2
                            self.q3Tot = self.q3Tot + q3
                            self.q4Tot = self.q4Tot + q4
                            
                            
                            //dict["notifiTitle"] as? String else { return }
                              /*
                              let userProfile = NotificationListArr(notificationListTitle: String((dict["notifiTitle"] as? String ?? "")), notificationListSubtitle:String((dict["notifiBody"] as? String ?? "")))
                              
                              self.notifyArray.append(userProfile)
                              self.tblNotification.reloadData()
 
 */
                              
                        }
                                //print(self.q3Tot , "/", snapshot.children.allObjects.count)
                
                var surveyItem1Details =
                    SurveyArr(surveyTitle: "Are you having any symptoms above?", surveyResult: (String(self.q1Tot) + "/" + String(snapshot.children.allObjects.count)))
                
                self.surveyArray.append(surveyItem1Details)
                
                var surveyItem2Details =
                    SurveyArr(surveyTitle: "Have you been travelling in between last 14 days?", surveyResult: (String(self.q2Tot) + "/" + String(snapshot.children.allObjects.count)))
                
                self.surveyArray.append(surveyItem2Details)
                
                var surveyItem3Details =
                    SurveyArr(surveyTitle: "Have you been exposed with crowded places?", surveyResult: (String(self.q3Tot) + "/" + String(snapshot.children.allObjects.count)))
                
                self.surveyArray.append(surveyItem3Details)
                
                var surveyItem4Details =
                    SurveyArr(surveyTitle: "Have you been interacted with any sick person recently?", surveyResult: (String(self.q4Tot) + "/" + String(snapshot.children.allObjects.count)))
                
                self.surveyArray.append(surveyItem4Details)
                
                var surveyItem5Details =
                    SurveyArr(surveyTitle: "Stay Safe", surveyResult: "Make yourself protected from covid19")
                
                self.surveyArray.append(surveyItem5Details)
                
                self.tblSurveyResults.reloadData()
                
                      }
        
        
        
        
        
        super.viewDidLoad()
        
        self.tblSurveyResults.dataSource = self
        self.tblSurveyResults.delegate = self
        
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveyArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "surveyquestion") as! CustomTableViewCell
        

        cell.lblSurveyQuestionItem.text = surveyArray[indexPath.row].SurveyTitle
        
        cell.lblSurveyQuestionResult.text = "Unsafe Percentage: " + String(surveyArray[indexPath.row].SurveyResult!) + "  | Hint: (Active/Total)"

        cell.backgroundColor = indexPath.row % 2 == 0 ? .black : .darkGray
        if indexPath.row == 4 {
            cell.backgroundColor = .brown
            cell.lblSurveyQuestionResult.textColor = .white
            cell.lblSurveyQuestionResult.text =  String(surveyArray[indexPath.row].SurveyResult!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
                return 100
    }

      override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
      }
}





