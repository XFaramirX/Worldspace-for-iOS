//
//  AppDelegate.swift
//  TestApp
//
//  Created by Chris McMeeking on 4/26/17.
//  Copyright © 2017 Deque Systems Inc. All rights reserved.
//

import UIKit
import Attest

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static let HTTP_PORT_NUMBER = 48485

    var window: UIWindow?

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        // Start the Attest HTTP Server in debug mode to use your browser as the desktop client.
        Attest.startHTTPServer(AppDelegate.HTTP_PORT_NUMBER)
        
        // The audit generator prints out a String into the log for every element that is scanned for a11y violations in the following format:
        // IMPACT - RuleId(A11yIdentifier) Success Criteria: RuleDescription\n\t<view.description>
        //
        // NOTE: This call is only available in the full version of the Attest Framework.
        //
        // Optional Parameters:
        //  - inSeconds: Change the number of seconds between each audit (default is 1 second).
        //  - withAuditFormat: the format of each entry in the audit. Use this to change the format above to suit your needs.
        //
        // The call below is equal to Attest.startAuditGenerator()
        Attest.startAuditGenerator(inSeconds: 1, withAuditFormat: { (entry: Entry) -> String in
            return "\(entry.impact.toString().uppercased()) - \(entry.ruleId.toString())(\(entry.a11yIdentifier)) \(entry.tags): \(entry.ruleDescription)\n\t\(entry.view.description)"
        })
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
        // Stopping the Audit Generator will allow you to retrieve the complete audit in JSON format.
        if let jsonString = Attest.stopAuditGenerator()?.description {
            print(jsonString)
        } else {
            print ("Audit was not able to print.")
        }
    }
}
