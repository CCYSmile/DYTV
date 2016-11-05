//
//  PageTitleView.swift
//  DYZB
//
//  Created by CCY on 2016/11/5.
//  Copyright © 2016年 SKYDispark. All rights reserved.
//

import UIKit


protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectedIndex index : Int)
}
private let kScrollLineH : CGFloat = 2


class PageTitleView: UIView {
    
    // MARK:- 懒加载属性
    
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    lazy var scrollLine : UIView = {
       let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    lazy var titleLabels : [UILabel] = [UILabel]()
    
    // MARK:- 定义属性
    fileprivate var titles : [String]
    fileprivate var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
    
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        setuoUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
// MARK:- 设置UI界面
extension PageTitleView{
    fileprivate func setuoUI(){
        // 1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2.添加title对应的Label
        setupTitleLabels()
        
        // 3.设置底线和滚懂滑块
        setupBottomLineAndScrollLine()
    }
    fileprivate func setupTitleLabels(){
        
        let labelY : CGFloat = 0
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        
        for (index, title) in titles.enumerated() {
            let label : UILabel = UILabel()
            
            label.text = title
            label.tag = index
            label.textColor = UIColor.darkGray
            label.font = UIFont.systemFont(ofSize: 10.0)
            label.textAlignment = .center
            
            let labelX : CGFloat = labelW * CGFloat(index)
            
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            // 给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    fileprivate func setupBottomLineAndScrollLine(){
        // 1.添加底线
        let bottonLine = UIView()
        bottonLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        
        bottonLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottonLine)
        
        guard let firstLabel = titleLabels.first else {return}
        
        firstLabel.textColor = UIColor.orange
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.size.width, height: kScrollLineH)
        
    }
    
}
// MARK:- 监听label的点击
extension PageTitleView{
    @objc fileprivate func titleLabelClick(_ tapGes : UITapGestureRecognizer){
        // 1.获取当前label
        guard let currentLabel = tapGes.view as? UILabel else{return}
        // 2.获取之前的label
        let oldLabe = titleLabels[currentIndex]
        // 3.却换文字的颜色
        
        currentLabel.textColor = UIColor.orange
        oldLabe.textColor = UIColor.darkGray
        
        
        // 4.保存最新label的下标值
        currentIndex = currentLabel.tag
        // 5.滚动条位置发生改变
        let scrollLinePosition = CGFloat(currentLabel.tag) * scrollLine.frame.width
        
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLinePosition
        }
        
        // 6.通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}
