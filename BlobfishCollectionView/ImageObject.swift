//
//  ImageObject.swift
//  BlobfishCollectionView
//
//  Created by Jan Grodowski on 14/02/16.
//  Copyright © 2016 Jan Grodowski. All rights reserved.
//

import Cocoa

class ImageObject: NSObject {
    
    var image: NSImage
    
    init(imageKey: String) {
        self.image = NSImage(named: imageKey)!
    }

}
