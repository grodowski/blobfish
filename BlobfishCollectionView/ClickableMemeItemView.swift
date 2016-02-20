//
//  ClickableMemeItemView.swift
//  BlobfishCollectionView
//
//  Created by Jan Grodowski on 20/02/16.
//  Copyright © 2016 Jan Grodowski. All rights reserved.
//

import Cocoa

class ClickableMemeItemView: NSCollectionViewItem {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func action(sender: AnyObject) {
        let myImageObject = representedObject as! ImageObject
        print(myImageObject.url) // TODO: needs moar work
    }
    
}
