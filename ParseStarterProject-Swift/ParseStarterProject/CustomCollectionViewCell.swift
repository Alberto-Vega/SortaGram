//
//  CustomCollectionViewCell.swift
//  ParseStarterProject-Swift
//
//  Created by Alberto Vega Gonzalez on 11/4/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var filteredThumbnalImageView: UIImageView!
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    var filteredFullSizeImage: UIImage? {
        didSet {
            if let fullSizeImage = filteredFullSizeImage {
                let size = (screenSize.width / 3) - 7
                filteredThumbnalImageView.image = UIImage.resizeImage(fullSizeImage, size: CGSize(width: size, height: size))
            }
        }
    }
    
    class func identifier() -> String {
        return "CustomCollectionViewCell"
    }
}

