//
//  UIColor-Extension.swift
//  WBPageView
//
//  Created by mac on 17/4/3.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit


extension UIColor{
    
    // MARK:- 随机颜色
    class func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
    }
    
    // MARK:- 通过RGB来创建UIColor
    convenience init(r:CGFloat , g:CGFloat , b:CGFloat , a:CGFloat = 1.0){
        
        self.init(red: r / 255.0, green: g / 255/0, blue: b / 255.0, alpha: a)
        
    }
    
}

// MARK:- 从颜色中获取RGB值
extension UIColor{
// @warning swift2.0和swift3.0获取rgb区别
    class func getRGBValueFromColor(color:UIColor) -> (CGFloat,CGFloat,CGFloat){

        guard let r : CGFloat = CGColorGetComponents(color.CGColor)[0] else{
       
        fatalError("该颜色不是通过RGB创建")
            
        }
        guard  let g : CGFloat = CGColorGetComponents(color.CGColor)[1] else{
            
         fatalError("该颜色不是通过RGB创建")
        
        }
        guard  let b : CGFloat = CGColorGetComponents(color.CGColor)[2] else{
            
         fatalError("该颜色不是通过RGB创建")
        
        }
        
        return (r * 255 ,g * 255,b * 255)
        
    }
   
 
}


