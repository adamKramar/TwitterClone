//
//  UploadTweetViewModel.swift
//  TwitterCloneAdamKramar
//
//  Created by Adam Kramar on 19/08/2020.
//  Copyright © 2020 Adam Kramar. All rights reserved.
//

import UIKit

enum UploadTweetConfiguration {
    case tweet
    case reply(Tweet)
}

struct UploadTweetViewModel {
    
    let actionButtonTitle: String
    let placeholderString: String
    var shouldShowReply: Bool
    var replyText: String?
    
    init(configuration: UploadTweetConfiguration) {
        switch configuration {
        case .tweet:
            actionButtonTitle = "Tweet"
            placeholderString = "What's happening?"
            shouldShowReply = false
        case .reply(let tweet):
            actionButtonTitle = "Reply"
            placeholderString = "Tweet your reply"
            shouldShowReply = true
            replyText = "Replying to @\(tweet.user.username)"
        }
    }
}
