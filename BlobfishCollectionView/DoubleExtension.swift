//
//  DoubleExtension.swift
//  Happy Blobfish
//
//  Created by Lukasz on 21/03/16.
//  Copyright © 2016 Jan Grodowski. All rights reserved.
//

import Foundation

extension Double {
    func delay(closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(self * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}