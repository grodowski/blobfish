//
//  CoverButtonCell.swift
//  BlobfishCollectionView
//
//  Created by Jan Grodowski on 04/03/16.
//  Copyright © 2016 Jan Grodowski. All rights reserved.
//

import Cocoa

class CoverButtonCell: NSButtonCell {
    override func drawImage(image: NSImage, withFrame frame: NSRect, inView controlView: NSView) {
//        Fallback to NSButtonCell
//        super.drawImage(image, withFrame: frame, inView: controlView)
        let imageWidth: CGFloat = image.size.width
        let imageHeight: CGFloat = image.size.height
        let viewWidth: CGFloat = frame.width
        let viewHeight: CGFloat = frame.height
        
        let imageAspectRatio: CGFloat = imageHeight / imageWidth
        let viewAspectRatio: CGFloat = viewHeight / viewWidth
        
        var newImageSize: NSSize = image.size
        
        if (imageAspectRatio < viewAspectRatio) {
            // Image is more horizontal than the view. Image left and right borders need to be cropped.
            newImageSize.width = imageHeight / viewAspectRatio;
        }
        else {
            // Image is more vertical than the view. Image top and bottom borders need to be cropped.
            newImageSize.height = imageWidth * viewAspectRatio;
        }
    
        NSGraphicsContext.currentContext()?.imageInterpolation = NSImageInterpolation.High
        
        let sourceFrame: NSRect = NSMakeRect(imageWidth / 2.0 - newImageSize.width / 2.0,
            imageHeight / 2.0 - newImageSize.height / 2.0,
            newImageSize.width,
            newImageSize.height)
        
        image.drawInRect(frame, fromRect: sourceFrame, operation: NSCompositingOperation.CompositeCopy, fraction: 1.0, respectFlipped: true, hints: nil)
    }
}
