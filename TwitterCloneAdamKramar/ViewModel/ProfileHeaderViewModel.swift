//
//  ProfileHeaderViewModel.swift
//  TwitterCloneAdamKramar
//
//  Created by Adam Kramar on 06/08/2020.
//  Copyright © 2020 Adam Kramar. All rights reserved.
//

import UIKit

enum ProfileFilterOptions: Int, CaseIterable {
    case tweets = 0
    case replies = 1
    case likes = 2
    
    var description: String {
        switch self {
        case .tweets: return "Tweets"
        case .replies: return "Tweets & Replies"
        case .likes: return "Likes"
        }
    }
}

struct ProfileHeaderViewModel {
    
    private let user: User
    
    var followingString: NSAttributedString? {
        let following = user.stats?.following ?? 0
        return attributedText(withValue: following, text: " following")
    }
    
    var followersString: NSAttributedString? {
        let followers = user.stats?.followers ?? 0
        return attributedText(withValue: followers, text: " followers")
    }
    
    var usernameString: String {
        return "@\(user.username)"
    }
    
    var actionButtonTitle: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        
        if !user.isFollowed && !user.isCurrentUser {
            return "Follow"
        }
        
        if user.isFollowed {
            return "Following"
        }
        return "Loading"
    }
    
    init(user: User) {
        self.user = user
    }
    
    fileprivate func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(value)", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedTitle.append(NSAttributedString(string: text, attributes: [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.lightGray]))
        
        return attributedTitle
    }
}
