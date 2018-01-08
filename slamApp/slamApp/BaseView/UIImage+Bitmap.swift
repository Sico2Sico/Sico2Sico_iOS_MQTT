//
//  UIImage+Bitmap.swift
//  slamApp
//
//  Created by 德志 on 2017/12/13.
//  Copyright © 2017年 com.aiiage.www. All rights reserved.
//

import UIKit
 
class AiiBitmap {
    
    // MARK: - 根据长宽 创建Bitmap
    public class func creatBitmap(width:Int,height:Int,array:Array<Int>) -> UIImage? {
        
        // 颜色空间值
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // 申请内存地址bit
        let rawData:UnsafeMutablePointer<UInt32> = UnsafeMutablePointer<UInt32>.allocate(capacity:height*width*4)
        
        // 设置
        let bytesPerPixel = 4
        
        //  像素位数
        let bitsPerCompontent = 8
        
        // 每一占的bit数
        let bytesPerRow = bytesPerPixel * width
        
        // 创建bitmapinfo信息
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
        
        // 创建上下文
        let contex : CGContext = CGContext(data: rawData, width: width, height: height, bitsPerComponent: bitsPerCompontent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        
        print("开始绘制 == \(Date().timeIntervalSince1970)")
        //  修改每个像素值
        for x in 0 ..< width {
            for y in 0 ..< height {
                let  currentPixel = rawData + width * x + y
                
                if (x*width+y) < (width*height) && ((x*width+y) < array.count) {
                    if array[x*width+y] == 0 {
                        currentPixel.pointee = UInt32(rgbaMake(red:0, green: 0, bule: 0, apl:0))
                    } else if array[x*width+y] == 1 {
                        currentPixel.pointee = UInt32(rgbaMake(red:0, green: 0, bule: 0, apl: 1))
                    } else if  array[x*width+y] == 2 {
                        currentPixel.pointee = UInt32(rgbaMake(red:255, green: 0, bule: 0, apl: 1))
                    } else if array[x*width+y] == 3 {
                        currentPixel.pointee = UInt32(rgbaMake(red:0, green:0, bule: 0, apl: 1))
                    }
                }
            }
        }
        
        // 生成image数据
        let imageRef = contex.makeImage()
        
        // 释放资源
        free(rawData)
        
       print("结束绘制 == \(Date().timeIntervalSince1970)")
        
        
        return UIImage(cgImage: imageRef!).reSizeImage(reSize: CGSize(width: 200, height: 200))
    }
    
    // 设置像素值
    public class func rgbaMake(red: Int, green: Int, bule: Int, apl:Int) -> Int {
        return ((red&0xFf) << 16 | ((green&0xFF) << 8) | (bule&0xFF) | ((apl&0xFF) << 24))
    }
}


extension UIImage {
    func reSizeImage(reSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale)
        self.draw(in:CGRect(x:0, y: 0, width: reSize.width, height: reSize.height))
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return reSizeImage
    }
}
