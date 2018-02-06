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

    var window: UIWindow?

    func applicationDidBecomeActive(_ application: UIApplication) {
        //Start the attest server in debug mode to use the desktop client.
        Attest.startServer(48484)
        Attest.startHTTPServer(8080)
    }
}
