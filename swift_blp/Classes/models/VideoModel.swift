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
}
