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

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addImageButtonSelected(sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.presentActionSheet()
        } else {
            self.presentImagePickerFor(.PhotoLibrary)
        }
        
//        if let image = self.imageView.image {
//            API.uploadImage(image) { (success) -> () in
//                if success {
//                    sender.enabled = true
//                    self.presentAlertView()
//                }
//            }
//        }
    }
    
    func presentAlertView() {
        let alertController = UIAlertController(title: "", message: "Image successfully uploaded.", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
    }
    
    func presentActionSheet() {
        let alertController = UIAlertController(title: "", message: "Please choose your source.", preferredStyle: .ActionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { (action) -> Void in
            
            self.presentImagePickerFor(.Camera)
        }
    }
    
    func presentImagePickerFor(sourceType: UIImagePickerControllerSourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
}
