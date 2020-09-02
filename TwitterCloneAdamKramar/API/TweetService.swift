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
    
    func uploadTweet(caption: String, type: UploadTweetConfiguration, completition: @escaping(DatabaseCompletition)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let ts = Int(NSDate().timeIntervalSince1970)
        let values = [K.DB.F_UID: uid,
                      K.DB.F_TIMESTAMP: ts,
                      K.DB.F_LIKES: 0,
                      K.DB.F_RETWEETS: 0,
                      K.DB.F_CAPTION: caption] as [String: Any]
                
        switch type {
        case .tweet:
            K.REF_TWEETS.childByAutoId().updateChildValues(values) { (error, ref) in
                guard let tweetID = ref.key else { return }
                K.REF_USER_TWEETS.child(uid).updateChildValues([tweetID: 1], withCompletionBlock: completition)
            }
        case .reply(let tweet):
            K.REF_TWEET_REPLIES.child(tweet.tweetID).childByAutoId().updateChildValues(values, withCompletionBlock: completition)
        }
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
    
    func fetchTweets(forUser user: User, completition: @escaping([Tweet]) -> ()) {
        
        var tweets = [Tweet]()
        
        K.REF_USER_TWEETS.child(user.uid).observe(.childAdded) { (snapshot) in
            let tweetID = snapshot.key
            K.REF_TWEETS.child(tweetID).observeSingleEvent(of: .value) { (snapshot) in
                guard let dictionary = snapshot.value as? [String: Any] else { return }
                guard let uid = dictionary[K.DB.F_UID] as? String else { return }
                
                UserService.shared.fetchUser(uid: uid) { (user) in
                    let tweet = Tweet(user: user ,tweetID: tweetID, dictionary: dictionary)
                    tweets.append(tweet)
                    completition(tweets)
                }
            }
        }
    }
    
    func fetchReplies(forTweet tweet: Tweet, completition: @escaping([Tweet]) -> ()) {
        
        var tweets = [Tweet]()
        
        K.REF_TWEET_REPLIES.child(tweet.tweetID).observe(.childAdded) { (snapshot) in
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
