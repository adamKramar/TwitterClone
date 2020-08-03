//
//  UserService.swift
//  TwitterCloneAdamKramar
//
//  Created by Adam Kramar on 21/07/2020.
//  Copyright © 2020 Adam Kramar. All rights reserved.
//

import Firebase

struct UserService {
    
    static let shared = UserService()
    
    func fetchUser(uid: String, completiton: @escaping(User) -> ()) {
        K.REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            let user = User(withId: uid, userInfo: dictionary)
            completiton(user)
        }
    }
    
}
