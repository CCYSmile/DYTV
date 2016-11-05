//
//  UIBarButtonItem_Extension.swift
//  DYZB
//
//  Created by CCY on 2016/11/5.
//  Copyright © 2016年 SKYDispark. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    class func creatItem(imageName: String, highImageName : String, size : CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        
        
        return UIBarButtonItem(customView: btn)
        
    }
    
    convenience init(imageName: String, highImageName : String = "", size : CGSize = CGSize.zero) {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
           btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView : btn)
        
    }
}
