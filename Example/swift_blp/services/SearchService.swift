//
//  SearchService.swift
//  Alamofire
//
//  Created by Apple on 10/20/23.
//

import Foundation

class SearchService {
    
    typealias SearchServiceCompleteBlock  = ((SearchModel) -> (Void))
    var completeBlock: SearchServiceCompleteBlock?
    
    static func requestSearch(_ word: String, completion: @escaping SearchServiceCompleteBlock) {
        
        
        RequestHandler.request(RequestAPI.searchResultRequest(word)) { data in
            let response_str = String(data: data, encoding: .utf8)!
            
            
            let startIndex = response_str.index(response_str.startIndex, offsetBy: paramJquery().count + 1)
            let endIndex = response_str.index(response_str.endIndex, offsetBy: -2)
            let subStr = String(response_str[startIndex..<endIndex])

            let model = SearchModel.deserialize(from: subStr)

            completion(model!)
        }
    }
    
}
