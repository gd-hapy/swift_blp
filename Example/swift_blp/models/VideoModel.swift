//
//  sdd.swift
//  swift_blp
//
//  Created by Apple on 10/21/23.
//

import Foundation
import HandyJSON

struct VideoModel: HandyJSON {
    var success: Int?
    var code: Int?
    var url: String?
    var pic: String?
    var title: String?
    var part: Int?
    var type: String?
    var info: [VideoInfoModel]?
}

struct VideoInfoModel: HandyJSON {
    var flag: String?
    var flag_name: String?
    var part: Int?
    var video: [String]?
    var videoModels: [VideoPlayingModel]?
    
    mutating func didFinishMapping() {
        if video != nil && video!.count > 0 {
            var playingArr = [VideoPlayingModel]()
            for item in video! {
                let index = video?.index(of: item)
                if (index == 0) {
                    
                }
                let sub = item.split(separator: "$")
                var playingModel = VideoPlayingModel()
                playingModel.videoName = String(sub[0])
                playingModel.videoUrl = String(sub[1])
                playingModel.videoFullUrl = item
                playingModel.videoPlaying = index == 0
                playingArr.append(playingModel)
            }
            videoModels = playingArr
        }
    }
}


struct VideoPlayingModel: HandyJSON {
    var videoName: String? // 名称 第1集
    var videoUrl: String?  // 视频 url
    var videoFullUrl: String? // 视频最初的url
    var videoParsedVideoUrl: String? // 解析后的url, 如果videoUrl 处理videoUrl后缀是.html后，得到的url
    var videoPlaying: Bool = false
    
    mutating func changePlayingStatus(status: Bool) {
        videoPlaying = status
    }
}
