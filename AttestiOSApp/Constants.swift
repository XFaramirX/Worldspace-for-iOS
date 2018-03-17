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

    case ConflictingTraits_ConflictingTraits
    case ColorContrast_Contrast
    case ColorContrast_ContrastAlphaBlend
    case ColorContrast_ContrastAlphaBlendText
    case ColorContrast_ContrastLargeText
    case DynamicType_DynamicTypeSystemFont
    // case InformativeControl_InformativeFocusableControls
    case InHighlight_ElementInFocusBox
    case SpeakableText_LabelActiveControls
    case AccessibilityHint_LabelAssociation
    case SpeakableText_LabelInformativeControls
    case NestedA11yElements_NestedElements
    case Overlap_OverlappingButton
    case Overlap_OverlappingLabel
    case TouchTargetSize_TouchTargetSize
    // case VoiceOverNavigation_VoiceOverNavigation

    public func makeViewController() -> UIViewController {
        return UIStoryboard(name: self.storyBoardName(), bundle: nil).instantiateViewController(withIdentifier: self.viewControllerName())
    }
    
    public func storyBoardName() -> String {
        return String("\(self)".components(separatedBy: "_")[0])
    }
    
    public func viewControllerName() -> String {
        return String("\(self)".components(separatedBy: "_")[1])
    }
    
    public static func count() -> Int {
        return names().count
    }
    
    public static func values() -> [Demos] {
        var results: [Demos] = []
        
        for index in 0 ... Int.max {
            if let pattern = Demos.init(rawValue: index) {
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

    public func applicableRule() -> RuleID {
        switch(self.storyBoardName()) {
        case "AccessibilityHint":
            return RuleID.AccessibilityHint
        case "ColorContrast":
            return RuleID.ColorContrast
        case "ConflictingTraits":
            return RuleID.ConflictingTraits
        case "DynamicType":
            return RuleID.DynamicType
        case "InHighlight":
            return RuleID.InHighlight
        case "NestedA11yElements":
            return RuleID.NestedA11yElements
        case "Overlap":
            return RuleID.Overlap
        case "SpeakableText":
            return RuleID.SpeakableText
        case "TouchTargetSize":
            return RuleID.TouchTargetSize
        default:
            print("No rule found matching \(self.storyBoardName)")
            return RuleID.CustomRule
        }
    }
}

extension UIColor {
    static func colorWithHexString(_ hex: String) -> UIColor {
        var hexString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        // String should be 6 or 8 characters
        if hexString.count < 6 { return UIColor.gray }

        if hexString.contains("X") { hexString = String(hexString[hexString.index(of: "X")!...]) }

        if hexString.count != 6 { return UIColor.gray }

        // Separate into r, g, and b substrings
        var start = hexString.startIndex
        var end = hexString.index(hexString.startIndex, offsetBy: 2)
        let rString = hexString[Range(start..<end)]

        start = end
        end = hexString.index(hexString.startIndex, offsetBy: 4)
        let gString = hexString[Range(start..<end)]

        start = end
        end = hexString.endIndex
        let bString = hexString[Range(start..<end)]

        // Scan values
        var r: UInt32 = 0
        var g: UInt32 = 0
        var b: UInt32 = 0
        (Scanner.localizedScanner(with: String(rString)) as! Scanner).scanHexInt32(&r)
        (Scanner.localizedScanner(with: String(gString)) as! Scanner).scanHexInt32(&g)
        (Scanner.localizedScanner(with: String(bString)) as! Scanner).scanHexInt32(&b)

        return UIColor.init(red: CGFloat(Double(r)/255.0), green: CGFloat(Double(g)/255.0), blue: CGFloat(Double(b)/255.0), alpha: 1)
    }
}

//! Constants for colors in this project.
let BROKEN_COLOR = UIColor.colorWithHexString("DC341A")
let FIXED_COLOR = UIColor.colorWithHexString("72BA32")
