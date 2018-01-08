//
//  UIView+AppUIkit.swift
//  slamApp
//
//  Created by 德志 on 2017/12/7.
//  Copyright © 2017年 com.aiiage.www. All rights reserved.
//

import UIKit



// 添加子试图
extension UIView {
    
    public func addAutoLayoutSubviews(views : UIView... ) {
       _ = views.map { (view) -> Void in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
    }
    
}
