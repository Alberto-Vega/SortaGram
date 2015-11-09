//
//  PFObjectParser.swift
//  ParseStarterProject-Swift
//
//  Created by Alberto Vega Gonzalez on 11/8/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

typealias completionHandler = ([Status]?) ->([Status])

class PFObjectParser {

    class func convertObjectsToStatuses(objects:[PFObject]?, callback: completionHandler) {
        
        if let objects = objects {
            
            var statusArray = [Status]()
            
            for object in objects {
                
                let imageObject = object["image"] as! PFFile
                imageObject.getDataInBackgroundWithBlock({(imageData: NSData?, error: NSError?) -> Void in
                    if (error == nil) {
                        if let image = UIImage(data:imageData!) {
                            //image object implementation
                            let status = Status(image: image, statusUpdate: nil)
                            statusArray.append(status)
                            print(statusArray.count)
                            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//                                                    galleryCollectionView.reloadData()
                            })
                            print(image)
                            print("The status array in the parser: \(statusArray.count)")
                        }
                    }
                    callback(statusArray); return

                })//getDataInBackgroundWithBlock - end

            }
        }
    }
}