/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, GalleryVCDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var filterTableView: UICollectionView!
    
    var filtersThumbnails = [UIImage]()
    var currentPhoto: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateData()
        // ...
        if let tabBarController = self.tabBarController, viewControllers = tabBarController.viewControllers {
            if let galleryViewController = viewControllers[1] as? GalleryViewController {
                galleryViewController.delegate = self
            }
        }
    }
    
    func galleryViewControllerDidFinish(image: UIImage) {
        
        // Set this View Controllers image to image
        self.imageView.image = image
        // Get tabBar controller.
        self.tabBarController?.selectedIndex = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func generateData() {
        for _ in 1...3 {
            let image = self.imageView.image
            if let image = image {
            self.filtersThumbnails.append(image)
            }
        }
        
        self.filterTableView.reloadData()
        
    }
    
    // MARK: UIAlert
    
    func presentActionSheet() {
        
        let alertController = UIAlertController(title: "", message: "Please choose your source.", preferredStyle: .ActionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.presentImagePickerFor(.Camera)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .Default) { (action) -> Void in
            self.presentImagePickerFor(.PhotoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func presentAlertView() {
        
        let alertController = UIAlertController(title: "", message: "Image successfully uploaded.", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: Filters
    
    func presentFilterAlert() {
        
        let alertController = UIAlertController(title: "Filters!", message: "Pick an awesome filter!!", preferredStyle: .ActionSheet)
        
        let vintageFilterAction = UIAlertAction(title: "Vintage", style: .Default) { (alert) -> Void in
            FilterService.applyVintageEffect(self.imageView.image!, completion: { (filteredImage, name) -> Void in
                if let filteredImage = filteredImage {
                    self.imageView.image = filteredImage
                }
            })
        }
        
        let BWFilterAction = UIAlertAction(title: "Black & White", style: .Default) { (alert) -> Void in
            
            FilterService.applyBWEfect(self.imageView.image!, completion: { (filteredImage, name) -> Void in
                
                if let filteredImage = filteredImage {
                    self.imageView.image = filteredImage
                }
            })
        }
        
        let chromeFilterAction = UIAlertAction(title: "Chrome", style: .Default) { (alert) -> Void in
            
            FilterService.applyChromeEffect(self.imageView.image!, completion: { (filteredImage, name) -> Void in
                
                if let filteredImage = filteredImage {
                    self.imageView.image = filteredImage
                }
            })
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alertController.addAction(vintageFilterAction)
        alertController.addAction(BWFilterAction)
        alertController.addAction(chromeFilterAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }


// MARK: Actions
    
    @IBAction func addImageButtonSelected(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.presentActionSheet()
        } else {
            self.presentImagePickerFor(.PhotoLibrary)
        }
    }
    
    @IBAction func filtersButtonPressed(sender: UIButton) {
        
        presentFilterAlert()
        print("presenteing alert")
    }
    
    @IBAction func uploadImageButtonPressed(sender: UIButton) {
        
        sender.enabled = false
        if let image = self.imageView.image {
            API.uploadImage(image) { (success) -> () in
                if success {
                    sender.enabled = true
                    self.presentAlertView()
                }
            }
        }
    }
    
      // MARK: UIImagePickerController Delegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func presentImagePickerFor(sourceType: UIImagePickerControllerSourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - UICollectionView
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("filter thumbnail count \(self.filtersThumbnails.count)")
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CustomCollectionViewCell.identifier(), forIndexPath: indexPath) as? CustomCollectionViewCell
        
//        let image = self.filtersThumbnails[indexPath.row]
//        cell.imageView.image = image
        cell!.backgroundColor = UIColor.redColor()
        
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        
//        let size = (screenSize.width / 3) - 7
        
        return CGSizeMake(100 , 100
        )
        
    }

}
