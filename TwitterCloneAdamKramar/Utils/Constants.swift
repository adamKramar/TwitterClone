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
    
    static let STORAGE_REF = Storage.storage().reference()
    static let STORAGE_PROFILE_IMAGES = K.STORAGE_REF.child("profile_images")
    
    struct DB {
        static let F_EMAIL = "email"
        static let F_USERNAME = "username"
        static let F_FULLNAME = "fullname"
        static let F_PROFILE_IMAGE = "profileImageUrl"
    }
}
