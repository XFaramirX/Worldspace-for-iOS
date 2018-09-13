import XCTest
import Attest

class IgnoreViolations: XCTestCase {

    /* Ignore a violation for a particular rule. */
    func testAndIgnoreSingleViolation() {

        Attest.that(storyBoardName: "ColorContrast").isAccessible({(result:Attest.Result) -> () in

            for ruleResult in result.ruleResults {
                switch (ruleResult.rule.ruleId) {
                    
                    case .ColorContrast:
                        //We're allowing one color contrast violation
                        XCTAssertEqual(4, ruleResult.violations.count, ruleResult.description)
                    
                    case .ImageViewName:
                        // We're allowing this rule to be inapplicable for this view controller
                        XCTAssertEqual(Impact.Inapplicable.toString(), ruleResult.impact.toString(), ruleResult.description)
                    
                    case .CustomRule:
                        // We're allowing this rule to be inapplicable for this view controller
                        XCTAssertEqual(Impact.Inapplicable.toString(), ruleResult.impact.toString(), ruleResult.description)
                
                    default:
                        //Everything else must pass.
                        XCTAssertEqual(Impact.Pass.toString(), ruleResult.impact.toString(), ruleResult.description)
                }
            }
        })
    }
}
