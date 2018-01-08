//
//  MapNavigationViewController.swift
//  slamApp
//
//  Created by 德志 on 2017/12/7.
//  Copyright © 2017年 com.aiiage.www. All rights reserved.
//

import UIKit
import SnapKit
import Result
import CocoaMQTT
import ReactiveSwift
import ReactiveCocoa
import Alamofire
import SwiftyJSON


private let  productKey = ""
private let  deviceName = ""
private let  deviceSecret = ""
private let  clientid = "iPhone" + String(ProcessInfo().processIdentifier)

class MapNavigationViewController: UIViewController {

    let rootView = SlamMapBaseView()
    var mqtt = CocoaMQTT(clientID:clientid,host:"iot-as-mqtt.cn-shanghai.aliyuncs.com", port:1883)

    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.colorWhite
        self.navigationController?.automaticallyAdjustsScrollViewInsets = false
     
        navigationViewBind()
        tcpConnectLine()
//        HttpsConnect()
    }
    
    func navigationViewBind() {
        rootView.nav.backBtn.reactive.controlEvents(UIControlEvents.touchUpInside).observeValues { (but) in
            self.navigationController?.popViewController(animated:true)
        }
         rootView.nav.titleLabe.text = "地图导航"
    }
    
    
    // 关闭Sckot
    override func viewDidDisappear(_ animated: Bool) {
        //取消连接
        mqtt.disconnect()
    }
    
    
    // TCP直连
    func tcpConnectLine() {
        let dateFrame = "789" //String(format:"%.0f",Date().timeIntervalSince1970)
        let  mqtt = CocoaMQTT(clientID:clientid,host:"\(productKey).iot-as-mqtt.cn-shanghai.aliyuncs.com", port:1883)
        let  parameters = ["productKey":productKey,"deviceName":deviceName,"clientId":clientid,"timestamp":dateFrame]
        
        //排序 哈希签名
        let  password =  parameters.keysSortedToString().hmac(algorithm: CryptoAlgorithm.SHA1, key:deviceSecret)
        mqtt.clientID = clientid+"|securemode=3,signmethod=hmacsha1,timestamp=\(dateFrame)|"
        mqtt.username = "\(deviceName)&\(productKey)"
        mqtt.password = password
        mqtt.keepAlive = 90
        mqtt.delegate = self
        mqtt.connect()
    }
    
    
    // Https认证连接 - ---》1
    func httpsConnect() {
        let dateFrame = String(format:"%.0f",Date().timeIntervalSince1970)
        var parameters = ["productKey":productKey,
                          "deviceName":deviceName,
                          "clientId":clientid,
                          "timestamp":dateFrame]
        
        let  signVlaue =  parameters.keysSortedToString().hmac(algorithm: CryptoAlgorithm.SHA1, key:deviceSecret)
        parameters["sign"] = signVlaue
        parameters["signmethod"] = "hmacsha1"
        parameters["resources"]  = "mqtt"
    
  
        Alamofire.request("https://iot-auth.cn-shanghai.aliyuncs.com/auth/devicename", method: .post, parameters: parameters).responseJSON { response in
            
        
            guard response.result.isSuccess else{
                return
            }
            
            let json : JSON = JSON(response.result.value as Any)
            
            let iotId = json["data"]["iotId"].stringValue
            let iotToken = json["data"]["iotToken"].stringValue
            let host = json["data"]["resources"]["mqtt"]["host"].stringValue
            let port = json["data"]["resources"]["mqtt"]["port"].intValue
            
            self.httpsToTcpConnect(iotId: iotId, iotToken: iotToken, host:host , port:UInt16(port))
        }
    }
    
     // Https认证连接 - ---》2
    func httpsToTcpConnect(iotId:String,iotToken:String,host:String,port:UInt16) {
        let  mqtt = CocoaMQTT(clientID:clientid,host:host, port:port)
        mqtt.clientID = clientid
        mqtt.username = iotId
        mqtt.password = iotToken
        mqtt.keepAlive = 90
        mqtt.delegate = self
        mqtt.connect()
    }
    
}



// MARK: - 监听服务端代理块
extension MapNavigationViewController: CocoaMQTTDelegate {
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        if ack == CocoaMQTTConnAck.accept {
            mqtt.subscribe("/XL4qT4yo4Gw/\(deviceName)/map", qos: CocoaMQTTQOS.qos0)
        }
    }
    
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print(message)
    }
    
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        print(id)
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16 ) {
        print(message)
        
        let json : JSON = JSON(message.string as Any)
        
        let sizex  = json["sizex"].intValue
        let sizey  = json["sizey"].intValue
        let map    = json["map"].stringValue
        
        let mapData = Data(base64Encoded: map, options: Data.Base64DecodingOptions.init(rawValue: 0))
        let mapStr  = String(data: mapData!, encoding: String.Encoding.utf8)
        
        let array = UInt32ToUInt2.arrayUInt32ToUInt2(array:(mapStr?.toAarryInt())!)
        let imagedata = AiiBitmap.creatBitmap(width:Int(sizex), height:Int(sizey),array:array)
        
        rootView.contentView.mapView.mapImageView.image = imagedata
        rootView.contentView.mapView.mapImageView.contentMode = .center
        
        rootView.layoutIfNeeded()
    }
    
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topic: String) {
        print(topic)
    
//        //加载本地字txt资源
//        let path = Bundle.main.path(forResource:"mapStr", ofType:"txt")
//        let msg = try! String(contentsOfFile:path!, encoding: String.Encoding.utf8)
//         print(msg.characters.count)
//         mqtt.publish("/XL4qT4yo4Gw/\(deviceName)/map", withString:msg)
    }
    
    
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
        print(topic)
    }
    
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        print("ping")
    }
    
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        print("ping")
    }
    
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        print(err)
    }
    
    @objc func mqtt(_ mqtt: CocoaMQTT, didReceive trust: SecTrust, completionHandler: @escaping (Bool) -> Void) {
        print(trust)
    }
    
    
    @objc func mqtt(_ mqtt: CocoaMQTT, didPublishComplete id: UInt16) {
        print(id)
    }
    
    
    func  read(msg:String, fileName:String) {
        let fileManager = FileManager.default
        let file = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        let path = file! + fileName
        
        fileManager.createFile(atPath: path, contents:nil, attributes:nil)
        
        let handle = FileHandle(forWritingAtPath:path)
        handle?.write(msg.data(using: String.Encoding.utf8)!)
    }
  
}
