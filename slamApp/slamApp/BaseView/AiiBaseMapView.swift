//
//  BaseMapView.swift
//  slamApp
//
//  Created by 德志 on 2017/12/7.
//  Copyright © 2017年 com.aiiage.www. All rights reserved.
//

import UIKit
import Result
import SnapKit
import ReactiveSwift
import ReactiveCocoa

public class AiiBaseMapView : UIView {
    
    let bgImageView = UIImageView()
    
    // 显示地图
    let mapImageView = UIImageView()
    
    // 路径View
    let pathView = UIView()
    
    // 定位位置view
    let position = UIView()
    
    var oldFrame : CGRect = CGRect.zero
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        mapImageView.addAutoLayoutSubviews(views: pathView,position)
        addAutoLayoutSubviews(views:bgImageView,mapImageView)
        
        setupUI()
        
        bindUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 设置UI
    func setupUI() {
        bgImageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        mapImageView.snp.makeConstraints { (make) in
             make.center.equalToSuperview()
        }
        
        pathView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        pathView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        bgImageView.image = UIImage(named:"bg")
        bgImageView.contentMode = .scaleAspectFill
        
        mapImageView.image = UIImage(named:"bitmap")
        mapImageView.contentMode = .center
        layoutIfNeeded()
        oldFrame = mapImageView.frame
        setGesture()
    }
    
    func bindUI() {
        
    }
    
    /// 添加手势
    fileprivate func setGesture() {
        let panGestureRecognizer  = UIPanGestureRecognizer()
        panGestureRecognizer.maximumNumberOfTouches = 1
        panGestureRecognizer.minimumNumberOfTouches = 1
        
        // 缩放
        panGestureRecognizer.addTarget(self, action:#selector(self.panmethod(panl:)))
        addGestureRecognizer(panGestureRecognizer)
        
        // 平移
        let pin = UIPinchGestureRecognizer()
        pin.addTarget(self, action:#selector(self.pinmethod(pin:)) )
        addGestureRecognizer(pin)
        
        isUserInteractionEnabled = true
    }
    
    
    @objc func panmethod(panl:UIPanGestureRecognizer) {
        let piont :CGPoint  = panl.location(in: self)
        print(piont)
        print(mapImageView.frame)
        print(mapImageView.center)
        
        // left
        if (mapImageView.center.x <= 0 ) && (piont.x < 0) {
            return
        }
        
        // right
        if (mapImageView.center.x >= self.frame.size.width) && (piont.x > 0) {
            return
        }
        
        // top
        if (mapImageView.center.y <= 0) && (piont.y < 0) {
            return
        }
        
        // bottom
        if (mapImageView.center.y >= self.frame.size.height) && (piont.y > 0) {
            return
        }
        
        mapImageView.center = piont
    }
    
    
    @objc func pinmethod(pin:UIPinchGestureRecognizer) {
        let scanl = pin.scale
    
        if (mapImageView.frame.size.width > 10*oldFrame.size.width) && ((scanl > 1.0)) {
            return
        }
        
        if (mapImageView.frame.size.width < oldFrame.size.width * 0.8) && (scanl < 1.0) {
            return
        }
        
        mapImageView.transform = (mapImageView.transform.scaledBy(x:scanl, y: scanl))

        pin.scale = 1
    }
    
    

}
