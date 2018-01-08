//
//  PlatformView.swift
//  slamApp
//
//  Created by 德志 on 2017/12/7.
//  Copyright © 2017年 com.aiiage.www. All rights reserved.
//

import UIKit
import SnapKit
import Result
import ReactiveCocoa
import ReactiveSwift

enum RockDirection:Int {
    case center
    case left
    case right
    case up
    case down
}

public class PlatformView: UIView {
    
    // 背景
    let  bgImageView = UIImageView()
    
    // 左
    let  lefteImageView = UIImageView()
    
    // 上
    let  upImageView = UIImageView()
    
    // 右
    let  rightImageView = UIImageView()
    
    // 下
    let  downImageView = UIImageView()
    
    // 中间
    let pointImageView = UIImageView()
    
    
    //坐标
    var xx : CGFloat = 0
    var yy : CGFloat = 0
    
    //圆半径
    var bigR : CGFloat = 0
    var smallR :CGFloat = 0
    
    //方向图片控件集合
    var showRockDirectionImageViews:[UIImageView]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        addAutoLayoutSubviews(views: bgImageView)
        bgImageView.addAutoLayoutSubviews(views: lefteImageView,
                              upImageView,
                              rightImageView,
                              downImageView,
                              pointImageView)
        
        
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 设置UI
    func setupUI() {
        bgImageView.isUserInteractionEnabled = true
        bgImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        lefteImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        upImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        rightImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        downImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        pointImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    
        
        // 设置图片
        bgImageView.image = UIImage(named:"platform_handle_normal")
        
        lefteImageView.image = UIImage(named:"platform_handle_left")
        lefteImageView.isHidden = true
        
        upImageView.image = UIImage(named:"platform_handle_up")
        upImageView.isHidden = true
        
        rightImageView.image = UIImage(named:"platform_handle_right")
        rightImageView.isHidden = true
        
        downImageView.image = UIImage(named:"platform_handle_downend")
        downImageView.isHidden = true
        
        pointImageView.image = UIImage(named:"platform_normal_point")
        
        
        showRockDirectionImageViews = [lefteImageView,upImageView,rightImageView,downImageView]
        layoutIfNeeded()
        
        bigR = bgImageView.bounds.size.width * 0.5
        smallR = pointImageView.bounds.size.width * 0.5
    }
    
    
    // MARK: - 设置触摸 移动监听
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.positionWithLocation(touches: touches)
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.positionWithLocation(touches: touches)
    }
    

    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        pointImageView.frame.origin = CGPoint(x:(bigR-smallR), y:(bigR-smallR))
        layoutIfNeeded()
        showRockDirection(direction: RockDirection.center)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        pointImageView.frame.origin = CGPoint(x:(bigR-smallR), y:(bigR-smallR))
        layoutIfNeeded()
        showRockDirection(direction: RockDirection.center)
    }
    

    // 获取实际移动半径大小 修正半径
    func positionWithLocation(touches: Set<UITouch>) {
        let touch = touches.first
        var piont = touch?.location(in:bgImageView)
        
        // 获取半径大小
        xx = (piont?.x)! - bigR
        yy = -((piont?.y)! - bigR)
        let r  = sqrt(xx * xx + yy * yy)
        
        // 比较半径大小 修正位置
        if (r >= (bigR - smallR)) {
            xx = (bigR - smallR) * (xx / r)
            yy = (bigR - smallR) * (yy / r)
            
            piont?.x = xx + (bigR-smallR)
            piont?.y = -yy + (bigR-smallR)
        }
        
        pointImageView.frame.origin = piont!
        layoutIfNeeded()
        _ = rockerValueChanged()
        
    }
    
    
    func rockerValueChanged() -> RockDirection {
        
        var rockDirection = RockDirection.center
        
        let arc = Double(atan2f(Float(yy),Float(xx)))
        
        if ((arc > (3.0 / 4.0) * Double.pi && arc < Double.pi) || (arc < -(3.0 / 4.0) * Double.pi && arc > -Double.pi)) {
            rockDirection = RockDirection.left
        } else if (arc > (1.0 / 4.0) * Double.pi && arc < (3.0 / 4.0) * Double.pi) {
            rockDirection = RockDirection.up
        } else if ((arc > 0 && arc < (1.0 / 4.0) * Double.pi) || (arc < 0 && arc > -(1.0 / 4.0) * Double.pi)) {
            rockDirection = RockDirection.right
        } else if (arc > -(3.0 / 4.0) * Double.pi && arc < -(1.0 / 4.0) * Double.pi) {
            rockDirection = RockDirection.down
        } else if (0 == xx && 0 == yy) {
           rockDirection = RockDirection.center
        }
        
        showRockDirection(direction: rockDirection)
        return rockDirection
    }
    
    
    func showRockDirection(direction:RockDirection) {
        switch direction {
        case .center:
            showImageView(imageView:bgImageView)
        case .left:
            showImageView(imageView:lefteImageView)
        case .up:
            showImageView(imageView: upImageView)
        case .right:
            showImageView(imageView: rightImageView)
        case .down:
            showImageView(imageView: downImageView)
        }
    }
    
    
    func showImageView(imageView:UIImageView) {
       _ = showRockDirectionImageViews?.map({ (tmpView) -> UIImageView in
            if tmpView == imageView {
                tmpView.isHidden = false
            } else {
                tmpView.isHidden = true
            }
            
            return tmpView
        })
        
    }
    
}
