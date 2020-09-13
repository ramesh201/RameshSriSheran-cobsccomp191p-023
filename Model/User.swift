//
//  User.swift
//  NIBMCOVID19
//
//  Created by Ramesh Sheran on 8/23/20.
//  Copyright © 2020 Ramesh Sheran. All rights reserved.
//

import CoreLocation

enum RoleType: Int {
    case nonAcademic
    case student
    case academic
}

struct User {
    let userFullName: String
    let userEmail: String
    var roleType: RoleType!
    var userLocation: CLLocation?
    let userId: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.userId = uid
        self.userFullName = dictionary["userFullName"] as? String ?? ""
        self.userEmail = dictionary["userEmail"] as? String ?? ""
        
        if let index = dictionary["roleType"] as? Int {
            self.roleType = RoleType(rawValue: index)
        }
    }
}

