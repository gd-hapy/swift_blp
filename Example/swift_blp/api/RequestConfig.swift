//
//  RequestUtil.swift
//  swift_blp
//
//  Created by Apple on 10/19/23.
//  Moya 配置文件
//

import Foundation
import Moya


// MARK: - 1、2需要根据项目进行更改
/**
 1、配置TargetType协议可以一次性处理的参数
 - Todo: 根据自己的需要更改，不能统一处理的移除下面的代码，并在APIManager中实现
 **/
public extension TargetType {
//    // 放到APIManager中了
//    var baseURL: URL {
//        return URL(string: "http://xxxxx")!
//    }
    var headers: [String : String]? {
//        self.baseURL
        if self.baseURL.absoluteString.contains(APIManager.baseUrl) {
//            headers!["referer"] = self.baseURL.absoluteString
            return ["referer": self.baseURL.absoluteString]
        }
        return nil
    }

    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
}

/**
 2、公共参数
 - Todo: 配置公共参数，例如所有接口都需要传token，version，time等，就可以在这里统一处理
 - Note: 接口传参时可以覆盖公共参数。下面的代码只需要更改 【private var commonParams: [String: Any]?】
 **/
extension URLRequest {
    //TODO：处理公共参数
    private var commonParams: [String: Any]? {
        //所有接口的公共参数添加在这里：
        var header = [String:String]()
//            "Content-Type": "application/x-www-form-urlencoded",
//            "Content-type": "application/json;charset=utf-8"
//
//            "systemType": "iOS",
//            "version": "1.0.0",
//            "token": getToken(),
//        ]
//        return header
        // 如果不需要传空
//        url?.absoluteString
//        if String(url).contains(APIManager.baseUrl) {
//
//        }
        
        let referer = "https://" + (url?.host ?? "") + (url?.path ?? "")
        if ((url?.absoluteString.contains(APIManager.baseUrl)) != nil) {
            header["referer"] = referer
//            header[12] = "dd"
            return header
        }
        
                return nil
    }
    
    private func getToken() -> String {
        return "1"
    }
}


//下面的代码不更改
class RequestHandlingPlugin: PluginType {
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var mutateableRequest = request
        return mutateableRequest.appendCommonParams();
    }
}

//下面的代码不更改
extension URLRequest {
    mutating func appendCommonParams() -> URLRequest {
        let request = try? encoded(parameters: commonParams, parameterEncoding: URLEncoding(destination: .queryString))
        assert(request != nil, "append common params failed, please check common params value")
        return request!
    }

    func encoded(parameters: [String: Any]?, parameterEncoding: ParameterEncoding) throws -> URLRequest {
        do {
            return try parameterEncoding.encode(self, with: parameters)
        } catch {
            throw MoyaError.parameterEncoding(error)
        }
    }
}


