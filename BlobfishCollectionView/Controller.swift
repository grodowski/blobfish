//
//  Controller.swift
//  BlobfishCollectionView
//
//  Created by Jan Grodowski on 14/02/16.
//  Copyright © 2016 Jan Grodowski. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON

class Controller: NSObject {
    
    @IBOutlet weak var arrayController: NSArrayController!
    
    var images: NSMutableArray = NSMutableArray()
    
    override func awakeFromNib() {
        Alamofire.request(.GET, "http://localhost:8000/memes").responseJSON { response in
            guard response.result.isSuccess else {
                print("request failed")
                return
            }
            let json = JSON(data: response.data!)
            for (_, image):(String, JSON) in json {
                let newImage = ImageObject(url: image["url"].string!)
                self.arrayController.addObject(newImage)
            }
        }
    }
}
