//
//  Controller.swift
//  BlobfishCollectionView
//
//  Created by Jan Grodowski on 14/02/16.
//  Copyright © 2016 Jan Grodowski. All rights reserved.
//

import Cocoa

class Controller: NSObject {
    
    @IBOutlet weak var arrayController: NSArrayController!
    
    var images: NSMutableArray = NSMutableArray()
    
    override func awakeFromNib() {
        for _ in 1...50 {
            let newImage = ImageObject(imageKey: "iwin")
            self.arrayController.addObject(newImage)
        }
        for _ in 1...50 {
            let newImage = ImageObject(imageKey: "omgsocool")
            self.arrayController.addObject(newImage)
        }
    }
}
