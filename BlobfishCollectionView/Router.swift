//
//  Router.swift
//  Happy Blobfish
//
//  Created by Lukasz on 21/03/16.
//  Copyright © 2016 Jan Grodowski. All rights reserved.
//

import Alamofire

enum HappyBlobfishApi: URLRequestConvertible {
    #if DEBUG
    static let host: String = "http://localhost:9777"
    #else
    static let host: String = "http://www.mymagicserver.com:9777"
    #endif
    
    case Index
    case Upload
    
    var method: Alamofire.Method {
        switch self {
        case .Index:
            return .GET
        case .Upload:
            return .POST
        }
    }
    
    var path: String {
        switch self {
        case .Index:
            return "/memes"
        case .Upload:
            return "/uploads"
        }
    }
    
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: HappyBlobfishApi.host)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        return mutableURLRequest
    }
}
