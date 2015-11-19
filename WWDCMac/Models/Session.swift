//
//  Session.swift
//  WWDCMac
//
//  Created by 刘铎 on 15/11/18.
//  Copyright © 2015年 刘铎. All rights reserved.
//

import Cocoa
import ObjectMapper

class Session: Mappable {
    
    var order_id: Int?
    var conference: String?
    var session_id: String?
    var title: String?
    var description: String?
    var video_url: String?
    var platform: String?

    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        order_id <- map["order_id"]
        conference <- map["conference"]
        session_id <- map["session_id"]
        title <- map["title"]
        description <- map["description"]
        video_url <- map["video_url"]
        platform <- map["platform"]
    }
    
}
