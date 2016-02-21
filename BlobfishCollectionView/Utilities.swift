//
//  Utilities.swift
//  BlobfishCollectionView
//
//  Created by Jan Grodowski on 21/02/16.
//  Copyright © 2016 Jan Grodowski. All rights reserved.
//

import Foundation

func delay(delay: Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}
