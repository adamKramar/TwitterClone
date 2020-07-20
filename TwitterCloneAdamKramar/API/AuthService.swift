//
//  AuthService.swift
//  TwitterCloneAdamKramar
//
//  Created by Adam Kramar on 20/07/2020.
//  Copyright © 2020 Adam Kramar. All rights reserved.
//

import UIKit
import Firebase

struct AuthCredetials {
    
    let email: String
    let password: String
    let username: String
    let fullname: String
    let profileImage: UIImage
}


struct AuthService {
    
    static let shared = AuthService()
    
    func registerUser(credentials c: AuthCredetials, completition: @escaping(Error?, DatabaseReference?) -> ()) {
        
        guard let imageData = c.profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = K.STORAGE_PROFILE_IMAGES.child(filename)
        
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            if let e = error { completition(e, nil) }
            storageRef.downloadURL { (url, error) in
                if let e = error { completition(e, nil) }
                guard let profileImageUrl = url?.absoluteString else { return }
                Auth.auth().createUser(withEmail: c.email, password: c.password) { (result, error) in
                    guard let uid = result?.user.uid else { return }
                    
                    let values = [K.DB.F_EMAIL: c.email,
                                  K.DB.F_USERNAME: c.username,
                                  K.DB.F_FULLNAME: c.fullname,
                                  K.DB.F_PROFILE_IMAGE: profileImageUrl]
                    
                    K.REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completition)
                }
            }
        }
    }
    
    func loginUser(withEmail email: String, password: String, completition: AuthDataResultCallback?) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: completition)
    }
}
