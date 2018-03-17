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
    static let WEBSOCKET_PORT_NUMBER: UInt = 48484

    var window: UIWindow?

    func applicationDidBecomeActive(_ application: UIApplication) {
        //Start the attest server in debug mode to use the desktop client.
        Attest.startHTTPServer(AppDelegate.HTTP_PORT_NUMBER)
        Attest.startServer(AppDelegate.WEBSOCKET_PORT_NUMBER)
    }
}
