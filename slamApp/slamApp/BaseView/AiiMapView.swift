//
//  MapView.swift
//  slamApp
//
//  Created by 德志 on 2017/12/7.
//  Copyright © 2017年 com.aiiage.www. All rights reserved.
//

import UIKit

public class AiiMapView: UIView {

    // 显示地图
    let mapView = AiiBaseMapView()
    
    // 控制view
    let platformView = PlatformView()
    
    let tmpView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
 
        tmpView.addAutoLayoutSubviews(views:platformView)
        addAutoLayoutSubviews(views: mapView,tmpView)
        
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        mapView.snp.makeConstraints { (make) in
            make.height.equalTo(AppFrame.screenHeight*0.5)
            make.top.leading.trailing.equalToSuperview()
        }
        
        tmpView.snp.makeConstraints { (make) in
            make.top.equalTo(mapView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        platformView.snp.makeConstraints { (make) in
            make.size.equalTo(AppFrame.size197)
            make.center.equalToSuperview()
        }
    }

}
