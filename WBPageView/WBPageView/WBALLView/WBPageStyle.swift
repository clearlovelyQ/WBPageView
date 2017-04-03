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
    var titleNomalColor : UIColor = UIColor(r: 255, g: 255, b: 255)
    var titleSelecteColor : UIColor = UIColor(r: 255, g: 127, b: 0)
    var titleFont : UIFont = UIFont.systemFontOfSize(14)
    var isScrollEnable : ObjCBool = false //TitleView是否可以滚动
    var titleMargin : CGFloat = 20
    
    
    

}
