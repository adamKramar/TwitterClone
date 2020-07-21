//
//  FeedViewController.swift
//  TwitterCloneAdamKramar
//
//  Created by Adam Kramar on 16/07/2020.
//  Copyright © 2020 Adam Kramar. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class FeedViewController: UIViewController {
    
    // MARK: - Properties
    
    var user: User? {
        didSet {
            configureLeftBarButton()
        }
    }
    
    // MARK: - Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - UI Configuration
    
    func configureUI() {
        
        view.backgroundColor = .white
        let imageView = UIImageView(image: UIImage(named: K.IMAGE.TWITTER_LOGO))
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(44)
        }
        navigationItem.titleView = imageView
    }
    
    func configureLeftBarButton() {
        
        guard let user = user else { return }
        let profileImageView = UIImageView()
        profileImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(32)
        }
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.layer.masksToBounds = true
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    
    // MARK: - Helpers
}
