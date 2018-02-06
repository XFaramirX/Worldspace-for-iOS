//
//  AttestiOSAppUITests.swift
//  AttestiOSAppUITests
//
//  Created by Chris McMeeking on 10/23/17.
//  Copyright © 2017 Deque Systems Inc. All rights reserved.
//

import XCTest
import Attest

class SimpleUITest: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }
    
    func testUISimple() {
        Attest.that(portNumber: 8080).isAccessible()
    }
}
