//
//  AppDelegate.swift
//  MasterDetail
//
//  Created by Hussain  on 24/2/16.
//  Copyright © 2016 Hussain . All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    var sharedInstance = MDMainWindowController(windowNibName : kMasterDetailMainWindow)


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        self.sharedInstance.showWindow(nil)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

