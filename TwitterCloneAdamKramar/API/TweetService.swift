//
//  TweetService.swift
//  TwitterCloneAdamKramar
//
//  Created by Adam Kramar on 21/07/2020.
//  Copyright © 2020 Adam Kramar. All rights reserved.
//

import Firebase

struct TweetService {
    
    static let shared = TweetService()
    
    func uploadTweet(caption: String, completition: @escaping(Error?, DatabaseReference) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let ts = Int(NSDate().timeIntervalSince1970)
        let values = [K.DB.F_UID: uid,
                      K.DB.F_TIMESTAMP: ts,
                      K.DB.F_LIKES: 0,
                      K.DB.F_RETWEETS: 0,
                      K.DB.F_CAPTION: caption] as [String: Any]
        
        K.REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completition)
    }
    
    func fetchTweets(completition: @escaping([Tweet]) -> ()) {
        var tweets = [Tweet]()
        
        K.REF_TWEETS.observe(.childAdded) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            guard let uid = dictionary[K.DB.F_UID] as? String else { return }
            let tweetID = snapshot.key
            
            UserService.shared.fetchUser(uid: uid) { (user) in
                let tweet = Tweet(user: user ,tweetID: tweetID, dictionary: dictionary)
                tweets.append(tweet)
                completition(tweets)
            }
        }
    }
}
