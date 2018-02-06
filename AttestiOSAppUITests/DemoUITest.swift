//
//  DemoUITest.swift
//  AttestiOSAppUITests
//
//  Created by Jennifer Dailey on 1/29/18.
//  Copyright © 2018 Deque Systems Inc. All rights reserved.
//

import XCTest
import Attest

class DemoUITest: XCTestCase {
    
    // Maps the accessibility identifier of a demo with the expected violation(s) to occur
    let NumberOfExpectedViolations: [String : [RuleID]] = [
        "ConflictingTraits"         : [ RuleID.ConflictingTraits ],
        "Contrast"                  : [ RuleID.ColorContrast ],
        "ContrastAlphaBlend"        : [ RuleID.ColorContrast ],
        "ContrastAlphaBlendText"    : [ RuleID.ColorContrast ],
        "ContrastLargeText"         : [ RuleID.ColorContrast ],
        "DynamicTypeSystemFont"     : [ RuleID.DynamicType ],
        "ElementInFocusBox"         : [ RuleID.InHighlight ],
        "LabelActiveControls"       : [ RuleID.SpeakableText ],
        "LabelAssociation"          : [ RuleID.AccessibilityHint ],
        "LabelInformativeControls"  : [ RuleID.SpeakableText ],
        "NestedElements"            : [ RuleID.DontIntersect, RuleID.NestedA11yElements ],
        "OverlappingButton"         : [ RuleID.DontIntersect ],
        "OverlappingLabel"          : [ RuleID.DontIntersect ],
        "TouchTargetSize"           : [ RuleID.TouchTargetSize ]
    ]
        
    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testUIAllDemos() {
        
        //Show all details
        Rule.Result.withDetails = true
        
        //Show all passing nodes
        Rule.Result.withPasses = true
        
        //Application
        let app = XCUIApplication()
        
        // Loop through each demo listed in NumberOfExpectedViolations Dictionary
        for (a11yIdentifier, ruleIDs) in NumberOfExpectedViolations {
            
            // Open a demo
            app.tables.cells.matching(identifier: a11yIdentifier).firstMatch.tap()
            
            //For each demo, assert that it has one violation per rule listed in the NumberOfExpectedViolation Dictionary
            Attest.that(portNumber: 8080).isAccessible({ result in
                
                for ruleResult in result.ruleResults {
                    
                    if ruleIDs.contains(ruleResult.rule.ruleId) {
                        XCTAssertEqual(1, ruleResult.violations.count, ruleResult.description)
                    } else {
                        XCTAssertEqual(0, ruleResult.violations.count, ruleResult.description)
                    }
                }
            })
            
            app.navigationBars.buttons.element(boundBy: 0).tap() // Go back to menu
        }
    }
}
