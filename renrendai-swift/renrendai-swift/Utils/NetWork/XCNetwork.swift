//
//  XCNetwork.swift
//  renrendai-swift
//
//  Created by 周希财 on 2019/8/9.
//  Copyright © 2019 VIC. All rights reserved.
//

import Foundation
import Alamofire
import Toast_Swift

typealias successBlock = (Any)->()
typealias errorBlock = (Any)->()
typealias NetworkStatus = (_ XCNetworkStatus: Int32) -> ()

private let CurrentNetWork : NetworkEnvironment = .Test

private var xcNetworkStatus : XCNetworkStatus = XCNetworkStatus.wifi

/// 传参方式
//    1、JSONEncoding.default 是放在HttpBody内的，   比如post请求
//    2、URLEncoding.default 在GET中是拼接地址的，    比如get请求
//    3、URLEncoding(destination: .methodDependent) 是自定义的URLEncoding，methodDependent的值如果是在GET 、HEAD 、DELETE中就是拼接地址的。其他方法方式是放在httpBody内的。
//    4、URLEncoding(destination: .httpbody)是放在httpbody内的
enum Encoding {
    case URL
    case JSON
}

// 登录服务
private var Base_Url = ""

/*
 * 配置你的网络环境
 */
enum  NetworkEnvironment{
    case Development
    case Test
    case Distribution
}
/*
 * 当前网络
 */
@objc enum XCNetworkStatus: Int32 {
    case unknown          = -1//未知网络
    case notReachable     = 0//网络无连接
    case wwan             = 1//2，3，4G网络
    case wifi             = 2//wifi网络
}


class XCNetWorkTools: NSObject {
    private var sessionManager: SessionManager?
    static let share = XCNetWorkTools()
    
    override init() {
        super.init()
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        sessionManager = SessionManager.init(configuration: configuration, delegate: SessionDelegate(), serverTrustPolicyManager: nil)
    }
}

private func XCNetwork(network : NetworkEnvironment = CurrentNetWork){
    
    if(network == .Development){
        
        Base_Url = ""
        
        
    }else if(network == .Test){
        
        Base_Url = "http://192.168.2.3:8900/rrd/"
        
    }else{
        
        Base_Url = ""
        
    }
}

/// 设置请求头
let headers :HTTPHeaders = [
    "Accept": "application/json",
    "Content-Type" : "application/json"

]

extension XCNetWorkTools {
    ///监听网络状态
    public func detectNetwork(netWorkStatus: @escaping NetworkStatus) {
        let reachability = NetworkReachabilityManager()
        reachability?.startListening()
        reachability?.listener = { [weak self] status in
            if reachability?.isReachable ?? false {
                switch status {
                case .notReachable:
                    xcNetworkStatus = XCNetworkStatus.notReachable
                case .unknown:
                    xcNetworkStatus = XCNetworkStatus.unknown
                case .reachable(.wwan):
                    xcNetworkStatus = XCNetworkStatus.wwan
                case .reachable(.ethernetOrWiFi):
                    xcNetworkStatus = XCNetworkStatus.wifi
                }
            } else {
                xcNetworkStatus = XCNetworkStatus.notReachable
            }
            netWorkStatus(xcNetworkStatus.rawValue)
        }
    }
    ///监听网络状态
    public func obtainDataFromLocalWhenNetworkUnconnected() {
        self.detectNetwork { (_) in
        }
    }
    
    //网络请求
    func requestData(type: HTTPMethod,
                     api: String,
                     encoding: Encoding,
                     parameters: Parameters? = nil,
                     success: @escaping successBlock,
                     faild: @escaping errorBlock) -> () {

        //拼接URL
        XCNetwork();
        let url = Base_Url + api;
        var paramEncoding : ParameterEncoding

        if encoding == .URL{
            paramEncoding = URLEncoding.default
        }else{
            paramEncoding = JSONEncoding.default
        }

        self.sessionManager?.request(url,
                                     method: type,
                                     parameters: parameters,
                                     encoding: paramEncoding,
                                     headers: headers)
            .responseJSON(completionHandler: { (resJson) in
            
            print("url:\(resJson.request)"  + "isSuccess?:\(resJson.result)")  // 原始的URL请求
            print(resJson.result.value)   // 响应序列化结果，在这个闭包里，存储的是JSON数据
            
                switch resJson.result {

                    case .success:
                        if let value = resJson.result.value {
                            let dic = value as! [String:Any]
                            if dic["code"] as! NSInteger == 200 {
                               success(dic["data"])
                            }
                            else
                            {
                                BaseViewController.currentViewController()?.view.makeToast(dic["msg"] as! String)
                                faild(dic["msg"])
        
                            }
                        }

                    case .failure(let error):

                        print("GetErrorUrl:\(String(describing: resJson.request))")
                        print("GetError:\(error)")
                        faild(error.localizedDescription)
                    }
        })
        
    }
    
    //图片上传
    static func upDataIamgeRequest(api : String,
                                   parameters : [String : String],
                                   imageArr : [UIImage],
                                   name:String,
                                   fileName:String,
                                   successHandler: @escaping successBlock,
                                   errorMsgHandler : @escaping errorBlock) ->(){
        //拼接URL
        XCNetwork();
        let url = Base_Url + api;

        Alamofire.upload(
            multipartFormData: { multipartFormData in
                for img in imageArr{
                    let imageData = img.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: name, fileName: fileName, mimeType: "image/png")
                }
        },
            to: url,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                    }
                    upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                        print("图片上传进度: \(progress.fractionCompleted)")
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        )
        
    }
}




