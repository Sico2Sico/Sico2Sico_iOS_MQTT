//
//  UInt2+Array.swift
//  slamApp
//
//  Created by 德志 on 2017/12/16.
//  Copyright © 2017年 com.aiiage.www. All rights reserved.
//

import UIKit

let unint11 : UInt8 = 0b11

class UInt32ToUInt2 {
    
    public class func  arrayUInt32ToUInt2(array:[Int]) -> [Int] {
        var allUInt2Arrs:[Int] = []
        for value in array {
            let uInt2Arrs = UInt32ToUInt2.toInt(value:value)
            allUInt2Arrs += uInt2Arrs
        }
        return allUInt2Arrs
    }
    
    
    /// Int32 --> UInt2  0b 11 11 11 11 =  [byetOne,byetTwo,byetThree,byetFour]
    fileprivate class func toInt(value:Int) -> [Int] {
        
        let byetUInt8 = UInt8(truncatingBitPattern:value)
        
        let byetFour  =  byetUInt8 & unint11             //取出低位 1 0 位
        let byetThree = (byetUInt8  >> 2)  & unint11     //取出低位 3 2 位
        let byetTwo   = (byetUInt8  >> 4)  & unint11     //取出低位 5 4 位
        let byetOne   = (byetUInt8  >> 6)  & unint11     //取出低位 7 6 位
        
        return [Int(byetOne),Int(byetTwo),Int(byetThree),Int(byetFour)]
    }
}
