//
//  UserService.swift
//  TwitterCloneAdamKramar
//
//  Created by Adam Kramar on 21/07/2020.
//  Copyright © 2020 Adam Kramar. All rights reserved.
//

import Firebase

typealias DatabaseCompletition = ((Error?, DatabaseReference) -> ())

struct UserService {
    
    static let shared = UserService()
    
    func fetchUser(uid: String, completiton: @escaping(User) -> ()) {
        K.REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            let user = User(withId: uid, userInfo: dictionary)
            completiton(user)
        }
    }
    
    func fetchUsers(completiton: @escaping([User]) -> ()) {
        var users = [User]()
        K.REF_USERS.observe(.childAdded) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            let uid = snapshot.key
            let user = User(withId: uid, userInfo: dictionary)
            users.append(user)
            completiton(users)
        }
    }
    
    func followUser(uid: String, completiton: @escaping(DatabaseCompletition)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        K.REF_FOLLOWING.child(currentUid).updateChildValues([uid: 1]) { (error, ref) in
            K.REF_FOLLOWERS.child(uid).updateChildValues([currentUid: 1], withCompletionBlock: completiton)
        }
    }
    
    func unFollowUser(uid: String, completiton: @escaping(DatabaseCompletition)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        K.REF_FOLLOWING.child(currentUid).child(uid).removeValue { (error, ref) in
            K.REF_FOLLOWERS.child(uid).child(currentUid).removeValue(completionBlock: completiton)
        }
        
    }
    
    func checkIfUserIsFollow(uid: String, completition: @escaping(Bool) -> ()) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        K.REF_FOLLOWING.child(currentUid).child(uid).observeSingleEvent(of: .value) { (snapshot) in
            completition(snapshot.exists())
        }
        
    }
    
    func fetchUserStats(uid: String, completition: @escaping(UserRelationStats) -> ()) {
        K.REF_FOLLOWERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            let followers = snapshot.children.allObjects.count
            K.REF_FOLLOWING.child(uid).observeSingleEvent(of: .value) { (snapshot) in
                let following = snapshot.children.allObjects.count
                let stats = UserRelationStats(followers: followers, following: following)
                completition(stats)
            }
        }
    }
    
}
