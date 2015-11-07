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
    
    var delegate:GalleryVCDelegate?
    var cellSize: CGFloat = 1.0 {
        didSet {
            galleryCollectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.galleryCollectionView.collectionViewLayout = CustomFlowLayout(columns: cellSize, separatorWidht: 8)
//        let delegate = GalleryVCDelegate.dissmissGalleryViewController(self)
        //Call the GalleryViewController class
        
        // Tap Gesture Recognizer
        galleryCollectionView.userInteractionEnabled = true
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: "pinchView:")
        galleryCollectionView.gestureRecognizers = [pinchGesture]

    }
    
    func pinchView(recognizer: UIPinchGestureRecognizer) {
        self.cellSize = self.cellSize / recognizer.scale
        recognizer.scale = 1.0
        print(recognizer.scale)
//        galleryCollectionView.reloadData()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let query = PFQuery(className:"Status")
        query.whereKeyExists("image")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        print("Succeeded downloading \(object.objectId)")
                        
                        let thumbNail = object["image"] as! PFFile
                        
                        thumbNail.getDataInBackgroundWithBlock({(imageData: NSData?, error: NSError?) -> Void in
                            if (error == nil) {
                                if let image = UIImage(data:imageData!) {
                                //image object implementation
                                self.images.append(image)
                                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                                    self.galleryCollectionView.reloadData()
                                })
                                print(image)
                                }
                            }
                            
                        })//getDataInBackgroundWithBlock - end
                    }
                    print("We have \(self.images.count) images")
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    // MARK: - UICollectionView
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return self.images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CustomCollectionViewCell.identifier(), forIndexPath: indexPath) as! CustomCollectionViewCell
        
        let image = self.images[indexPath.row]
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
