//
//  WBTitleView.swift
//  WBPageView
//
//  Created by mac on 17/4/2.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

//表示该协议只能被类遵守
protocol  WBTitleViewDelegate : class {
    //不想使用外部参数，可以设置_
    func  titleView(titleView : WBTitleView , targartIndex:Int)

}

class WBTitleView: UIView,WBContentViewDelegate {
    
     // MARK: - 属性
     //代理属性.weak不能修饰协议，可以让代理继承与基协议
     weak var delegate : WBTitleViewDelegate?
    
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
    
    //记录当前选中的label
    var currentIndex : Int = 0
    //用一个数组来盛放所有的label
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
//          label.backgroundColor = UIColor.redColor()
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
          //5.给label添加手势
            let tapGes = UITapGestureRecognizer(target: self, action:aSelector)
            label.addGestureRecognizer(tapGes)
            
            titleLabels.append(label)

        }
        
          //6.设置label的frame
            var labelW : CGFloat = bounds.width / CGFloat(titleLabels.count)
            let labelH : CGFloat = style.titleHeight
            let labelY : CGFloat = 0
            var labelX : CGFloat = 0
            for (i,label) in titleLabels.enumerate(){
        
            //是否可以滑动
            if style.isScrollEnable { //可以滑动
                
              let size = CGSize(width: CGFloat(MAXFLOAT), height: 0)
                labelW = (label.text! as NSString).boundingRectWithSize(size, options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: style.titleFont], context: nil).width
                labelX = i == 0 ? (style.titleMargin * 0.5):(titleLabels[i-1].frame.maxX + style.titleMargin)
            
            } else{//不能滑动
                
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
    //1.校验label是否有值,将要选中还没选中的label
        guard let targartLabel = tapGes.view as? UILabel else {
         return
        
        }
        guard  targartLabel.tag != currentIndex else{
        
          return
        }
        let sourceLabel = titleLabels[currentIndex]
        sourceLabel.textColor = style.titleNomalColor
        targartLabel.textColor = style.titleSelecteColor
        currentIndex = targartLabel.tag
//       print(selectedLabel.tag)
        
        //让点击的标签回到中间
        adjustLabelPosition()
        
      //点击的时候，通知代理
      //可选链，有值就传递，没值就不传递，系统自己判断
        delegate?.titleView(self, targartIndex: currentIndex)
        
    }
    
    func adjustLabelPosition(){
    
        let selectLabel = titleLabels[currentIndex]
        var  offsetX : CGFloat = selectLabel.center.x - scrollView.bounds.width * 0.5
        if offsetX < 0 {
            offsetX = 0
            
        }
        let offsetMaxX : CGFloat = scrollView.contentSize.width - scrollView.bounds.width
        if offsetX > offsetMaxX{
            
            offsetX = offsetMaxX
        }
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    
    }

}
// MARK: - WBTitleViewDelegate
extension WBTitleView{

    func contentView(contentView: WBContentView, didScroll index: Int) {
        currentIndex = index
        adjustLabelPosition()
        
    }
    
func contentView(contentView:WBContentView,sourceIndex:Int,targartIndex:Int,progress:CGFloat){
    
//    
//    let sourceLabel = titleLabels[sourceIndex]
//    let targartLabel = titleLabels[targartIndex]

    
    }

}



