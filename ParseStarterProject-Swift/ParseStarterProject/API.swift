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
}
