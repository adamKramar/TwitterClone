//
//  User.swift
//  TwitterCloneAdamKramar
//
//  Created by Adam Kramar on 21/07/2020.
//  Copyright © 2020 Adam Kramar. All rights reserved.
//

import Foundation

struct User {
    let fullname: String
    let email: String
    let username: String
    var profileImageUrl: URL?
    let uid: String
    
    init(withId uid: String, userInfo: [String: AnyObject]) {
        self.uid = uid
        self.email = userInfo[K.DB.F_EMAIL] as? String ?? ""
        self.username = userInfo[K.DB.F_USERNAME] as? String ?? ""
        self.fullname = userInfo[K.DB.F_FULLNAME] as? String ?? ""
        if let profileImgeUrlString = userInfo[K.DB.F_PROFILE_IMAGE] as? String {
            guard let url = URL(string: profileImgeUrlString) else { return }
            self.profileImageUrl = url
        }
    }
}
