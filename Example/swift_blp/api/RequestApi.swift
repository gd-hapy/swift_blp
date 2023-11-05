//
//  RequestApi.swift
//  swift_blp
//
//  Created by Apple on 10/19/23.
//  接口管理
//

import Foundation
import Moya
import SVProgressHUD

class APIManager {
    
    static var baseUrl: String = APIManager().list.first!
    static var path: String = ""
    
    let list: [String] = ["https://vip.bljiex.com/",
                           "https://www.pouyun.com/",
                           "https://movie.heheda.top/"]
    
    static var baseUrlWithReferer: String = "https://vip.bljiex.com/"
    
   static func switchBaseUrl() {
       
       var curIndex = APIManager().list.index(of: baseUrl)
       curIndex = (curIndex! + 1) % APIManager().list.count
       baseUrl = APIManager().list[curIndex!]
       SVProgressHUD.setMinimumDismissTimeInterval(2.0)
       SVProgressHUD.showSuccess(withStatus: "已切换到\(baseUrl)")
   }
}

enum  RequestAPI {

    case homeHotSearch
    case homeHotSearchRank
    
    case searchResultRequest(_ word: String)
    
    case videoPlayerRequest(_ flag: Int?, _ id: Int?)
    case videoPlayerRequestParsePlayingUrl(_ url: String)
    case videoPlayerRequestParsePlayingUrl_back(_ url: String)
}



// MARK: - 补全【MoyaConfig 3：配置TargetType协议可以一次性处理的参数】中没有处理的参数
extension RequestAPI: TargetType {

    //0. 基础域名，整个项目只用一个，可以写在MoyaConfig中
    var baseURL: URL {
        switch self {
        case .homeHotSearch:
            return URL(string: "https://www.pouyun.com/")!
        case  .homeHotSearchRank, .searchResultRequest, .videoPlayerRequest:
            return URL(string: APIManager.baseUrl)!
        case .videoPlayerRequestParsePlayingUrl:
//            "https://json.vipjx.cnow.eu.org/?url="
            return URL(string: "https://json.2s0.cn:5678/home/api?type=ys&uid=1359749&key=hinotvxHIKMNSXY034&url=")!
            
        https://json.vipjx.cnow.eu.org/?url=https://v.youku.com/v_show/id_XNTk4MTEyMjA5Mg==.html
        default:
            return URL(string: "")!
        }
    }
    

    //1. 每个接口的相对路径
    //请求时的绝对路径是   baseURL + path
    var path: String {
        switch self {
        case .homeHotSearch:
            return "so.php"
//            return "api.php?out=jsonp&wd=%E4%B8%83%E9%BE%99%E7%8F%A0&cb=jQuery182001350803151125013_1697708281001&_=1697708281006"
        case .homeHotSearchRank:
            return ""
        case let .searchResultRequest(word):
            let dd = "api.php?out=jsonp&wd=\(word)&cb=\(paramJquery())&_=\(timeStamp())"//"&cb=jQuery18208719634389386499_1697830215202&_=1697830215246"
            
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
    var method: Moya.Method {
        return .get
//        switch self {
//        case .homeHotSearch:
//            return .get
//        case .homeHotSearchRank:
//            return .get
//        case .searchResultRequest:
//            return .get
//        case .videoPlayerRequest:
//            return .get
//        case .videoPlayerRequestParsePlayingUrl:
//            return .get
//        }
    }

    //3. Task是一个枚举值，根据后台需要的数据，选择不同的http task。
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
