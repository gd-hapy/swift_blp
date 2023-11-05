//
//  Request.swift
//  swift_blp
//
//  Created by Apple on 10/19/23.
//  网络请求工具类：Alamofire + Moya + SwiftyJSON
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
                    completion(response.data)
                 
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
