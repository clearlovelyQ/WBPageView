//
//  WBTitleView.swift
//  WBPageView
//
//  Created by mac on 17/4/2.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class WBTitleView: UIView {
    
    // MARK: - 属性
     var titles : [String]
     var style : WBPageStyle

    //使用调用闭包的方式，懒加载一个UIScrollView
     lazy var scrollView : UIScrollView = {
    
     let scrollView = UIScrollView(frame: self.bounds)
     scrollView.showsHorizontalScrollIndicator = false
    //点击最上方的时候，不能滚动到顶部
     scrollView.scrollsToTop = false
     return scrollView
    
    }()
    
    var currentIndex : Int = 0
  lazy  var  titleLabels : [UILabel] = [UILabel]()
    
    
    init(frame: CGRect,titles:[String],style:WBPageStyle) {
        
        self.titles = titles
        self.style = style
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
// MARK: - 创建UI
extension WBTitleView {


  private  func setupUI() {
    
    //1.添加ScrollView
    addSubview(scrollView)
    
    //2.创建titleLabel
    setupTitleLabels()
    
    }

    private func setupTitleLabels(){
    
//        var titleLabels : [UILabel] = [UILabel]()
        for(i , title) in titles.enumerate() {
          //1.创建label
          let label = UILabel()
          //2.设置label的属性
          label.tag = i
          label.backgroundColor = UIColor.redColor()
          label.text = title
          label.textColor = i == 0 ? style.titleSelecteColor :style.titleNomalColor
          label.font = style.titleFont
          label.textAlignment = .Center
          label.userInteractionEnabled = true
            //3.添加到scrollView上
          scrollView.addSubview(label)
            //4.监听label的点击
            //#selextor(方法名) swift3.0
            let aSelector:Selector = "titleLabelClick:"
            let tapGes = UITapGestureRecognizer(target: self, action:aSelector)
            label.addGestureRecognizer(tapGes)
            
            titleLabels.append(label)

        }
        
        //设置label的frame
        var labelW : CGFloat = bounds.width / CGFloat(titleLabels.count)
        let labelH : CGFloat = style.titleHeight
        let labelY : CGFloat = 0
        var labelX : CGFloat = 0
        for (i,label) in titleLabels.enumerate(){
        
            if style.isScrollEnable {
              let size = CGSize(width: CGFloat(MAXFLOAT), height: 0)
              labelW = (label.text! as NSString).boundingRectWithSize(size, options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: style.titleFont], context: nil).width
              labelX = i == 0 ? (style.titleMargin * 0.5):(titleLabels[i-1].frame.maxX + style.titleMargin)
            
            } else{
                labelX = labelW * CGFloat(i)
            }
         label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
        }
        
        if style.isScrollEnable{
         scrollView.contentSize = CGSize(width: (titleLabels.last?.frame.maxX)!+(style.titleMargin * 0.5), height: 0)
        
        }
    
    }
}
// MARK: - label手势的点击
extension WBTitleView{

    func titleLabelClick(tapGes: UITapGestureRecognizer ){
    
     //可选链 取得tap点击的label，可能转成功，可能转不成功
    //1.校验label是否有值
        guard let selectedLabel = tapGes.view as? UILabel else {
         return
        
        }
        let sourceLabel = titleLabels[currentIndex]
        sourceLabel.textColor = style.titleNomalColor
        selectedLabel.textColor = style.titleSelecteColor
        currentIndex = selectedLabel.tag
       print(selectedLabel.tag)
    
    }

}



