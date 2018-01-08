//
//  BaseView.swift
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


public class BaseView<NavigationView:UIView,ContentView:UIView>:UIView {
    let nav : NavigationView  = NavigationView()
    let contentView : ContentView = ContentView()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        addAutoLayoutSubviews(views:nav,contentView)
        
        nav.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(AppFrame.statusBarHeight + AppFrame.height44)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(nav.snp.bottom)
        }
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



public class SlamVideoBaseView : BaseView<BaseNavigation,VideView> {}
public class SlamMapBaseView :BaseView<BaseNavigation,AiiMapView> {}
