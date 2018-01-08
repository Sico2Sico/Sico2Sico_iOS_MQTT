//
//  MainViewController.swift
//  slamApp
//
//  Created by 德志 on 2017/12/7.
//  Copyright © 2017年 com.aiiage.www. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result
import SnapKit

class MainViewController : UIViewController {
    
    let mapNavigation : UIButton = UIButton()
    let videoNavigation : UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated:true)
        view.backgroundColor = UIColor(patternImage: UIImage(named:"bg")!)
        
        //添加views
        view.addAutoLayoutSubviews(views: mapNavigation,videoNavigation)
    
        //setUI
        setupUI()
    
    }

    /// 设置UI布局
    func setupUI() {
        mapNavigation.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(AppFrame.height56)
            make.width.equalTo(AppFrame.width180)
            make.centerY.equalToSuperview().offset(-AppFrame.height56)
        }
        
        
        videoNavigation.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(AppFrame.height56)
            make.width.equalTo(AppFrame.width180)
            make.centerY.equalToSuperview().offset(AppFrame.height56)
        }
        
        
        mapNavigation.setTitle("地图导航", for:.normal)
        mapNavigation.setTitleColor(AppColor.colorOrange100, for: .normal)
        mapNavigation.reactive.controlEvents(UIControlEvents.touchUpInside).observeValues { (but) in
            self.navigationController?.pushViewController(MapNavigationViewController(), animated: true)
        }
        
        
        videoNavigation.setTitle("视频导航", for:.normal)
        videoNavigation.setTitleColor(AppColor.colorOrange100, for: .normal)
        videoNavigation.reactive.controlEvents(UIControlEvents.touchUpInside).observeValues { (but) in
            self.navigationController?.pushViewController(VideoNavigationUIViewController(), animated: true)
        }
        
    }

}
