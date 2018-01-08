//
//  VideView.swift
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

public class VideView: UIView {

    // 视频播放view
    let videView = UIView()
    
    // 控制view
    let platformView = PlatformView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addAutoLayoutSubviews(views: videView,platformView)
        
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        isUserInteractionEnabled = true
        videView.backgroundColor = UIColor.darkGray
        videView.snp.makeConstraints { (make) in
            make.height.equalTo(AppFrame.screenHeight*0.5)
            make.top.leading.trailing.equalToSuperview()
        }
        
    
        platformView.snp.makeConstraints { (make) in
            make.top.equalTo(videView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
}
