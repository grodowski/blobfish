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
    static let host: String = "http://localhost:9777"
    #else
    static let host: String = "http://www.mymagicserver.com:9777"
    #endif
    static let indexUrl: String = "\(host)/memes"
    static let createUploadUrl: String = "\(host)/uploads"

    static let sharedInstance = Mothership()
    private init() {}
    var lolcontent = [ImageObject]()
    
    func add(image: NSImage, success: (Alamofire.Response<AnyObject, NSError>) -> (), failure: (Alamofire.Response<AnyObject, NSError>) -> ()) {
        Alamofire.upload(.POST, Mothership.createUploadUrl, data: pngFromBitmap(image))
        .progress { bytesWritten, totalBytesWritten, totalBytesExpectedToWrite in
//            print(totalBytesWritten)
            // TODO(janek): I'm leaving it here for documentation purposes :)
            // This closure is NOT called on the main queue for performance
            // reasons. To update your ui, dispatch to the main queue.
//            dispatch_async(dispatch_get_main_queue()) {
//                print("Total bytes written on main queue: \(totalBytesWritten)")
//            }
        }
        .responseJSON { response in
            guard response.result.isSuccess else {
                print("mothership failed to add image 🔥")
                print(response.debugDescription)
                failure(response)
                return
            }
            let imageData = JSON(data: response.data!)
            self.lolcontent.append(ImageObject(url: imageData["url"].string!, image: image))
            success(response)
        }
    }
    
    func fetch(success: (Alamofire.Response<AnyObject, NSError>) -> (), failure: (Alamofire.Response<AnyObject, NSError>) -> ()) {
        Alamofire.request(.GET, Mothership.indexUrl).responseJSON { response in
            guard response.result.isSuccess else {
                failure(response)
                return
            }
            let json = JSON(data: response.data!)
            for (_, image) in json {
                self.lolcontent.append(ImageObject(url: "\(Mothership.host)/\(image["url"].string!)"))
            }
            success(response)
        }
    }
    
    func reset(success: (Alamofire.Response<AnyObject, NSError>) -> (), failure: (Alamofire.Response<AnyObject, NSError>) -> ()) {
        lolcontent.removeAll()
        fetch(success, failure: failure)
    }
    
    func countItems() -> Int {
        return lolcontent.count
    }
}