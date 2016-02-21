//
//  ViewController.swift
//  BlobfishCollectionView
//
//  Created by Jan Grodowski on 14/02/16.
//  Copyright © 2016 Jan Grodowski. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON

class ViewController: NSViewController, NSCollectionViewDataSource {

    @IBOutlet weak var collectionView: NSCollectionView!
    
    var images: NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.registerForDraggedTypes(["public.data"])
        collectionView.wantsLayer = true
        Alamofire.request(.GET, "http://localhost:8000/memes").responseJSON { response in
            guard response.result.isSuccess else {
                let alert = NSAlert.init()
                alert.messageText = "Mothership Failure"
                alert.informativeText = response.result.error!.localizedDescription
                alert.runModal()
                return
            }
            let json = JSON(data: response.data!)
            for (_, image):(String, JSON) in json {
                let newImage = ImageObject(url: image["url"].string!)
                self.images.addObject(newImage)
            }
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
        let itemView = collectionView.makeItemWithIdentifier("ClickableMemeItemView", forIndexPath: indexPath) as!ClickableMemeItemView
        itemView.representedObject = images[indexPath.item] as! ImageObject
        return itemView
    }
}

struct DragAndDropConstants {
    static let acceptTypes: [AnyClass] = [NSImage.self, NSURL.self]
}

extension ViewController: NSCollectionViewDelegate {
    func collectionView(collectionView: NSCollectionView, validateDrop draggingInfo: NSDraggingInfo, proposedIndexPath proposedDropIndexPath: AutoreleasingUnsafeMutablePointer<NSIndexPath?>, dropOperation proposedDropOperation: UnsafeMutablePointer<NSCollectionViewDropOperation>) -> NSDragOperation {
        return NSDragOperation.Copy
    }
    
    func collectionView(collectionView: NSCollectionView, acceptDrop draggingInfo: NSDraggingInfo, indexPath: NSIndexPath, dropOperation: NSCollectionViewDropOperation) -> Bool {
        let receivedPasteboard = draggingInfo.draggingPasteboard()
        if let objects = receivedPasteboard.readObjectsForClasses(DragAndDropConstants.acceptTypes, options: [:]) {
            for item: AnyObject in objects {
                addImageFromPasteboard(item)
            }
        }
        return true
    }
    
    // TODO: refactor to a service object - image upload is still missing on our backend
    func addImageFromPasteboard(pasteboardObject: AnyObject) {
        var newImage: NSImage?
        switch pasteboardObject {
        case let url as NSURL:
            print("url", url) // a file has been dropped
            if let imageCandidate = NSImage.init(contentsOfURL: url) { // yes - it's an image
                newImage = imageCandidate
            }
        case let imageCandidate as NSImage:
            print("image", imageCandidate)
            newImage = imageCandidate
        default:
            break
        }
        guard newImage != nil else {
            print("unknown type of pasteboard item: ", pasteboardObject)
            return
        }
        self.images.addObject(ImageObject(url: "http://onet.pl", image: newImage!)) // TODO: missing upload :(
        self.collectionView.reloadData()
    }
}
