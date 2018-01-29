//
//  ObjectiveCTests.m
//  AttestiOSAppTests
//
//  Created by Jennifer Dailey on 12/20/17.
//  Copyright © 2017 Deque Systems Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Attest/Attest-Swift.h>

@interface ObjCTests : XCTestCase
@end

@implementation ObjCTests

- (void) testSimple {
    [[Attest thatWithStoryBoardName: @"Main" viewControllerID: NULL bundle: NULL]
     isAccessible: ^(Result* result) {
        NSLog(@"%s\n %@", "Attest Results", result.description);
     }];
}

- (void) testAndIgnoreSingleViolation {
    [[Attest thatWithStoryBoardName:@"AccessibilityHint" viewControllerID:@"LabelAssociation" bundle:NULL]
     isAccessible: ^(Result* result) {
         for (RuleResult* ruleResult in result.ruleResults) {
             switch (ruleResult.rule.ruleId) {
                 case RuleIDAccessibilityHint:
                     XCTAssertEqual(1, ruleResult.violations.count, @"%@", ruleResult.description);
                     break;
                 default:
                     XCTAssertEqual(ImpactPass, ruleResult.impact, @"%@", ruleResult.description);
                     break;
             }
         }
     }];
}

@end
