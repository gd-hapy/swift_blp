//
//  HomeRequestService.swift
//  Alamofire
//
//  Created by Apple on 10/20/23.
//

import Foundation
import UIKit


class HomeService:NSObject {
    
    typealias serviceCompleteBlock = (() -> (Void))
    var completeBlock: serviceCompleteBlock?
    
    static func requestHomeData(completion: @escaping serviceCompleteBlock) {
        
        let hotSearchArr = UserDefaults.standard.value(forKey: kHotSearchKey)
        let top100Arr = UserDefaults.standard.value(forKey: kHotSearchTop100Key)
        if ((currentDay() % 10 != 0) && ((hotSearchArr != nil && (hotSearchArr as! Array<Any>).count > 0) || top100Arr != nil && (top100Arr as! Array<Any>).count > 0)) {
            completion()
            return
        }
        // request
        RequestHandler.request(RequestAPI.homeHotSearch) { data in
            let response = String(data: data, encoding: .utf8)
            
            handleHotSearch(response!)
            handleHotSearchTop100(response!)
        }
    }
    
    // 热门搜索
    static func handleHotSearch(_ response: String) {
        let pattern = ">[\\u4e00-\\u9fa5].*</a>"
        //        if let regex = try? NSRegularExpression(pattern: pattern1) {
        //           let matches = regex.matches(in: response, range: NSRange(response.startIndex..., in: response))
        //           let matchStrings = matches.map { match in
        //              String(response[Range(match.range, in: response)!])
        //           }
        //           print("Input string: \(response)")
        //           print("Match strings: \(matchStrings)")
        //        }
        let res = regexGetSub(pattern: pattern, str: response, start: 1, lenght: 5)
        var index = res.firstIndex(of: "更多...")  ?? 5
        index += 1
        let sub = res.c_prefix(index)
        
        UserDefaults.standard.set(sub, forKey: kHotSearchKey)
    }
    
    // 搜索排行榜
    static func handleHotSearchTop100(_ response: String) {
        let pattern = "title=\"[\\u4e00-\\u9fa5].*"
        let res = regexGetSub(pattern: pattern, str: response, start: 7, lenght: 9)
        UserDefaults.standard.set(res, forKey: kHotSearchTop100Key)
    }
    
    
    /**
     正则表达式获取符合规则的字符串
     - parameter pattern: 一个字符串类型的正则表达式
     - parameter str: 需要比较判断的对象
     - imports: 这里子串的获取先转话为NSString的[以后处理结果含NS的还是可以转换为NS前缀的方便]
     - returns: 返回目的字符串结果值数组(目前将String转换为NSString获得子串方法较为容易)
     - warning: 注意匹配到结果的话就会返回true，没有匹配到结果就会返回false
     */
    static func regexGetSub(pattern:String, str:String, start: Int = 0, lenght:Int = 0) -> [String] {
        var subStr = [String]()
        let regex = try! NSRegularExpression(pattern: pattern, options:[NSRegularExpression.Options.caseInsensitive])
        let results = regex.matches(in: str, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, str.count))
        //解析出子串
        for  rst in results {
            let nsStr = str as  NSString  //可以方便通过range获取子串
            subStr.append(nsStr.substring(with: NSRange(location: rst.range.location + start, length: rst.range.length-lenght)))
        }
        return subStr
    }
}
