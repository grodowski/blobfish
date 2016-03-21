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

typealias Response = Alamofire.Response<AnyObject, NSError>

class Mothership {
    static let sharedInstance = Mothership()
    private init() {}
    var lolcontent = [ImageObject]()
    
    func add(image: NSImage, success: (Response) -> (), failure: (Response) -> ()) {
        Alamofire.upload(HappyBlobfishApi.Upload, data: image.pngFromBitmap())
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
            self.lolcontent.append(ImageObject(url: imageData["url"].string!))
            success(response)
        }
    }
    
    func fetch(success: (Response) -> (), failure: (Response) -> ()) {
        Alamofire.request(HappyBlobfishApi.Index).responseJSON { response in
            guard response.result.isSuccess else {
                failure(response)
                return
            }
            let json = JSON(data: response.data!)
            for (_, image) in json {
                self.lolcontent.append(ImageObject(url: "\(HappyBlobfishApi.host)/\(image["url"].string!)"))
            }
            success(response)
        }
    }
    
    func reset(success: (Response) -> (), failure: (Response) -> ()) {
        lolcontent.removeAll()
        fetch(success, failure: failure)
    }
    
    func countItems() -> Int {
        return lolcontent.count
    }
}