//
//  WBContentView.swift
//  WBPageView
//
//  Created by mac on 17/4/2.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

protocol WBContentViewDelegate: class{

    func contentView(contentView:WBContentView,didScroll index :Int)
    //改变titleView标签的颜色改变
func contentView(contentView:WBContentView,sourceIndex:Int,targartIndex:Int,progress:CGFloat)
}

// self在闭包中不能省略
private let kContentCellId = "contentCell"

class WBContentView: UIView,UICollectionViewDelegate,UICollectionViewDataSource ,WBTitleViewDelegate{
    
    weak var delegate : WBContentViewDelegate?
    //起始的偏移量的x
    var startOffsetX :CGFloat = 0

    var childVCs : [UIViewController]
    var parentVC : UIViewController
//    lazy var collectionView : UICollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: UICollectionViewFlowLayout())
    //懒加载，必须先制定UICollectionView的类型才能使用self
    lazy var collectionView : UICollectionView = {
    
        //flowlayout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = self.bounds.size
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .Horizontal

        //collectionView
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
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kContentCellId, forIndexPath: indexPath)
        
    cell.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
        
        //每一次添加childVC的view之前，先把重用的删除
        for subview in cell.contentView.subviews{
        
         subview.removeFromSuperview()
        
        }
        //取得childVC
       let vc = childVCs[indexPath.item]
        //添加childVc的view
       cell.contentView.addSubview(vc.view)
        
       return cell
        
    }
}
// MARK: - WBTitleViewDelegate
extension WBContentView {

    func titleView(titleView: WBTitleView, targartIndex: Int) {
       let indexPath = NSIndexPath(forItem: targartIndex, inSection: 0)
       collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: false)
        
    }

}
//MARK: - ScrollViewDelegate
extension WBContentView{
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let contentOffsetX = scrollView.contentOffset.x
     //0.先判断是否滑动。startOffset = contentOffset
     //guard:是真的就继续执行，假的走{}
        guard contentOffsetX != startOffsetX else{
          
            return
        
        }
    
     //1.定义出需要获取的变量
        var sourceIndex = 0
        var targartIndex = 0
        var progress : CGFloat = 0
     //2.需要的参数
     //根据当前的偏移量和起始的偏移量来判断左滑还是右滑
        if(contentOffsetX > startOffsetX){ //左滑
          
            sourceIndex = Int(contentOffsetX / collectionView.bounds.width)
            targartIndex = sourceIndex + 1
            //防止最后一个越界
            if targartIndex >= childVCs.count{
            
               targartIndex = childVCs.count - 1
            }
            //当前滑动的一个比例
            progress = (contentOffsetX - startOffsetX) / collectionView.bounds.width
            
//            print("sourceIndex:\(sourceIndex),selectedIndex:\(selectedIndex),progress:\(progress)")
        
        }else{//右滑
            
            targartIndex = Int(contentOffsetX / collectionView.bounds.width)
            sourceIndex = targartIndex + 1
            progress = (startOffsetX - contentOffsetX) / collectionView.bounds.width
        
        }
     
        
    delegate?.contentView(self, sourceIndex: sourceIndex, targartIndex: targartIndex, progress: progress)
    }
    

    //直接滚动一整个ScrollView
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate{
        scrollDidEnd()
        }
    }
    //有个减速的过程，滚动到1半，手指松开，自动减速滚动回去
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        scrollDidEnd()
    }

    private func scrollDidEnd(){
   
        let i  = Int(collectionView.contentOffset.x / collectionView.bounds.width)
        delegate?.contentView(self, didScroll: i)
        
        
    }


}

