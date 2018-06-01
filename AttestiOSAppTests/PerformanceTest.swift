//
//  PerformanceTest.swift
//  AttestiOSAppTests
//
//  Created by Jennifer Dailey on 6/1/18.
//  Copyright © 2018 Deque Systems Inc. All rights reserved.
//

import XCTest
import Attest

class PerformanceTest: XCTestCase {

    func testPerformance() {
        let storyboard = UIStoryboard(name: "ExtraTestCases", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PerformanceTest")
    
        self.measure {
            Attest.that(viewController: viewController).isAccessible({ result in
                let _ = result.description
            })
        }
    }
}
