//
//  CustomFlowLayout.swift
//  ParseStarterProject-Swift
//
//  Created by Alberto Vega Gonzalez on 11/5/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class CustomFlowLayout: UICollectionViewFlowLayout {
    
    init(columns: CGFloat, separatorWidht: CGFloat) {
        super.init()
        let frame = UIScreen.mainScreen().bounds
        let width = CGRectGetWidth(frame)
        let cellWidth = (width / columns) - separatorWidht
        let size = CGSizeMake(cellWidth, cellWidth)
        
        self.itemSize = size
        self.minimumInteritemSpacing = separatorWidht
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
