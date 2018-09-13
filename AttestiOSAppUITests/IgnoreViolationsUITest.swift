//
//  IgnoreViolationsUITest.swift
//  AttestiOSAppUITests
//
//  Created by Jennifer Dailey on 1/24/18.
//  Copyright © 2018 Deque Systems Inc. All rights reserved.
//

import XCTest
import Attest

class IgnoreViolationsUITest: XCTestCase {
    
    // Accessibility Identifier of Color Contrast Demo
    let COLOR_CONTRAST = "Color Contrast"
        
    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        XCUIApplication().launch()
        XCUIApplication().tables.cells.matching(identifier: COLOR_CONTRAST).firstMatch.tap() // Open Label Association Demo
    }
    
    /* Ignore a violation for a particular rule. */
    func testUIAndIgnoreSingleViolation() {
        
        Attest.that(portNumber: HTTP_PORT_NUMBER).isAccessible({(result:Attest.Result) -> () in
            
            print(result.description)
            
            for ruleResult in result.ruleResults {
                switch ruleResult.rule.ruleId {
                    case .ColorContrast:
                        //We're allowing one accessibility hint violation
                        XCTAssertEqual(4, ruleResult.violations.count, ruleResult.description)
                    default:
                        // Everything else must pass, be incomplete, or inapplicable
                        XCTAssert(Impact.Pass.toString() == ruleResult.impact.toString() ||
                            Impact.Inapplicable.toString() == ruleResult.impact.toString())
                }
            }
        })
    }
}
