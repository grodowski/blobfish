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
    
    @IBOutlet weak var collectionViewController: ViewController!
    
    @IBAction func refreshClicked(sender: AnyObject) {
        let collectionViewController = NSApplication.sharedApplication().mainWindow?.contentViewController as? ViewController
        guard collectionViewController != nil else {
            print("🐟")
            return
        }
        collectionViewController!.fetchData()
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

