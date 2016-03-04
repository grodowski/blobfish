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
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func action(sender: AnyObject) {
        let myImageObject = representedObject as! ImageObject
        let res = sendUrlToPasteBoard((myImageObject.url))
        
        label.hidden = false
        delay(1.123) {
            self.label.hidden = true
        }
        print(myImageObject.url) // TODO: needs moar work, delegate this somewhere else!
        print(res)
    }
    
    func sendUrlToPasteBoard(url: String) -> Bool {
        let pasteboard = NSPasteboard.generalPasteboard()
        pasteboard.declareTypes([NSPasteboardTypeString], owner: nil)
        return pasteboard.setString("![blobfish_meme](\(url))", forType: NSPasteboardTypeString)
    }
}
