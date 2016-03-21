//
//  ImageObject.swift
//  BlobfishCollectionView
//
//  Created by Jan Grodowski on 14/02/16.
//  Copyright © 2016 Jan Grodowski. All rights reserved.
//

import Cocoa
import Alamofire
import AlamofireImage

typealias ImageResponse = Alamofire.Response<Image, NSError>
typealias ImageResponseClosure = ((ImageResponse) -> ())

class ImageObject: NSObject {
    
    var image: NSImage?
    var isImageDownloaded = false
    var url: String
    
    init(url: String) {
        self.url = url
    }
    
    //MARK: - lazy loading blobfish
    func downloadImage(success: (ImageResponse) -> (), failure: ImageResponseClosure?) {
        Alamofire.request(.GET, url).responseImage { imageResponse in
            guard imageResponse.result.isSuccess else {
                print(imageResponse.debugDescription)
                if let failure = failure {
                    failure(imageResponse)
                }
                return
            }
            self.image = imageResponse.result.value
            self.isImageDownloaded = true
            success(imageResponse)
        }
    }
}
