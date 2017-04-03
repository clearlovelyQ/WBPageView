//
//  ViewController.swift
//  WBPageView
//
//  Created by mac on 17/4/2.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //导航栏下面是一个ScrollView，不让他下移64
        automaticallyAdjustsScrollViewInsets = false
        
        //创建pageView
        //1.frame
        let pageFrame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
        //2.显示的标题
        let titles = ["推荐","游戏","游玩","LOL","杭州","游玩的时候","你的名字和选择","iOS开发"]
        //3.所有子控制器
        var childVCs = [UIViewController]()
           //i没有使用，可以用_来代替
        for _ in 0..<titles.count{
          let vc = UIViewController()
          //swift中不同类型之间不能进行运算
          vc.view.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
          childVCs.append(vc)
        }
        //4.style,只有变成var，结构体才可以修改
        var style = WBPageStyle()
        style.isScrollEnable = true
        
        let pageView =  WBPageView(frame: pageFrame, titles: titles, style: style, childVCs: childVCs, parentVC: self)
        
        view.addSubview(pageView)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

