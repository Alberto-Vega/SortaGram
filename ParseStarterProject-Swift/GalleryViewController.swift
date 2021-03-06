//
//  GalleryViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Alberto Vega Gonzalez on 11/4/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse


class GalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    var images = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //Call the GalleryViewController class
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
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
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let width = Floa
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
//        let screenWidth = screenSize.width
//        let screenHeight = screenSize.height
        
        let size = (screenSize.width / 3) - 7

        return CGSizeMake(size, size)
        
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
