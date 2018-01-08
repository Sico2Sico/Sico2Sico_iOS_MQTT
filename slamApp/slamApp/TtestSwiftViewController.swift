//
//  testSwiftViewController.swift
//  slamApp
//
//  Created by 德志 on 2017/12/11.
//  Copyright © 2017年 com.aiiage.www. All rights reserved.
//

import UIKit

class TtestSwiftViewController: UIViewController {
    
    let  image:UIImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(image)
        image.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }

        image.contentMode = .scaleAspectFit
//        view.layoutIfNeeded()
//
//        image.image = AiiBitmap.creatBitmap(width:1, height:200)
        
        let arry =  UInt32ToUInt2.arrayUInt32ToUInt2(array: "0".toAarryInt())
        print(arry)
        
//        let aarrt  =  rectTO()
        
//        read(msg: "ubn",fileName: "mapone.text")
        
            let imagedata  =  AiiBitmap.creatBitmap(width: 666, height: 666, array:rectTO())
        
            let imageScale = imagedata?.reSizeImage(reSize:CGSize(width:200, height: 200))
        
            image.image = imageScale
        
        
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask,true).first
        let filepath = path?.appending("map.png")
        
        let fileManager = FileManager.default
        
        fileManager.createFile(atPath:filepath!, contents:nil, attributes:nil)
        
        let handle = FileHandle(forWritingAtPath:filepath!)
        
        let  data = UIImagePNGRepresentation(imagedata!)
        handle?.write(data!)
    }
    

    
    func rectTO() -> [Int] {
        let count = 666*666
        var array  = Array<Int>(repeating:0, count:count)
        
        var x = 0
        while (x < 666) {
            var y = 0
            while(y < 666) {
                
                if (x == 0) || (y == 0) || (x == 666-1) || (y == 666-1) {
                    
                    if (x*666+y) < array.count {
                        array[x*666 + y] = 1
                    }
                }
                y += 1
            }
            x += 1
        }
        return array
    }
   

}
