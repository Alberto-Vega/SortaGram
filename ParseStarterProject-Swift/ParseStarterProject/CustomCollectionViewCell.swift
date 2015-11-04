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
    
    
    
    
    class func identifier() -> String {
        return "CustomCollectionViewCell"
    }
}

