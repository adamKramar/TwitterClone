//
//  ProfileHeader.swift
//  TwitterCloneAdamKramar
//
//  Created by Adam Kramar on 03/08/2020.
//  Copyright © 2020 Adam Kramar. All rights reserved.
//

import UIKit
import SnapKit

class ProfileHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.top.equalTo(view.snp.top).offset(42)
            make.left.equalTo(view.snp.left).offset(16)
        }
        
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_white_24dp").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleBackButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 4
        
        return iv
    }()
    
    private lazy var editProfileFollowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.layer.borderColor = UIColor.twitterBlue.cgColor
        button.layer.borderWidth = 1.25
        button.setTitleColor(.twitterBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleEditProfileFollowButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Full name"
          
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.text = "@username"
        
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 3
        label.text = "Random bio text 123 auto pes macka strom bla bla bla."
        
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.height.equalTo(108)
            make.top.left.right.equalTo(0)
        }
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(80)
            make.top.equalTo(containerView.snp.bottom).inset(24)
            make.left.equalTo(8)
        }
        profileImageView.layer.cornerRadius = 80 / 2
        
        addSubview(editProfileFollowButton)
        editProfileFollowButton.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(36)
            make.top.equalTo(containerView.snp.bottom).offset(12)
            make.right.equalTo(-12)
        }
        editProfileFollowButton.layer.cornerRadius = 36 / 2
        
        let userInfoStack = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel, bioLabel])
        userInfoStack.axis = .vertical
        userInfoStack.distribution = .fillProportionally
        userInfoStack.spacing = 4
        addSubview(userInfoStack)
        userInfoStack.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.bottomMargin).offset(8)
            make.right.equalTo(-12)
            make.left.equalTo(12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Handlers
    
    @objc func handleBackButtonPressed() {
        
    }
    
    @objc func handleEditProfileFollowButtonPressed() {
        
    }
}
