//
//  TweetViewModel.swift
//  TwitterCloneAdamKramar
//
//  Created by Adam Kramar on 03/08/2020.
//  Copyright © 2020 Adam Kramar. All rights reserved.
//

import UIKit

struct TweetViewModel {

    let tweet: Tweet
    let user: User
    
    var profileImageUrl: URL? {
        return user.profileImageUrl
    }
    
    var ts: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .month]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: tweet.ts, to: now) ?? "0s"
    }
    
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullname,
                                              attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        title.append(NSAttributedString(string: " @\(user.username)",
            attributes: [.font: UIFont.systemFont(ofSize: 14),
                         .foregroundColor: UIColor.lightGray]))
        
        title.append(NSAttributedString(string: " ・ \(ts)",
            attributes:  [.font: UIFont.systemFont(ofSize: 14),
                          .foregroundColor: UIColor.lightGray]))
        
        return title
    }
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
}
