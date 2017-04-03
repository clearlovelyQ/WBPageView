//
//  WBPageView.swift
//  WBPageView
//
//  Created by mac on 17/4/2.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit


class WBPageView: UIView {
    
    
    // MARK: - 属性
    // 可以使用可选类型，但是以后使用还需要解包，不推荐使用
    var titles:[String]
    var style : WBPageStyle
    var childVCs : [UIViewController]
    var parentVC : UIViewController

    // MARK: - 构造函数
    // 在构造函数使用super.init(frame: frame)之前，必须把所有属性初始化
    init(frame: CGRect,titles:[String],style:WBPageStyle,childVCs:[UIViewController],parentVC:UIViewController) {
        
        self.titles = titles
        self.style = style
        self.childVCs = childVCs
        self.parentVC = parentVC
        super.init(frame: frame)
        //写在super.init的后面
        setupUI()
    
        
    }

    //通过xlb/storyBoard中创建走这个方法
    //用required修饰的构造函数
    //如果子类重写或者自定义其他构造函数，必须要写required修饰的构造函数
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - 创建UI
extension WBPageView {

    private func setupUI(){
       
        //1.创建titleView
        let titleFrame = CGRect(x: 0, y: 0, width: bounds.width, height: style.titleHeight)
        let titleView = WBTitleView(frame: titleFrame, titles: titles, style: style)
        titleView.backgroundColor = UIColor.blueColor()
      
        addSubview(titleView)
        
        //2.创建contentView
        let contentFrame = CGRect(x: 0, y: titleFrame.maxY, width: bounds.width, height: bounds.height - style.titleHeight)
        let contentView = WBContentView(frame: contentFrame, childVCs: childVCs, parentVC: parentVC)
        contentView.backgroundColor = UIColor.redColor()
       
        addSubview(contentView)
        
        //3.让titleView和contentView相互沟通
        titleView.delegate = contentView
        contentView.delegate = titleView
        
     
        
        
     
    }
   

}
