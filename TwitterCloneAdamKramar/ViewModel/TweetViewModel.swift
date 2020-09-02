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
    
    var headerTs: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a - dd/MM/yyyy"
        
        return formatter.string(from: tweet.ts)
    }
    
    var usernameText: String {
        return "@\(user.username)"
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
    
    var retweetAttributedString: NSAttributedString {
        return Utilities().attributedText(withValue: tweet.retweetCount, text: " Retweets")
    }
    
    var likesAttributedString: NSAttributedString {
       return Utilities().attributedText(withValue: tweet.likes, text: " Likes")
    }
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
    
    func size(width: CGFloat) -> CGSize {
        let measurmentLabel = UILabel()
        measurmentLabel.text = tweet.caption
        measurmentLabel.numberOfLines = 0
        measurmentLabel.lineBreakMode = .byWordWrapping
        measurmentLabel.translatesAutoresizingMaskIntoConstraints = false
        measurmentLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        let size = measurmentLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        return size
    }
}
