//
//  LoginUnitTest.swift
//  NIBMCOVID19Tests
//
//  Created by Ramesh Sheran on 9/14/20.
//  Copyright © 2020 Ramesh Sheran. All rights reserved.
//

@testable import NIBMCOVID19
import XCTest
 
class LoginUnitTest: XCTestCase {

    var login: String! = "Hello"
    
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        if login == "Hello"{
            print("Cool")
        }
        else{
            print("Not Cool")
        }
        
    }

    override func tearDown() {
        // Put t
        super.tearDown()
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
