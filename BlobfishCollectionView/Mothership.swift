//
//  Mothership.swift
//  BlobfishCollectionView
//
//  Created by Jan Grodowski on 04/03/16.
//  Copyright © 2016 Jan Grodowski. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Mothership {
    
    #if DEBUG
    static let host: String = "http://localhost:8000"
    #else
    static let host: String = "http://blobfish-web.blobfish.0fc9e4e8.svc.dockerapp.io"
    #endif
    static let indexUrl: String = "\(host)/memes"

    static let sharedInstance = Mothership()
    var lolcontent: NSMutableArray = NSMutableArray()
    
    // TODO: missing validation
    // TODO: missing upload
    func add(newContent: ImageObject) {
        lolcontent.addObject(newContent)
    }
    
    func fetch(success: (Alamofire.Response<AnyObject, NSError>) -> (), failure: (Alamofire.Response<AnyObject, NSError>) -> ()) {
        Alamofire.request(.GET, Mothership.indexUrl).responseJSON { response in
            guard response.result.isSuccess else {
                failure(response)
                return
            }
            let json = JSON(data: response.data!)
            for (_, image):(String, JSON) in json {
                let newImage = ImageObject(url: "\(Mothership.host)/\(image["url"].string!)")
                self.lolcontent.addObject(newImage)
            }
            success(response)
        }
    }
    
    // TODO: is there a shorter way? delegates?
    func reset(success: (Alamofire.Response<AnyObject, NSError>) -> (), failure: (Alamofire.Response<AnyObject, NSError>) -> ()) {
        lolcontent.removeAllObjects()
        fetch(success, failure: failure)
    }
    
    func countItems() -> Int {
        return lolcontent.count
    }
}