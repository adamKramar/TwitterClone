//
//  Tweet.swift
//  TwitterCloneAdamKramar
//
//  Created by Adam Kramar on 03/08/2020.
//  Copyright © 2020 Adam Kramar. All rights reserved.
//

import Foundation

struct Tweet {
    let caption: String
    let tweetID: String
    let uid: String
    let likes: Int
    let retweetCount: Int
    let user: User
    var ts: Date!
    
    init(user: User, tweetID: String, dictionary: [String: Any]) {
        self.tweetID = tweetID
        self.user = user
        
        self.caption = dictionary[K.DB.F_CAPTION] as? String ?? ""
        self.uid = dictionary[K.DB.F_UID] as? String ?? ""
        self.likes = dictionary[K.DB.F_LIKES] as? Int ?? 0
        self.retweetCount = dictionary[K.DB.F_RETWEETS] as? Int ?? 0
        
        if let ts = dictionary[K.DB.F_TIMESTAMP] as? Double {
            self.ts = Date(timeIntervalSince1970: ts)
        }
    }
}
