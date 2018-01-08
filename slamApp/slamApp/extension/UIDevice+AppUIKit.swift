//
//  UIDevice+AppUIKit.swift
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


extension UIDevice {

    /// 是否横屏
    public var realOrientation:UIDeviceOrientation {
        let deviceOrientation = self.orientation
        
        if deviceOrientation.isPortrait == deviceOrientation.isLandscape {
            let rawValue = UIApplication.shared.statusBarOrientation.rawValue
            return UIDeviceOrientation(rawValue:rawValue)!
        } else {
            return deviceOrientation
        }
    }
    
    /// 设置判断
     public class var  isPad:Bool {
        return  UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
    
}

extension Reactive where Base: UIDevice {
    
    public func orientationChangeProducer()-> SignalProducer<UIDeviceOrientation,NoError> {
        return SignalProducer<UIDeviceOrientation,NoError> { observer,disposer in
            observer.send(value:self.base.realOrientation)
            NotificationCenter.default.reactive.notifications(forName:Notification.Name.UIDeviceOrientationDidChange).filterMap({ (notification) -> UIDeviceOrientation? in
                return self.base.orientation
            }).observe(observer)
        }
    }
    
}
