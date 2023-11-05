//
//  Test.swift
//  swift_blp
//
//  Created by Apple on 10/20/23.
//

import Foundation
import Alamofire
import Moya
import SVProgressHUD

class RequestUtil {
    
    // 网络连接处理
    static var NetworkReachable: Bool {
        get {
            let network = NetworkReachabilityManager()
            return network?.isReachable ?? false
        }
    }
    
    
    
    // 网络请求的基本设置,这里可以拿到是具体的哪个网络请求，可以在这里做一些设置
    static let customEndPointClosure = { (target: RequestAPI) -> Endpoint in
        ///这里把endpoint重新构造一遍主要为了解决网络请求地址里面含有? 时无法解析的bug https://github.com/Moya/Moya/issues/1198
        let url = target.baseURL.absoluteString + target.path
        var task = target.task
        
        /*
         如果需要在每个请求中都添加类似token参数的参数请取消注释下面代码
         👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
         */
        //    let additionalParameters = ["token":"888888"]
        //    let defaultEncoding = URLEncoding.default
        //    switch target.task {
        //        ///在你需要添加的请求方式中做修改就行，不用的case 可以删掉。。
        //    case .requestPlain:
        //        task = .requestParameters(parameters: additionalParameters, encoding: defaultEncoding)
        //    case .requestParameters(var parameters, let encoding):
        //        additionalParameters.forEach { parameters[$0.key] = $0.value }
        //        task = .requestParameters(parameters: parameters, encoding: encoding)
        //    default:
        //        break
        //    }
        /*
         👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆
         如果需要在每个请求中都添加类似token参数的参数请取消注释上面代码
         */
        
        var endpoint = Endpoint(
            url: url,
            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
            method: target.method,
            task: task,
            httpHeaderFields: target.headers
        )
        return endpoint
    }
    
    
    // 网络请求的设置
    static let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
        do {
            var request = try endpoint.urlRequest()
            //设置请求时长
            request.timeoutInterval = 30
            // 打印请求参数
            if let requestData = request.httpBody {
                print("\(request.url!)"+"\n"+"\(request.httpMethod ?? "")"+"发送参数"+"\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")")
            }else{
                print("\(request.url!)"+"\(String(describing: request.httpMethod))")
            }
            done(.success(request))
        } catch {
            done(.failure(MoyaError.underlying(error, nil)))
        }
    }
    
    /// NetworkActivityPlugin插件用来监听网络请求，界面上做相应的展示
    ///但这里我没怎么用这个。。。 loading的逻辑直接放在网络处理里面了
    static let networkPlugin = NetworkActivityPlugin { change, target in
        //targetType 是当前请求的基本信息
        switch(change){
        case .began:
            print("开始请求网络")
            
            SVProgressHUD .setDefaultMaskType(SVProgressHUDMaskType.clear)
            SVProgressHUD .setBackgroundLayerColor(UIColor .blue)
            SVProgressHUD .setDefaultStyle(SVProgressHUDStyle.light)
            SVProgressHUD .setForegroundColor(kThemeColor)
            SVProgressHUD .setDefaultAnimationType(SVProgressHUDAnimationType.flat)
            SVProgressHUD .show(withStatus: "加载中...")
            SVProgressHUD.setMinimumSize(CGSize(width: 100, height: 62))
            SVProgressHUD .setMinimumDismissTimeInterval(20.0)
            
        case .ended:
            print("结束")
            SVProgressHUD.dismiss()
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

