//
//  Constants.swift
//  TwitterCloneAdamKramar
//
//  Created by Adam Kramar on 20/07/2020.
//  Copyright © 2020 Adam Kramar. All rights reserved.
//

import Firebase

struct K {
    
    static let DB_REF = Database.database().reference()
    static let REF_USERS = K.DB_REF.child("users")
    static let REF_TWEETS = K.DB_REF.child("tweets")
    static let REF_USER_TWEETS = K.DB_REF.child("user-tweets")
    static let REF_FOLLOWERS = K.DB_REF.child("user-followers")
    static let REF_FOLLOWING = K.DB_REF.child("user-following")
    
    static let STORAGE_REF = Storage.storage().reference()
    static let STORAGE_PROFILE_IMAGES = K.STORAGE_REF.child("profile_images")
    
    struct ID {
        static let TWEET_CELL_ID = "tweetCellID"
        static let PROFILE_FILTER_CELL_ID = "profileFilterCellID"
        static let PROFILE_HEADER_ID = "profileHeaderID"
        static let USER_CELL_ID = "userCellID"
    }
    
    struct DB {
        //register/login
        static let F_EMAIL = "email"
        static let F_USERNAME = "username"
        static let F_FULLNAME = "fullname"
        static let F_PROFILE_IMAGE = "profileImageUrl"
        //tweet
        static let F_UID = "uid"
        static let F_TIMESTAMP = "timestamp"
        static let F_LIKES = "likes"
        static let F_RETWEETS = "retweets"
        static let F_CAPTION = "caption"
    }
    
    struct IMAGE {
        //MainTabBar
        static let FEED_ICON = "home_unselected"
        static let EXPLORE_ICON = "search_unselected"
        static let NOTIFICATINS_ICON = "like_unselected"
        static let CONVERSATIONS_ICON = "ic_mail_outline_white_2x-1"
        static let NEW_TWEET = "new_tweet"
        //Feed
        static let TWITTER_LOGO = "twitter_logo_blue"
        static let COMMENT_ICON = "comment"
        static let RETWEET_ICON = "retweet"
        static let LIKE_ICON = "like"
        static let SHARE_ICON = "share"
    }
    
}
