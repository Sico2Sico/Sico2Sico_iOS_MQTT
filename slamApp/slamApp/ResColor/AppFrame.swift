//
//  AppCGFloat.swift
//  slamApp
//
//  Created by 德志 on 2017/12/7.
//  Copyright © 2017年 com.aiiage.www. All rights reserved.
//

import UIKit

class AppFrame {

    open static var screenWidth:CGFloat {
        return UIScreen.main.bounds.size.width
    }
    open static var screenHeight:CGFloat {
        return UIScreen.main.bounds.size.height
    }
    open static let statusBarHeight = UIApplication.shared.statusBarFrame.height

    open static var dialogWidth:CGFloat {
        get {
            return UIDevice.isPad ? CGFloat(540.0) : CGFloat(270.0)
        }
    }
    open static var dialogHeightPad = CGFloat(618.0)

    open static let height1 = CGFloat(1.0)
    open static let height2 = CGFloat(2.0)
    open static let height8 = CGFloat(8.0)
    open static let height16 = CGFloat(16.0)
    open static let height20 = CGFloat(20.0)
    open static let height22 = CGFloat(22.0)
    open static let height32 = CGFloat(32.0)
    open static let height36 = CGFloat(36.0)
    open static let height40 = CGFloat(40.0)
    open static let height44 = CGFloat(44.0)
    open static let height48 = CGFloat(48.0)
    open static let height56 = CGFloat(56.0)
    open static let height60 = CGFloat(60.0)
    open static let height64 = CGFloat(64.0)
    open static let height66 = CGFloat(66.0)
    open static let height72 = CGFloat(72.0)
    open static let height76 = CGFloat(76.0)
    open static let height88 = CGFloat(88.0)
    open static let height92 = CGFloat(92.0)
    open static let height96 = CGFloat(96.0)
    open static let height100 = CGFloat(100.0)
    open static let height112 = CGFloat(112.0)
    open static let height118 = CGFloat(118.0)
    open static let height120 = CGFloat(120.0)
    open static let height124 = CGFloat(124.0)
    open static let height214 = CGFloat(214.0)
    open static let height236 = CGFloat(236.0)

    open static let width1 = CGFloat(1.0)
    open static let width2 = CGFloat(2.0)
    open static let width36 = CGFloat(36.0)
    open static let width44 = CGFloat(44.0)
    open static let width48 = CGFloat(48.0)
    open static let width38 = CGFloat(38.0)
    open static let width52 = CGFloat(52.0)
    open static let width72 = CGFloat(72.0)
    open static let width124 = CGFloat(124.0)
    open static let width162 = CGFloat(162.0)
    open static let width180 = CGFloat(180.0)
    open static let width240 = CGFloat(240.0)
    open static let width360 = CGFloat(360.0)
    open static let width380 = CGFloat(380.0)
    open static let width448 = CGFloat(448.0)

    open static let size4 = CGFloat(4.0)
    open static let size8 = CGFloat(8.0)
    open static let size12 = CGFloat(12.0)
    open static let size16 = CGFloat(16.0)
    open static let size18 = CGFloat(18.0)
    open static let size20 = CGFloat(20.0)
    open static let size24 = CGFloat(24.0)
    open static let size30 = CGFloat(30.0)
    open static let size38 = CGFloat(38.0)
    open static let size40 = CGFloat(40.0)
    open static let size44 = CGFloat(44.0)
    open static let size48 = CGFloat(48.0)
    open static let size56 = CGFloat(56.0)
    open static let size88 = CGFloat(88.0)
    open static let size96 = CGFloat(96.0)
    open static let size180 = CGFloat(180.0)
    open static let size197 = CGFloat(197)
    open static let size360 = CGFloat(360.0)

    open static let margin2 = CGFloat(2.0)
    open static let margin4 = CGFloat(4.0)
    open static let margin6 = CGFloat(6.0)
    open static let margin8 = CGFloat(8.0)
    open static let margin12 = CGFloat(12.0)
    open static let margin14 = CGFloat(14.0)
    open static let margin16 = CGFloat(16.0)
    open static let margin20 = CGFloat(20.0)
    open static let margin22 = CGFloat(22.0)
    open static let margin24 = CGFloat(24.0)
    open static let margin28 = CGFloat(28.0)
    open static let margin32 = CGFloat(32.0)
    open static let margin40 = CGFloat(40.0)
    open static let margin50 = CGFloat(50.0)
    open static let margin56 = CGFloat(56.0)
    open static let margin66 = CGFloat(66.0)
    open static let margin68 = CGFloat(68.0)
    open static let margin72 = CGFloat(72.0)
    open static let margin120 = CGFloat(120.0)
    open static let margin128 = CGFloat(128.0)
    open static let margin160 = CGFloat(160.0)
    open static let margin204 = CGFloat(204.0)
    open static let margin280 = CGFloat(280.0)
    open static let margin420 = CGFloat(420.0)

    open static let marginLeading4 = CGFloat(4.0)
    open static let marginLeading8 = CGFloat(8.0)
    open static let marginLeading16 = CGFloat(16.0)
    open static let marginLeading24 = CGFloat(24.0)
    open static let marginLeading72 = CGFloat(72.0)

    open static let marginTrailing4 = CGFloat(4.0)
    open static let marginTrailing8 = CGFloat(8.0)
    open static let marginTrailing12 = CGFloat(12.0)
    open static let marginTrailing16 = CGFloat(16.0)
    open static let marginTrailing80 = CGFloat(80.0)

    open static let marginTop2 = CGFloat(2.0)
    open static let marginTop4 = CGFloat(4.0)
    open static let marginTop8 = CGFloat(8.0)
    open static let marginTop12 = CGFloat(12.0)
    open static let marginTop14 = CGFloat(14.0)
    open static let marginTop16 = CGFloat(16.0)
    open static let marginTop24 = CGFloat(24.0)
    open static let marginTop32 = CGFloat(32.0)
    open static let marginTop40 = CGFloat(40.0)
    open static let marginTop48 = CGFloat(48.0)
    open static let marginTop72 = CGFloat(72.0)
    open static let marginTop120 = CGFloat(120.0)
    open static let marginTop276 = CGFloat(276.0)

    open static let marginBottom8 = CGFloat(8.0)
    open static let marginBottom32 = CGFloat(32.0)
    open static let marginBottom40 = CGFloat(40.0)
    open static let marginBottom224 = CGFloat(224.0)
    open static let marginBottom120 = CGFloat(120.0)
    open static let marginBottom192 = CGFloat(192.0)
    open static let marginBottom432 = CGFloat(432.0)

    open static let radius2 = CGFloat(2.0)
    open static let radius4 = CGFloat(4.0)
    open static let radius16 = CGFloat(16.0)

    open static let maxRippleradius = CGFloat(22.0)

}

