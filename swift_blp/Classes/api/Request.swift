//
//  Request.swift
//  swift_blp
//
//  Created by Apple on 10/19/23.
//  网络请求工具类：Alamofire + Moya + SwiftyJSON
//

import Foundation
import Moya
import SwiftyJSON

public class JhHttpTool {
    /// 使用Moya的请求封装
    ///
    /// - Parameters:
    ///   - target: 请求API，TargetType里的枚举值
    ///   - success: 成功的回调
    ///   - error: 连接服务器成功但是数据获取失败
    ///   - failure: 连接服务器失败
    public class func request<T: TargetType>(_ target: T, success: @escaping((Any) -> Void), failure: ((Int?, String) ->Void)?) {
        let provider = MoyaProvider<T>(plugins: [
            RequestHandlingPlugin(),
                        networkLoggerPlugin
        ])
        
        provider.request(target) { result in
            switch result {
            case let .success(response):
                //                let json = try? response.mapString()
                //                let responseObject = try? response.mapJSON()
                //                JhLog( responseObject ?? "" );
                do {
                    // *********** 这里可以统一处理错误码，弹出提示信息 ***********
                    let resObject = try? response.mapJSON()
                    let responseObject = JSON(resObject ?? "")
                    let dd = try? JSON(data: response.data)
                    let code = responseObject["code"].intValue
                    let msg = String(describing: responseObject["msg"])
                    switch (code) {
                    case 200 :
                        // 数据返回正确
                        success(responseObject)
                    case 401:
                        // 请重新登录
                        failure!(code,msg)
                        alertLogin(msg)
                    default:
                        // 其他错误
                        failureHandle(failure: failure, stateCode: code, message: msg)
                    }
                }
            case let .failure(error):
                let statusCode = error.response?.statusCode ?? 1000
                let message = "请求出错，错误码：" + String(statusCode)
                //                JhAllLog(message)
                failureHandle(failure: failure, stateCode: statusCode, message: error.errorDescription ?? message)
            }
        }
        
        // 错误处理 - 弹出错误信息
        func failureHandle(failure: ((Int?, String) ->Void)? , stateCode: Int?, message: String) {
            //            Alert.show(type: .error, text: message)
            failure?(stateCode ,message)
        }
        
        // 登录弹窗 - 弹出是否需要登录的窗口
        func alertLogin(_ title: String?) {
            // TODO: 跳转到登录页的操作：
        }
        
    }
    
    // MARK: - 打印日志
    static let networkLoggerPlugin = NetworkLoggerPlugin(verbose: true, cURL: true, requestDataFormatter: { data -> String in
        return String(data: data, encoding: .utf8) ?? ""
    }) { data -> (Data) in
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return prettyData
        } catch {
            return data
        }
    }
}



//
//  NetworkManagerNew.swift
//  SwiftDemo
//
//  Created by sam   on 2020/4/14.
//  Copyright © 2020 sam  . All rights reserved.
//

import UIKit
import Moya
import Alamofire
import SwiftyJSON

class RequestHandler {
    
    // 成功数据回调
    typealias successCallBack = ((Data)) -> (Void)
    // 失败的回调
    typealias failedCallBack = ((String) -> (Void))
    // 网络错误回调
    typealias errorCallBack = (() -> (Void))
    
    //
    static func request(_ target: RequestAPI, completion: @escaping successCallBack) {
        request(target, completion: completion, failed: nil)
    }

    static func request(_ target: RequestAPI, completion: @escaping successCallBack, failed: failedCallBack?) {
        request(target, completion: completion, failed: failed, errorCallBack: nil)
    }

    static func request(_ target: RequestAPI, completion: @escaping successCallBack, failed: failedCallBack?, errorCallBack: errorCallBack?) {
        request(target, completion: completion, falied: failed, errorCallBack: errorCallBack)
    }
    
    
    @discardableResult
    static func request(_ target: RequestAPI, completion: @escaping successCallBack, falied: failedCallBack?, errorCallBack: errorCallBack?) -> Cancellable? {
        if !RequestUtil.NetworkReachable {
            
            return nil
        }
        
        let provider = MoyaProvider<RequestAPI>(endpointClosure: RequestUtil.customEndPointClosure, requestClosure: RequestUtil.requestClosure, plugins: [RequestUtil.networkPlugin,  RequestHandlingPlugin(),RequestUtil.networkLoggerPlugin], trackInflights: false)
        return provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    print(response)
//                    JSONSerialization.jsonObject(with: response.data)
//                    let res = String(data: response.data, encoding: .utf8);
//                    let jsonData = try JSON(data: response.data)
                    completion(response.data)
                    //print(jsonData)
                    //               这里的completion和failed判断条件依据不同项目来做，为演示demo我把判断条件注释了，直接返回completion。
                    
                    //completion(String(data: response.data, encoding: String.Encoding.utf8)!)
                    
                    //print("flag不为1000 HUD显示后台返回message"+"\(jsonData[RESULT_MESSAGE].stringValue)")
                    
                    //                if jsonData[RESULT_CODE].stringValue == "1000"{
                    //                    completion(String(data: response.data, encoding: String.Encoding.utf8)!)
                    //                }else{
                    //                    failed?(String(data: response.data, encoding: String.Encoding.utf8)!)
                    //                }
                    
                } catch {
                    falied?("sd")
                }
            case let .failure(error):
                print("网络连接失败\(error)")
                errorCallBack?()
            }
        };
        
    }
    
    // 登录弹窗 - 弹出是否需要登录的窗口
    func alertLogin(_ title: String?) {
        // TODO: 跳转到登录页的操作：
    }
    
    /*   设置ssl
     let policies: [String: ServerTrustPolicy] = [
     "example.com": .pinPublicKeys(
     publicKeys: ServerTrustPolicy.publicKeysInBundle(),
     validateCertificateChain: true,
     validateHost: true
     )
     ]
     */
    
    // 用Moya默认的Manager还是Alamofire的Manager看实际需求。HTTPS就要手动实现Manager了
    //private public func defaultAlamofireManager() -> Manager {
    //
    //    let configuration = URLSessionConfiguration.default
    //
    //    configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
    //
    //    let policies: [String: ServerTrustPolicy] = [
    //        "ap.grtstar.cn": .disableEvaluation
    //    ]
    //    let manager = Alamofire.SessionManager(configuration: configuration,serverTrustPolicyManager: ServerTrustPolicyManager(policies: policies))
    //
    //    manager.startRequestsImmediately = false
    //
    //    return manager
    //}
    
    
}



