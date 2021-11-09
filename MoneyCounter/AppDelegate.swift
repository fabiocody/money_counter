//
//  AppDelegate.swift
//  MoneyCounter
//
//  Created by Fabio Codiglioni on 09/12/17.
//  Copyright © 2017 Fabio Codiglioni. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		NSApplication.shared.isAutomaticCustomizeTouchBarMenuItemEnabled = true
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}
	
	func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
		return true
	}


}

