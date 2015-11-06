//
//  CustomFlowLayout.swift
//  ParseStarterProject-Swift
//
//  Created by Alberto Vega Gonzalez on 11/5/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class CustomFlowLayout: UICollectionViewFlowLayout {
    
    init(rows: Int, columns: Int) {
        super.init()
        self.setup()
}
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup() {
        self.itemSize = CGSizeMake(159, 159)
        self.minimumLineSpacing = 2.0
        self.minimumInteritemSpacing = 2.0
    }
}
