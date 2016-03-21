//
//  ClickableMemeItemView.swift
//  BlobfishCollectionView
//
//  Created by Jan Grodowski on 20/02/16.
//  Copyright © 2016 Jan Grodowski. All rights reserved.
//

import Cocoa

class ClickableMemeItemView: NSCollectionViewItem {

    @IBOutlet weak var label: NSTextField!
    @IBOutlet weak var imageButton: NSButton!
    
    static let ValueCopy: String = "markdown 📋"
    static let ValueCopyOk: String = "done 🎉🙉"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.stringValue = ClickableMemeItemView.ValueCopy
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
        label.stringValue = ClickableMemeItemView.ValueCopyOk
        1.123.delay {
            self.label.hidden = true
            self.label.stringValue = ClickableMemeItemView.ValueCopy
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
