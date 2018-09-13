//
//  DUConstants.swift
//  AttestIOS
//
//  Created by Jennifer Dailey on 8/29/17.
//  Copyright © 2017 Deque Systems Inc. All rights reserved.
//

import UIKit
import Attest

public enum Demos: Int {

    case ColorContrast
    
    public static func count() -> Int {
        return names().count
    }
    
    public static func values() -> [Demos] {
        var results: [Demos] = []
        
        for index in 0 ... Int.max {
            if let pattern = Demos(rawValue: index) {
                results.append(pattern)
            } else {
                break
            }
        }
        
        return results
    }
    
    public static func names() -> [String] {
        var results: [String] = []
        
        for index in 0 ... Int.max {
            if let pattern = Demos.init(rawValue: index) {
                results.append("\(pattern)")
            } else {
                break
            }
        }
        
        return results
    }
    
    public static func applicableRule(_ storyboardName: String) -> RuleID {
        switch storyboardName {
            case "ColorContrast":
                return RuleID.ColorContrast
            default:
                return RuleID.CustomRule
        }
    }
    
    internal func applicableRule() -> RuleID {
        return Demos.applicableRule(self.storyBoardName())
    }
    
    internal func numberOfViolations() -> Int {
        switch self {
            case .ColorContrast: return 4
        }
    }

    public func makeViewController() -> UIViewController {
        return UIStoryboard(name: self.storyBoardName(), bundle: nil).instantiateInitialViewController()!
    }
    
    public func storyBoardName() -> String {
        return String("\(self)")
    }
}
