//
//  WBPageStyle.swift
//  WBPageView
//
//  Created by mac on 17/4/2.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
// swift可以不继承任何类
// class可以换成struct，结构体比较轻量级
struct WBPageStyle {
    
    var titleHeight : CGFloat = 44  //titleView的高度
    var titleNomalColor : UIColor = UIColor.whiteColor()
    var titleSelecteColor : UIColor = UIColor.blueColor()
    var titleFont : UIFont = UIFont.systemFontOfSize(14)
    var isScrollEnable : ObjCBool = false
    var titleMargin : CGFloat = 20
    
    
    

}
