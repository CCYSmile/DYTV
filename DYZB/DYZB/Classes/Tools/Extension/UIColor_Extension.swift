//
//  UIColor_Extension.swift
//  DYZB
//
//  Created by CCY on 2016/11/5.
//  Copyright © 2016年 SKYDispark. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat ) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
