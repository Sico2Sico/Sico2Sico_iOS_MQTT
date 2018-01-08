//
//  String+ArrayInt.swift
//  slamApp
//
//  Created by 德志 on 2017/12/16.
//  Copyright © 2017年 com.aiiage.www. All rights reserved.
//

import UIKit
import Foundation

extension  String {
    
    public func toAarryInt() -> [Int] {
        var array:[Int] = []
        print("字符串的长度 === \(self.count)")
        for value in self.characters {
            array.append(Int(Int32(bitPattern: (String(value).unicodeScalars.first?.value)!)))
        }
        print("转为int数组后 数组的长度为 === \(array.count)")
        return array
    }
}
