//
//  ProfileHeader.swift
//  TwitterCloneAdamKramar
//
//  Created by Adam Kramar on 03/08/2020.
//  Copyright © 2020 Adam Kramar. All rights reserved.
//

import UIKit
import SnapKit

protocol ProfileHeaderDelegate: class {
    
    func didTapBackButton(_ header: ProfileHeader)
    func didTapEditProfileFollow(_ header: ProfileHeader)
}

class ProfileHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    weak var delegate: ProfileHeaderDelegate?
    
    var user: User? {
        didSet {
            configure()
        }
    }
    
    private let filterBar = ProfileFilterView()
    
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
          
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 3
        label.text = "Random bio text 123 auto pes macka strom bla bla bla."
        
        return label
    }()
    
    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        
        return view
    }()
    
    private let followingLabel: UILabel = {
        let label = UILabel()
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowingPressed))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(followTap)
        
        return label
    }()
    
    private let followersLabel: UILabel = {
        let label = UILabel()
        let followersTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowersPressed))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(followersTap)
        
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
        
        let userFollowStack = UIStackView(arrangedSubviews: [followingLabel, followersLabel])
        userFollowStack.axis = .horizontal
        userFollowStack.spacing = 8
        userFollowStack.distribution = .fillEqually
        addSubview(userFollowStack)
        userFollowStack.snp.makeConstraints { (make) in
            make.top.equalTo(userInfoStack.snp.bottom).offset(8)
            make.left.equalTo(12)
        }
        
        addSubview(filterBar)
        filterBar.delegate = self
        filterBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(40)
        }
        
        addSubview(underlineView)
        underlineView.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(0)
            make.height.equalTo(2)
            make.width.equalTo(frame.width/CGFloat(ProfileFilterOptions.allCases.count))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Handlers
    
    @objc func handleBackButtonPressed() {
        delegate?.didTapBackButton(self)
    }
    
    @objc func handleEditProfileFollowButtonPressed() {
        delegate?.didTapEditProfileFollow(self)
    }
    
    @objc func handleFollowingPressed() {
        
    }
    
    @objc func handleFollowersPressed() {
        
    }
    
    // MARK: - Helpers
    
    private func configure() {
        guard let user = user else { return }
        let viewModel = ProfileHeaderViewModel(user: user)
        
        profileImageView.sd_setImage(with: user.profileImageUrl)
        
        editProfileFollowButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        
        fullnameLabel.text = user.fullname
        usernameLabel.text = viewModel.usernameString
        
        followingLabel.attributedText = viewModel.followingString
        followersLabel.attributedText = viewModel.followersString
    }
}

// MARK: - ProfileFilterViewDelegate

extension ProfileHeader: ProfileFilterViewDelegate {
    
    func animateUnderlineView(_ view: ProfileFilterView, didSelect indexPath: IndexPath) {
        guard let cell = view.collectionView.cellForItem(at: indexPath) as? ProfileFilterCell else { return }
        
        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.underlineView.frame.origin.x = xPosition
        }
    }
}
