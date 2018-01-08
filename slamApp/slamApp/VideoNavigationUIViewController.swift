//
//  VideoNavigationUIViewController.swift
//  slamApp
//
//  Created by 德志 on 2017/12/7.
//  Copyright © 2017年 com.aiiage.www. All rights reserved.
//

import UIKit

class VideoNavigationUIViewController: UIViewController {

    let rootView = SlamVideoBaseView()
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.colorWhite
        self.navigationController?.automaticallyAdjustsScrollViewInsets = false
        navigationViewBind()
    }
    
    
    func setuiUp() {
        
    }
    
    
    func navigationViewBind() {
        rootView.nav.backBtn.reactive.controlEvents(UIControlEvents.touchUpInside).observeValues { ( _ ) in
            self.navigationController?.popViewController(animated:true)
        }
        rootView.nav.titleLabe.text = "视频导航"
    }

}
