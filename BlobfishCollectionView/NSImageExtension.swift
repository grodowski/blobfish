//
//  NSImageExtension.swift
//  Happy Blobfish
//
//  Created by Lukasz on 21/03/16.
//  Copyright © 2016 Jan Grodowski. All rights reserved.
//

import Cocoa

extension NSImage {
    func pngFromBitmap() -> NSData {
        let imageRep = NSBitmapImageRep.init(CGImage: CGImageForProposedRect(nil, context: nil, hints: nil)!)
        return imageRep.representationUsingType(.NSPNGFileType, properties: [NSImageInterlaced: false])!
    }
}