//
//  VideoPlayer.swift
//  Alamofire
//
//  Created by Apple on 10/20/23.
//

import Foundation

class VideoPlayerService {
    
    typealias VideoPlayerServiceCompleteBlock = ((VideoModel) -> (Void))
    var completeBlock: VideoPlayerServiceCompleteBlock?
    
    static func requestVideoInfo(flag: Int?, id: Int?, completion: @escaping VideoPlayerServiceCompleteBlock) {
        RequestHandler.request(RequestAPI.videoPlayerRequest(flag, id)) { data in
            let response_str = String(data: data, encoding: .utf8)!
            
            let startIndex = response_str.index(response_str.startIndex, offsetBy: paramJquery().count + 1)
            let endIndex = response_str.index(response_str.endIndex, offsetBy: -2)
            let subStr = String(response_str[startIndex..<endIndex])

            let model = VideoModel.deserialize(from: subStr)

            completion(model!)
        }
    }
    
    static func requestVideoPlayingInfo(_ url: String, completion: @escaping (String) -> Void) {
        RequestHandler.request(RequestAPI.videoPlayerRequestParsePlayingUrl(url)) { data in
            print(data)
            _ = String(data: data, encoding: .utf8)!
            
            let jsonData = try? JSONSerialization.jsonObject(with: data) as? Dictionary<String, Any>

            let url = jsonData!?["url"]
            completion(url as! String)
        }
    }
    
    static func requestVideoPlayingInfo_back(_ url: String, completion: @escaping (String) -> Void) {
        RequestHandler.request(RequestAPI.videoPlayerRequestParsePlayingUrl_back(url)) { data in
            print(data)
            _ = String(data: data, encoding: .utf8)!
            
            let jsonData = try? JSONSerialization.jsonObject(with: data) as? Dictionary<String, Any>

            let url = jsonData!?["url"]
            completion(url as! String)
        }
    }
}
