//
//  RequestApi.swift
//  swift_blp
//
//  Created by Apple on 10/19/23.
//  接口管理
//

import Foundation
import Moya

/// 基础域名
let kBaseURL = "https://www.fastmock.site/mock/1010b262a743f0b06c565c7a31ee9739/root"

enum  RequestAPI {

    case homeHotSearch
    case homeHotSearchRank
    
    case searchResultRequest(_ word: String)
    
    case videoPlayerRequest(_ flag: Int?, _ id: Int?)
    case videoPlayerRequestParsePlayingUrl(_ url: String)
}






// MARK: - 补全【MoyaConfig 3：配置TargetType协议可以一次性处理的参数】中没有处理的参数
extension RequestAPI: TargetType {

    //0. 基础域名，整个项目只用一个，可以写在MoyaConfig中
//    var baseURL: URL {
//        switch self {
//        case .login:
//            return URL(string:kBaseURL)!
//        default:
//            return URL(string:kBaseURL)!
//        }
//    }
//    https://movie.heheda.top/api.php?out=jsonp&wd=%E4%B8%83%E9%BE%99%E7%8F%A0&cb=jQuery182001350803151125013_1697708281001&_=1697708281006
    var baseURL: URL {
        switch self {
        case .homeHotSearch:
            return URL(string: "https://www.pouyun.com/")!
        case .homeHotSearchRank:
            return URL(string: "")!
        case .searchResultRequest:
            return URL(string: "https://www.pouyun.com/")!
        case .videoPlayerRequest:
            return URL(string: "https://www.pouyun.com/")!
        case .videoPlayerRequestParsePlayingUrl:
            return URL(string: "https://json.2s0.cn:5678/home/api?type=ys&uid=812432&key=cdjmtvxyBDJKOTV027&url=")!
        default:
            return URL(string: "")!
        }
    }
    

    //1. 每个接口的相对路径
    //请求时的绝对路径是   baseURL + path
    
//    var path: String {
//        switch self {
//        case .login:
//            return "/login"
//        case .getPageList:
//            return "/mock/pages"
//        case .getGroupPageList:
//            return "/mock/groupPages"
//        case .getContact:
//            return "/mock/contacts"
//        case .getWxMotionTops:
//            return "/mock/wxMotionTops"
//        case .getSimpleArrDic:
//            return "/getSimpleArrDic"
//        case let .other1(p1, p2, _, _):
//            return "/list?id=\(p1)&page=\(p2)"
//        case .other2:
//            return ""
//        }
//    }

    var path: String {
        switch self {
        case .homeHotSearch:
            return "so.php"
//            return "api.php?out=jsonp&wd=%E4%B8%83%E9%BE%99%E7%8F%A0&cb=jQuery182001350803151125013_1697708281001&_=1697708281006"
        case .homeHotSearchRank:
            return ""
        case let .searchResultRequest(word):
            let dd = "api.php?out=jsonp&wd=" +  word + "&cb=" + paramJquery() + "&_=" + timeStamp()//"&cb=jQuery18208719634389386499_1697830215202&_=1697830215246"
            
            let fuck = dd.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

            
            return fuck!
        case let .videoPlayerRequest(flag, id):
            let dd = "api.php?out=jsonp&flag=\(Int(flag!))&id=\(Int(id!))&cb=" + paramJquery() + "&_=" + timeStamp()
            //jQuery182002313945027965092_1697895735454&_=1697895735921"
            return dd
        case let .videoPlayerRequestParsePlayingUrl(url):
            return url
        default:
            return ""
        }
    }
    //2. 每个接口要使用的请求方式
//    var method: Moya.Method {
//        switch self {
//        case
//                .getPageList,
//                .getGroupPageList,
//                .other1,
//                .other2:
//            return .get
//        case
//                .getContact,
//                .getWxMotionTops,
//                .getSimpleArrDic,
//                .login:
//            return .post
//        }
//    }
    var method: Moya.Method {
        switch self {
        case .homeHotSearch:
            return .get
        case .homeHotSearchRank:
            return .get
        case .searchResultRequest:
            return .get
        case .videoPlayerRequest:
            return .get
        case .videoPlayerRequestParsePlayingUrl:
            return .get
        }
    }

    //3. Task是一个枚举值，根据后台需要的数据，选择不同的http task。
//    var task: Task {
//        var params: [String: Any] = [:]
//        switch self {
//        case .login:
//            return .requestPlain
//        case let .getPageList(page):
//            params["page"] = page
//            params["limit"] = 15
//            params["maxCount"] = 100
//        case let .other1(_, _, p3, p4):
//            params["p3"] = p3
//            params["p4"] = p4
//        default:
//            //不需要传参数的接口走这里
//            return .requestPlain
//        }
//        return .requestParameters(parameters: params, encoding: URLEncoding.default)
//    }

    var task: Task {
        var params: [String: Any] = [:]
        switch self {
        case .homeHotSearch:
            return .requestPlain
        case .homeHotSearchRank:
            return .requestPlain
        case .searchResultRequest:
            return .requestPlain
        case .videoPlayerRequest:
            return .requestPlain
        case .videoPlayerRequestParsePlayingUrl:
            return .requestPlain
        }
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
}



//
//  WebAPIS.swift
//  SwiftDemo
//
//  Created by sam   on 2020/4/14.
//  Copyright © 2020 sam  . All rights reserved.
//https://github.com/Moya/Moya/blob/master/docs_CN/Examples/Basic.md

import Foundation
import Moya


/// 定义基础域名
//let Moya_baseURL = "http://RequestAPI.liwushuo.com/"
let Moya_baseURL = "https://go.apipost.cn/"//"https://www.pouyun.com/"

enum WebAPI{
    
    case getPhotoList//获取图片列表

    case updateAPi(parameters:[String:Any])
    case register(email:String,password:String)
    case uploadHeadImage(parameters: [String:Any],imageDate:Data)//上传用户头像
}

extension WebAPI : TargetType {
    
    var baseURL: URL {
        switch self {
        case .getPhotoList:
            return URL.init(string:(Moya_baseURL))!
        default:
            return URL.init(string:(Moya_baseURL))!
        }
    }
    
    var path: String {
        
        switch self {
            
        case .getPhotoList:
//            return "v2/channels/104/items?ad=2&gender=2&generation=2&limit=20&offset=0"
//            return "api.php?out=jsonp&wd=%E9%95%BF%E9%A3%8E%E6%B8%A1&cb=jQuery1820780022325555515_1696072476461&_=1696072476467"
            return "?Query=test"
        case .register:
            return "register"

        case .updateAPi:
            return "versionService.getAppUpdateApi"
            
        case .uploadHeadImage:
            return "/file/user/upload.jhtml"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPhotoList:
            return .get
        default:
            return .post
        }
    }

    //    这个是做单元测试模拟的数据，必须要实现，只在单元测试文件中有作用
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }

    //    该条请API求的方式,把参数之类的传进来
    var task: Task {
//        return .requestParameters(parameters: nil, encoding: JSONArrayEncoding.default)
        switch self {
            
        case .getPhotoList:
            return .requestPlain
            
        case let .register(email, password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
            
        case let .updateAPi(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        //图片上传
        case .uploadHeadImage(let parameters, let imageDate):
            ///name 和fileName 看后台怎么说，   mineType根据文件类型上百度查对应的mineType
            let formData = MultipartFormData(provider: .data(imageDate), name: "file",
                                              fileName: "hangge.png", mimeType: "image/png")
            return .uploadCompositeMultipart([formData], urlParameters: parameters)

        //可选参数https://github.com/Moya/Moya/blob/master/docs_CN/Examples/OptionalParameters.md
        }
    }

    var headers: [String : String]? {
        return ["Content-Type":"application/x-www-form-urlencoded"]
    }
 
}

