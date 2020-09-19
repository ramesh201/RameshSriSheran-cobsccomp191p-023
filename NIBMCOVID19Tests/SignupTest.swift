//
//  SignupTest.swift
//  NIBMCOVID19Tests
//
//  Created by Ramesh Sheran on 9/19/20.
//  Copyright © 2020 Ramesh Sheran. All rights reserved.
//

import XCTest
import FirebaseAuth
import UIKit
@testable import NIBMCOVID19

class SignupTest: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    
    //func testSignup() throws {
       func testHandleSignup() throws {
                  let signupVC = SignupViewController()
            let res = try XCTUnwrap(signupVC.performSignUp())
        
        //2(email: "cxvbhcxbg@dxghxd.ty",password: "zsdfgzsfg",fullName: "zdfsgdzfg",roleType: "1",address: "dxfgxdfg",userIndexCode: "dxfgxdfg")
        }
        
    //}
    
    func testVisibleSignin() throws {
           let signupVC = SignupViewController()
                     let res = try XCTUnwrap(signupVC.handleVisibleLogIn())
        
        
        
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    
}
