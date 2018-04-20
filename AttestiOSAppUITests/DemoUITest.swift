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
        "ElementInFocusBox"         : UIDevice.current.userInterfaceIdiom == .pad ? [ RuleID.InHighlight, RuleID.Overlap ] : [ RuleID.InHighlight ],
        "LabelActiveControls"       : [ RuleID.SpeakableText ],
        "LabelAssociation"          : [ RuleID.AccessibilityHint ],
        "LabelInformativeControls"  : [ RuleID.SpeakableText ],
        "NestedElements"            : [ RuleID.Overlap, RuleID.NestedA11yElements ],
        "OverlappingButton"         : [ RuleID.Overlap ],
        "OverlappingLabel"          : [ RuleID.Overlap ],
        "TouchTargetSize"           : [ RuleID.TouchTargetSize ]
    ]
        
    override func setUp() {
        super.setUp()

        XCUIApplication().launch()
    }
    
    // Highlights a violation for one second
    func highlightViolation(_ violationName: String) {
                
        if let url = NSURL(string: "http://localhost:\(HTTP_PORT_NUMBER)/api/highlight/\(violationName)") {
            let group = DispatchGroup()
            group.enter()
            
            let task = URLSession.shared.dataTask(with: URLRequest(url: url as URL), completionHandler: {data, response, error in
                
                // Environment variable HIGHLIGHT_TIME is set to 1 (second) in project settings
                if let sleepTime = UInt32(ProcessInfo.processInfo.environment["HIGHLIGHT_TIME"]!) {
                    sleep(sleepTime)
                }
                group.leave()
            })
            task.resume()
            group.wait()

            let urlRequest = URLRequest(url: NSURL(string: "http://localhost:\(HTTP_PORT_NUMBER)/api/remove_highlight")! as URL)
            URLSession.shared.dataTask(with: urlRequest).resume()
        }
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
            
            sleep(1) // Have to wait one second to avoid race conditions in some simulators
            
            //For each demo, assert that it has one violation per rule listed in the NumberOfExpectedViolation Dictionary
            //Port number is defined in SimpleUITest and in AppDelegate.
            Attest.that(portNumber: HTTP_PORT_NUMBER).isAccessible({ result in
                
                for ruleResult in result.ruleResults {
                    
                    // Highlight each violation for one second before asserting the number of violations
                    for violation in ruleResult.violations {
                        highlightViolation(violation.target)
                    }
                    
                    if ruleIDs.contains(ruleResult.rule.ruleId) {
                        XCTAssertEqual(1, ruleResult.violations.count, ruleResult.description)
                    } else {
                        XCTAssertEqual(0, ruleResult.violations.count, ruleResult.description)
                    }
                }
            })
            
            // Go back to menu if using an iPhone (not an iPad)
            if UIDevice.current.userInterfaceIdiom == .phone {
                app.navigationBars.buttons.element(boundBy: 0).tap()
            }
        }
    }
}
