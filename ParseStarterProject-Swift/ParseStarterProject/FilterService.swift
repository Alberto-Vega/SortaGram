//
//  FilterService.swift
//  ParseStarterProject-Swift
//
//  Created by Alberto Vega Gonzalez on 11/3/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class FilterService {
    
    private class func setupFilter(filterName: String, parameters: [String: AnyObject]?, image: UIImage) -> UIImage? {
        
        let image = CIImage(image: image)
        let filter : CIFilter
        
        if let parameters = parameters {
            filter = CIFilter(name: filterName, withInputParameters: parameters)!
        } else {
            filter = CIFilter(name: filterName)!
        }
        
        filter.setValue(image, forKey: kCIInputImageKey)
        
        let options = [kCIContextOutputColorSpace : NSNull()]
        let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
        let gpuContext = CIContext(EAGLContext: eaglContext, options: options)
        let outputImage = filter.outputImage
        let extent = outputImage!.extent
        let cgImage = gpuContext.createCGImage(outputImage!, fromRect: extent)
        let finalImage = UIImage(CGImage: cgImage)
        
        return finalImage
    }
    
    class func applyVintageEffect(image: UIImage, completion: (filteredImage: UIImage?, name: String) -> Void) {
        
        let filterName = "CIPhotoEffectTransfer"
        let displayName = "Vintage"
        let finalImage = self.setupFilter(filterName, parameters: nil, image: image)
        
        completion(filteredImage: finalImage, name: displayName)
        
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            completion(filteredImage: finalImage, name: displayName)
        }
    }
    
    class func applyBWEfect(image: UIImage, completion: (filteredImage: UIImage?, name: String) -> Void) {
        
        let filterName = "CIPhotoEffectMono"
        let displayName = "Black and White"
        let finalImage = self.setupFilter(filterName, parameters: nil, image: image)
        
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            completion(filteredImage: finalImage, name: displayName)
        }
    }
    
    class func applyChromeEffect(image: UIImage, completion: (filteredImage: UIImage?, name: String) -> Void) {
        
        let filterName = "CIPhotoEffectChrome"
        let displayName = "Chrome"
        let finalImage = self.setupFilter(filterName, parameters: nil, image: image)
        
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            completion(filteredImage: finalImage, name: displayName)
        }
    }
    
//    class func applyPixellateEffect(image: UIImage, completion: (filteredImage: UIImage?, name: String) -> Void) {
//        let filterName = "CIHexagonalPixellate"
//        let displayName = "Pixellate"
////        let finalImage = self.setupFilter(filterName, parameters: [CIAttributeTypePosition : CIAttributeTypeDistance ]?, image: image)
//        let finalImage = CIFilter(name: filterName, withInputParameters:
//        
//        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
//        completion(filteredImage: finalImage, name: displayName)
//    }
    
    
    class func applyStarShineEffect(image: UIImage, completion: (filteredImage: UIImage?, name: String) -> Void) {
    let filterName = "CIStarShineGenerator"
    let displayName = "Pixelate"
    let finalImage = self.setupFilter(filterName, parameters: nil, image: image)
    
    NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
    completion(filteredImage: finalImage, name: displayName)
    }
}
}
