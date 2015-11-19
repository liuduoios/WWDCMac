//
//  JSONReader.swift
//  WWDCMac
//
//  Created by 刘铎 on 15/11/18.
//  Copyright © 2015年 刘铎. All rights reserved.
//

import Cocoa
import ObjectMapper

class JSONReader {
    
    static let sharedReader = JSONReader()
    
    var sessions: [Session]!
    
    init() {
        sessions = readAllSessionInfo()
    }
    
    func readAllSessionInfo() -> [Session]? {
        let filePath = NSBundle.mainBundle().pathForResource("videos", ofType: "json")!
        let data = NSData(contentsOfFile: filePath)!
        
        var results = [Session]()
        
        do {
            let allSessions = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0)) as! [[String: AnyObject]]
            for sessionJSON in allSessions {
                let session = Mapper<Session>().map(sessionJSON)!
                results.append(session)
            }
        } catch {
            return nil
        }
        
        return results
    }
    
    func sessionsInYear(year: String) -> [Session] {
        return self.sessions.filter { (session) -> Bool in
            if session.conference! == "\(year)" {
                return true
            } else {
                return false
            }
        }
    }
    
    func techTalkSessions() -> [Session] {
        return self.sessions.filter { (session) -> Bool in
            if session.conference! == "Tech Talks 2013" {
                return true
            } else {
                return false
            }
        }
    }
}
