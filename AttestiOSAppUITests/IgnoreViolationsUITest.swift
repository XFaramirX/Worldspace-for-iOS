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
    
    let LABEL_ASSOCIATION = "LabelAssociation 9 of 14"
        
    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        XCUIApplication().launch()
        XCUIApplication().tables.cells[LABEL_ASSOCIATION].tap() // Open Label Association Demo

    }
    
    /* Ignore a violation for a particular rule. */
    func testUIAndIgnoreSingleViolation() {
        
        Attest.that(portNumber: 48484).isAccessible({(result:Attest.Result) -> () in
            
            print(result.description)
            
            for ruleResult in result.ruleResults {
                switch (ruleResult.rule.ruleId) {
                case .AccessibilityHint:
                    //We're allowing one accessibility hint violation
                    XCTAssertEqual(1, ruleResult.violations.count, ruleResult.description)
                case .TouchTargetSize:
                    // We're allowing this rule to be seen as inapplicable to this view controller
                    XCTAssertEqual(Impact.Inapplicable.name(), ruleResult.impact.name(), ruleResult.description)
                case .CustomRule:
                    // We're allowing this rule to be seen as inapplicable to this view controller
                    XCTAssertEqual(Impact.Inapplicable.name(), ruleResult.impact.name(), ruleResult.description)
                default:
                    //Everything else must pass.
                    XCTAssertEqual(Impact.Pass.name(), ruleResult.impact.name(), ruleResult.description)
                }
            }
        })
    }
}
