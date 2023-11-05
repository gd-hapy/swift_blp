//
//  dd.swift
//  swift_blp
//
//  Created by Apple on 10/21/23.
//

import Foundation
import HandyJSON
import SwiftyJSON

struct SearchModel: HandyJSON {
    var success: Int?
    var code: Int?
    var title: String?
    var info:[InfoModel]?
}

struct InfoModel: HandyJSON {
    var flag: Int?
    var flag_name: String?
    var from: String?
    var type: String?
    var id: Int?
    var title: String?
    var img: String?
}
