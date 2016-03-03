//
//  AppDelegate.swift
//  BlobfishCollectionView
//
//  Created by Jan Grodowski on 14/02/16.
//  Copyright © 2016 Jan Grodowski. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusItem: NSStatusItem?
    
    // Handle the Refresh menu button
    @IBAction func refreshClicked(sender: AnyObject) {
        let collectionViewController = NSApplication.sharedApplication().mainWindow?.contentViewController as? ViewController
        guard collectionViewController != nil else {
            print("🐟")
            return
        }
        collectionViewController!.fetchData()
    }
    
    override func awakeFromNib() {
        statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
        if let icon = statusItem {
            icon.title = "HB"
            icon.highlightMode = true
//            TODO(janek): missing menu icon
//            icon.image =
            icon.button?.target = self
            icon.button?.action = "iconClicked:"

        }
    }
    
    // Respond to Menu Icon click and show the main window if not visible
    func iconClicked(sender: AnyObject?) {
        NSApp.activateIgnoringOtherApps(true) // bring to front!
        for window in NSApplication.sharedApplication().windows {
            window.makeKeyAndOrderFront(self)
        }
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Did finish launching
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    // Allow to re-open when dock icon is clicked
    func applicationShouldHandleReopen(sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        guard !flag else { return true }
        for window in sender.windows{
                window.makeKeyAndOrderFront(self)
        }
        return true
    }
}

