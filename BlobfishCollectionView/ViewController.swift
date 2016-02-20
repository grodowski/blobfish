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
        Alamofire.request(.GET, "http://localhost:8000/memes").responseJSON { response in
            guard response.result.isSuccess else {
                print("request failed")
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
