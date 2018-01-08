//
//  HMAC_SHA1.swift
//  slamApp
//
//  Created by 德志 on 2017/12/11.
//  Copyright © 2017年 com.aiiage.www. All rights reserved.
//

import UIKit
import Foundation

// MARK: - 加密  HMAC_SHA1/MD5/SHA1/SHA224......
/**  需在桥接文件导入头文件 ，因为C语言的库
 *   #import <CommonCrypto/CommonDigest.h>
 *   #import <CommonCrypto/CommonHMAC.h>
 */
enum CryptoAlgorithm {
    /// 加密的枚举选项
    case MD5, SHA1, SHA224, SHA256, SHA384, SHA512
    
    var HMACAlgorithm: CCHmacAlgorithm {
        var result: Int = 0
        switch self {
        case .MD5:      result = kCCHmacAlgMD5
        case .SHA1:     result = kCCHmacAlgSHA1
        case .SHA224:   result = kCCHmacAlgSHA224
        case .SHA256:   result = kCCHmacAlgSHA256
        case .SHA384:   result = kCCHmacAlgSHA384
        case .SHA512:   result = kCCHmacAlgSHA512
        }
        return CCHmacAlgorithm(result)
    }
    
    var digestLength: Int {
        var result: Int32 = 0
        switch self {
        case .MD5:      result = CC_MD5_DIGEST_LENGTH
        case .SHA1:     result = CC_SHA1_DIGEST_LENGTH
        case .SHA224:   result = CC_SHA224_DIGEST_LENGTH
        case .SHA256:   result = CC_SHA256_DIGEST_LENGTH
        case .SHA384:   result = CC_SHA384_DIGEST_LENGTH
        case .SHA512:   result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
}

extension String {
    /*
     *   func：加密方法
     *   参数1：加密方式； 参数2：加密的key
     */
    func hmac(algorithm: CryptoAlgorithm, key: String) -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = Int(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = algorithm.digestLength
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        let keyStr = key.cString(using: String.Encoding.utf8)
        let keyLen = Int(key.lengthOfBytes(using: String.Encoding.utf8))
        
        CCHmac(algorithm.HMACAlgorithm, keyStr!, keyLen, str!, strLen, result)
        
        let digest = stringFromResult(result:  result, length: digestLen)
        
        result.deallocate(capacity: digestLen)
        
        return digest
    }
    
    private func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash)
    }
}


extension Dictionary {
    
    func keysSortedToString() -> String {
        var str = ""
        let array = self.keys.sorted(by: {($0 as! String) < ($1 as! String)})
        for key in array {
            str.append(key as! String)
            let value = self[key]
            if value is String {
                str.append(value as! String)
            } else {
                fatalError("没有对value不是字符串的做处理 请注意⚠️")
            }
        }
        return str
    }
}
