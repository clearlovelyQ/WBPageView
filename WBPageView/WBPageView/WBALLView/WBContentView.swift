//
//  WBContentView.swift
//  WBPageView
//
//  Created by mac on 17/4/2.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

// self在闭包中不能省略

private let kContentCellId = "contentCell"

class WBContentView: UIView,UICollectionViewDelegate,UICollectionViewDataSource {

    var childVCs : [UIViewController]
    var parentVC : UIViewController
//    lazy var collectionView : UICollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: UICollectionViewFlowLayout())
    //懒加载，必须先制定UICollectionView的类型才能使用self
    lazy var collectionView : UICollectionView = {
    
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = self.bounds.size
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .Horizontal

        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout:flowLayout)
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellId)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.pagingEnabled = true
        collectionView.bounces = false
            
       return collectionView
        
    }()
    
    
    init(frame: CGRect,childVCs:[UIViewController],parentVC:UIViewController) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        super.init(frame: frame)
        setupUI()
       
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - 创建UI
extension WBContentView{

    private func setupUI() {
    
        //1.把childVC加入parentVC
        for childVC in childVCs{
            parentVC.addChildViewController(childVC)
        }
       
        //2.添加collectionView
        addSubview(collectionView)

    }
}

// MARK: - dataSource
extension WBContentView{


    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kContentCellId, forIndexPath: indexPath)
        
    cell.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
        
        for subview in cell.contentView.subviews{
        
         subview.removeFromSuperview()
        
        }
       let vc = childVCs[indexPath.item]
       cell.contentView.addSubview(vc.view)
        
       return cell
        
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }


}

