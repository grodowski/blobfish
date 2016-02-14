//
//  Controller.swift
//  BlobfishCollectionView
//
//  Created by Jan Grodowski on 14/02/16.
//  Copyright © 2016 Jan Grodowski. All rights reserved.
//

import Cocoa
import Alamofire

class Controller: NSObject {
    
    @IBOutlet weak var arrayController: NSArrayController!
    
    var images: NSMutableArray = NSMutableArray()
    
    override func awakeFromNib() {
        // TODO: play with Alamofire
        print(Alamofire.request(.GET, "https://httpbin.org/get"))
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
