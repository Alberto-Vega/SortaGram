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
    
//    var filters:[(UIImage, (filteredImage: UIImage?, name: String) -> Void)] = []
   
    var currentPhoto: UIImage? {
        didSet {
            filterTableView.reloadData()
            imageView.image = currentPhoto
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        generateData()
        // ...
        if let tabBarController = self.tabBarController, viewControllers = tabBarController.viewControllers {
            if let galleryViewController = viewControllers[1] as? GalleryViewController {
                galleryViewController.delegate = self
                self.filterTableView.reloadData()
            }
        }
        
        // Tap Gesture Recognizer
        imageView.userInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapView:")
        imageView.gestureRecognizers = [tapGesture]
    }
    
    func tapView(gesture: UITapGestureRecognizer) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.presentActionSheet()
        } else {
            self.presentImagePickerFor(.PhotoLibrary)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.filterTableView.reloadData()

    }
    
    func galleryViewControllerDidFinish(image: UIImage) {
        
        // Set this View Controllers image to image
        self.currentPhoto = image
        self.imageView.image = self.currentPhoto
        // Get tabBar controller.
        self.tabBarController?.selectedIndex = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
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
    
// MARK: @IBActions
    
    @IBAction func addImageButtonSelected(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.presentActionSheet()
        } else {
            self.presentImagePickerFor(.PhotoLibrary)
        }
    }
    
    @IBAction func AddImagePressed(sender: UITapGestureRecognizer) {
        print("Image Tapped")
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.presentActionSheet()
        } else {
            self.presentImagePickerFor(.PhotoLibrary)
        }

        
    }
    @IBAction func filtersButtonPressed(sender: UIButton) {
        
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
        currentPhoto = image
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
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CustomCollectionViewCell.identifier(), forIndexPath: indexPath) as! CustomCollectionViewCell
        
        cell.filteredThumbnalImageView.image = nil
        
        if let currentPhoto = currentPhoto {
        setupFilteredCell(indexPath.row, image: currentPhoto, callback: { (filteredImage) -> () in
                cell.filteredThumbnalImageView.image = filteredImage
            })
        }
        return cell
    }

    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        let size = (screenSize.width / 3) - 7
        imageView.image = currentPhoto

        return CGSizeMake(size, size)
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
   
//MARK: Filters
    
    func setupFilteredCell(indexPath: Int, image: UIImage, callback:(UIImage?) -> ()) {
    switch indexPath {
    case 0:
        FilterService.applyBWEfect(image, completion: { (filteredImage, name) -> Void in
                callback(filteredImage)
        })
    case 1:
        FilterService.applyChromeEffect(image, completion: { (filteredImage, name) -> Void in
            callback(filteredImage)

        })
    case 2:
        FilterService.applyVintageEffect(image, completion: { (filteredImage, name) -> Void in
            callback(filteredImage)
        })
//    case 3:
//        FilterService.applyStarShineEffect(image, completion: { (filteredImage, name) -> Void in
//            callback(filteredImage)
//        })
  
    default: print("Filter outbounds")
    }
 }
}
