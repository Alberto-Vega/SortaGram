//
//  GalleryViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Alberto Vega Gonzalez on 11/4/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

protocol GalleryVCDelegate {
    
    func galleryViewControllerDidFinish(image: UIImage)
}

class GalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    var images = [UIImage]()
    var statuses = [Status]() {
        didSet {
            self.galleryCollectionView.reloadData()
        }
    }
    
    var delegate:GalleryVCDelegate?
    var cellSize: CGFloat = 1.0 {
        didSet {
            galleryCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.galleryCollectionView.collectionViewLayout = CustomFlowLayout(columns: cellSize, separatorWidht: 8)
        
        // Tap Gesture Recognizer
        galleryCollectionView.userInteractionEnabled = true
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: "pinchView:")
        galleryCollectionView.gestureRecognizers = [pinchGesture]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("The statuses in view will appear :\(statuses)")
        fetchStatusObjectsFromParse()
        self.galleryCollectionView.reloadData()
    }
    
    func fetchStatusObjectsFromParse() {
        API.fetchStatusObjects { (objects) -> () in
            if let objects = objects {
                print("These are the objects fectched by the API: \(objects.count)")
                PFObjectParser.convertObjectsToStatuses(objects, callback: self.returnArrayOfStatus)
            }
        }
    }
    
    func returnArrayOfStatus(returnArray:[Status]?) -> ([Status]) {
        print("Callback returnArray count \(returnArray!.count)")
        if let returnArray = returnArray {
            statuses.appendContentsOf(returnArray)
            print("The array statuses in collection view has: \(statuses.count)")
        }
        return statuses
    }
    
    // MARK: PinchGestureRecognizer setup
    
    func pinchView(recognizer: UIPinchGestureRecognizer) {
        self.cellSize = self.cellSize / recognizer.scale
        recognizer.scale = 1.0
        print(recognizer.scale)
    }
    
    // MARK: - UICollectionView
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("number of items in section \(self.statuses.count)")
        return self.statuses.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CustomCollectionViewCell.identifier(), forIndexPath: indexPath) as! CustomCollectionViewCell
        let image = self.statuses[indexPath.row].image
        cell.imageView.image = image
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if let delegate = self.delegate {
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CustomCollectionViewCell
            if let image = cell.imageView.image {
                
                delegate.galleryViewControllerDidFinish(image)
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(100.0 * self.cellSize, 100.0 * self.cellSize)
    }
}
