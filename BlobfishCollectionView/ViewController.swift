//
//  ViewController.swift
//  BlobfishCollectionView
//
//  Created by Jan Grodowski on 14/02/16.
//  Copyright © 2016 Jan Grodowski. All rights reserved.
//

import Cocoa
import Alamofire

class ViewController: NSViewController, NSCollectionViewDataSource {

    @IBOutlet weak var collectionView: NSCollectionView!
    
    var mothership = Mothership.sharedInstance
    
    override func awakeFromNib() {
        // Allow CollectionView items to resize dynamically
        collectionView.minItemSize = NSMakeSize(225, 225);
        collectionView.maxItemSize = NSMakeSize(0, 0);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.registerForDraggedTypes(["public.data"])
        collectionView.wantsLayer = true
        fetchData()
    }
    
    func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return mothership.countItems()
    }
    
    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
        let itemView = collectionView.makeItemWithIdentifier("ClickableMemeItemView", forIndexPath: indexPath) as!ClickableMemeItemView
        itemView.representedObject = mothership.lolcontent[indexPath.item] as! ImageObject
        return itemView
    }
    
    func fetchData() {
        mothership.reset({
            (response: Alamofire.Response<AnyObject, NSError>) -> Void in
            self.collectionView.reloadData()
            print("fetchData() success")
        }, failure: {
            (response: Alamofire.Response<AnyObject, NSError>) -> Void in
            showFailureModal("Mothership Failure", description: response.result.error!.localizedDescription)
        })
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
            if let imageCandidate = NSImage.init(contentsOfURL: url) { // yes - it's an image
                newImage = imageCandidate
            }
        case let imageCandidate as NSImage:
            newImage = imageCandidate
        default:
            break
        }
        guard newImage != nil else {
            print("unknown type of pasteboard item: ", pasteboardObject)
            return
        }
        mothership.add(newImage!, success: {
            _response in
            self.collectionView.reloadData()
            print("upload complete 🏆🙉")
        }, failure: {
            _ in
            print("🔥")
        })
    }
}
