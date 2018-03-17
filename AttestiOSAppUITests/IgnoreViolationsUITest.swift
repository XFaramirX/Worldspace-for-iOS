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
    
    // Accessibility Identifier of LabelAssociation Demo
    let LABEL_ASSOCIATION = "LabelAssociation"
        
    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        XCUIApplication().launch()
        XCUIApplication().tables.cells.matching(identifier: LABEL_ASSOCIATION).firstMatch.tap() // Open Label Association Demo
    }
    
    /* Ignore a violation for a particular rule. */
    func testUIAndIgnoreSingleViolation() {
        
        Attest.that(portNumber: HTTP_PORT_NUMBER).isAccessible({(result:Attest.Result) -> () in
            
            print(result.description)
            
            for ruleResult in result.ruleResults {
                switch (ruleResult.rule.ruleId) {
                case .AccessibilityHint:
                    //We're allowing one accessibility hint violation
                    XCTAssertEqual(1, ruleResult.violations.count, ruleResult.description)
                default:
                    // Everything else must pass, be incomplete, or inapplicable
                    XCTAssert(Impact.Pass.name() == ruleResult.impact.name() ||
                        Impact.Inapplicable.name() == ruleResult.impact.name() ||
                        Impact.Incomplete.name() == ruleResult.impact.name(), ruleResult.description)
                }
            }
        })
    }
}
