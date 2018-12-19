//
//  rollCallTests.swift
//  rollCallTests
//
//  Created by Kevin Vallejo on 8/29/18.
//  Copyright © 2018 Vallejo. All rights reserved.
//

import XCTest
@testable import Pods_rollCall
@testable import rollCall



var addStudent_Test: addStudent_ViewController!
var student = ["name": String(), "Age": String()]
class rollCallTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    addStudent_Test = addStudent_ViewController()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.'
          }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
