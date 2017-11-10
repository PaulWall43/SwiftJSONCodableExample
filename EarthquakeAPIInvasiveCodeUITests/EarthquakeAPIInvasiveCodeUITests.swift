//
//  EarthquakeAPIInvasiveCodeUITests.swift
//  EarthquakeAPIInvasiveCodeUITests
//
//  Created by Paul Wallace on 10/20/17.
//  Copyright © 2017 Paul Wallace. All rights reserved.
//

import XCTest

class EarthquakeAPIInvasiveCodeUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        let app = XCUIApplication()
        app.tables.cells.containing(.staticText, identifier:"Oct 20, 2017 at 6:06:18 AM").staticTexts["Moderate earthquake - Tonga Region - October 20, 2017"].tap()
        app.otherElements["TONGA REGION, 10.0"].tap()
                
    }
    
}
