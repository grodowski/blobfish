//
//  ClickableMemeItemView.swift
//  BlobfishCollectionView
//
//  Created by Jan Grodowski on 20/02/16.
//  Copyright © 2016 Jan Grodowski. All rights reserved.
//

import Cocoa

enum ActionValueCopy: String {
    case Markdown = "markdown 📋"
    case Done = "done 🎉🙉"
}

class ClickableMemeItemView: NSCollectionViewItem {

    @IBOutlet weak var label: NSTextField!
    @IBOutlet weak var imageButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.stringValue = ActionValueCopy.Markdown.rawValue
        let trackingArea = NSTrackingArea(
            rect: imageButton.bounds,
            options: [NSTrackingAreaOptions.MouseEnteredAndExited, NSTrackingAreaOptions.ActiveAlways],
            owner: self,
            userInfo: nil)
        imageButton.addTrackingArea(trackingArea)
    }
    
    @IBAction func action(sender: AnyObject) {
        let myImageObject = representedObject as! ImageObject
        let res = sendUrlToPasteBoard((myImageObject.url))
        

        label.hidden = false
        label.stringValue = ActionValueCopy.Done.rawValue
        1.123.delay {
            self.label.hidden = true
            self.label.stringValue = ActionValueCopy.Markdown.rawValue
        }
        print(myImageObject.url) // TODO: needs moar work, delegate this somewhere else!
        print(res)
    }
    
    func sendUrlToPasteBoard(url: String) -> Bool {
        let pasteboard = NSPasteboard.generalPasteboard()
        pasteboard.declareTypes([NSPasteboardTypeString], owner: nil)
        return pasteboard.setString("![blobfish_meme](\(url))", forType: NSPasteboardTypeString)
    }
    
    override func mouseEntered(theEvent: NSEvent) {
        label.hidden = false
    }
    
    override func mouseExited(theEvent: NSEvent) {
        label.hidden = true
    }
}
