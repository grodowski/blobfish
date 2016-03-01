//
//  Utilities.swift
//  BlobfishCollectionView
//
//  Created by Jan Grodowski on 21/02/16.
//  Copyright © 2016 Jan Grodowski. All rights reserved.
//

import Foundation
import Cocoa

func delay(delay: Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

func showFailureModal(title: String, description: String) {
    let alert = NSAlert.init()
    alert.messageText = title
    alert.informativeText = description
    alert.runModal()
}