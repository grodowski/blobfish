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
    var url: String
    
    init(url: String) {
        self.url = url
        let data = NSData(contentsOfURL: NSURL.init(string: url)!)
        self.image = NSImage(data: data!)!
        print(self.image.valid)
    }
    
    init(url: String, image: NSImage) {
        self.url = url
        self.image = image
    }
}
