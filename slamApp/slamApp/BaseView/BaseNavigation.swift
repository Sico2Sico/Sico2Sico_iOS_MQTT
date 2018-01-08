//
//  BaseNavigation.swift
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

public class BaseNavigation : UIView {
    // 返回
    let backBtn = UIButton()
    
    // 标题
    let titleLabe = UILabel()
    
    // 取消按钮
    let cancelBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        addAutoLayoutSubviews(views: backBtn,titleLabe,cancelBtn)
        setupUI()
    }
    

    func setupUI() {
        backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        
        backBtn.snp.makeConstraints { (make) in
            make.size.equalTo(AppFrame.size44)
            make.leading.equalToSuperview().offset(AppFrame.margin12)
            make.centerY.equalToSuperview()
        }
        
        titleLabe.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.size.equalTo(AppFrame.size44)
            make.trailing.equalToSuperview().offset(-AppFrame.margin12)
        }
        
        backBtn.setTitle("返回", for: UIControlState.normal)
        backBtn.setTitleColor(AppColor.colorWhite, for: UIControlState.normal)
    
        titleLabe.text = "slamApp"
        titleLabe.textColor = AppColor.colorWhite
        
        cancelBtn.setTitle("取消", for: UIControlState.normal)
        cancelBtn.setTitleColor(AppColor.colorWhite, for: UIControlState.normal)
        cancelBtn.isHidden = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
