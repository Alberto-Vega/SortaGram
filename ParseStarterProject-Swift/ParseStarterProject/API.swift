//
//  API.swift
//  ParseStarterProject-Swift
//
//  Created by Alberto Vega Gonzalez on 11/2/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import Foundation
import Parse

typealias ParseCompletionHandler = (success: Bool) -> ()

class API {
    
    class func uploadImage(image: UIImage, completion: ParseCompletionHandler) {
        if let imageData = UIImageJPEGRepresentation(image, 0.7) {
            let imageFile = PFFile(name: "image", data: imageData)
            let status = PFObject(className: "Status")
            status["image"] = imageFile
            
            status.saveInBackgroundWithBlock({ (success, error) -> Void in
                if success {
                    completion(success: success)
                } else {
                    completion(success: false)
                }
            })
        }
    }
    
    class func fetchStatusObjects(completion: (objects: [PFObject]?) -> ()) {
        
        let queryForStatusObjects = PFQuery(className:"Status")
        queryForStatusObjects.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // If the find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    var fetchedStatusArray = [PFObject]()
                    for object in objects {
                        print("Succeeded downloading \(object.objectId)")
                        fetchedStatusArray.append(object)
                    }
                    print("We have downloaded \(fetchedStatusArray.count) PFObjects")
                    completion(objects: fetchedStatusArray)
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
}
