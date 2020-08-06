//
//  ProfileHeaderViewModel.swift
//  TwitterCloneAdamKramar
//
//  Created by Adam Kramar on 06/08/2020.
//  Copyright © 2020 Adam Kramar. All rights reserved.
//

import Foundation

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
