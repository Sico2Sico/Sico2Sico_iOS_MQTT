//
//  AppColor.swift
//  slamApp
//
//  Created by 德志 on 2017/12/7.
//  Copyright © 2017年 com.aiiage.www. All rights reserved.
//

import UIKit

class AppColor {

    open static let colorBlue = UIColor(rgb:0x003a9b)
    open static let colorBlueLight = UIColor(rgb:0x1650B1)
    open static let colorBlueDark = UIColor(rgb:0x002E87)

    open static let colorOrange = UIColor(rgb:0xff8c00)
    open static let colorOrange100 = UIColor(rgb:0xffaf00)

    open static let colorGray = UIColor(rgb:0xd7d7d7)
    open static let colorGray50 = UIColor(rgb:0xfafafa)
    open static let colorGray200 = UIColor(rgb:0xeeeeee)
    open static let colorGray300 = UIColor(rgb:0xe0e0e0)
    open static let colorGray500 = UIColor(rgb:0x9e9e9e)
    open static let colorGray700 = UIColor(rgb:0x616161)
    open static let colorGray800 = UIColor(rgb:0x424242)
    open static let colorGray900 = UIColor(rgb:0x212121)
    open static let colorGray216 = UIColor(rgb: 0xd8d8d8)

    open static let colorRed500 = UIColor(rgb:0xf44336)

    open static let colorGreen500 = UIColor(rgb:0x4caf50)
    open static let colorGreen600 = UIColor(rgb:0x43a047)

    open static let colorWhite = UIColor.white
    open static let colorWhite50 = UIColor(white:1.0,alpha:0.50)
    open static let colorWhite70 = UIColor(white:1.0,alpha:0.70)

    open static let colorBlack87 = UIColor(red:0,green:0,blue:0,alpha:0.87)
    open static let colorBlack56 = UIColor(red:0,green:0,blue:0,alpha:0.56)
    open static let colorBlack54 = UIColor(red:0,green:0,blue:0,alpha:0.54)
    open static let colorBlack38 = UIColor(red:0,green:0,blue:0,alpha:0.38)
    open static let colorBlack30 = UIColor(red:0,green:0,blue:0,alpha:0.30)
    open static let colorBlack12 = UIColor(red:0,green:0,blue:0,alpha:0.12)
    open static let colorBlack = UIColor(red:0,green:0,blue:0,alpha:1)

    open static let systemDefaultColor = UIColor(rgb:0xf7f7f7)

    /// 用于浅色背景时的水波纹效果,使用默认的inkView水波纹即可
    open static let colorInkDark = UIColor(white:0.0,alpha:0.12)

    /// 用于深色背景时的水波纹效果
    open static let colorInkLight = UIColor(white:1.0,alpha:0.12)

    open static let colorBackground = UIColor(rgb:0xf1f3fa)

    open static let colorSnakeBar = UIColor(rgb:0x323232)
}

extension UIColor {

    convenience init(red: Int, green: Int, blue: Int, apa: CGFloat = 1.0) {
        self.init(
            red: Int(CGFloat(red) / 255.0),
            green: Int(CGFloat(green) / 255.0),
            blue: Int(CGFloat(blue) / 255.0),
            apa: apa
        )
    }

    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF),
            green: CGFloat((rgb >> 8) & 0xFF),
            blue: CGFloat(rgb & 0xFF),
            alpha: alpha
        )
    }

}

