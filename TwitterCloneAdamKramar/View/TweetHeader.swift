//
//  TweetHeader.swift
//  TwitterCloneAdamKramar
//
//  Created by Adam Kramar on 13/08/2020.
//  Copyright © 2020 Adam Kramar. All rights reserved.
//

import UIKit

class TweetHeader: UICollectionReusableView {
    
    // MARK: - Propertis
    
    var tweet: Tweet? {
        didSet {
            configure()
        }
    }
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfilePictureTapped))
        
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.snp.makeConstraints { (make) in
            make.width.height.equalTo(48)
        }
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .twitterBlue
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
 
        return label
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0

        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left

        return label
    }()
    
    private lazy var opntionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .lightGray
        button.setImage(UIImage(named: K.IMAGE.OPTION_ICON), for: .normal)
        button.addTarget(self, action: #selector(handleOptionTaped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var retweetsLabel = UILabel()
    
    private lazy var likesLabel = UILabel()
    
    private lazy var statsView: UIView = {
        let view = UIView()
        let devider1 = UIView()
        let devider2 = UIView()
        
        devider1.backgroundColor = .systemGroupedBackground
        view.addSubview(devider1)
        devider1.snp.makeConstraints { (make) in
            make.right.equalTo(view.snp.right)
            make.left.equalTo(view.snp.left).offset(8)
            make.top.equalTo(view.snp.top)
            make.height.equalTo(1)
        }
        
        let stack = UIStackView(arrangedSubviews: [retweetsLabel, likesLabel])
        stack.axis = .horizontal
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.centerY.equalTo(view.snp.centerY)
            make.left.equalTo(view.snp.left).offset(16)
        }
        
        devider2.backgroundColor = .systemGroupedBackground
        view.addSubview(devider2)
        devider2.snp.makeConstraints { (make) in
            make.right.equalTo(view.snp.right)
            make.left.equalTo(view.snp.left).offset(8)
            make.bottom.equalTo(view.snp.bottom)
            make.height.equalTo(1)
        }
        
        return view
    }()
    
    private lazy var commentButton: UIButton = {
        let button = Utilities().actionButton(withImageNamed: K.IMAGE.COMMENT_ICON)
        button.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var retweetButton: UIButton = {
        let button = Utilities().actionButton(withImageNamed: K.IMAGE.RETWEET_ICON)
        button.addTarget(self, action: #selector(retweetButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = Utilities().actionButton(withImageNamed: K.IMAGE.LIKE_ICON)
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = Utilities().actionButton(withImageNamed: K.IMAGE.SHARE_ICON)
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lyfecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        let nameStack = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel])
        nameStack.axis = .vertical
        nameStack.spacing = -6
        
        let stack = UIStackView(arrangedSubviews: [profileImageView, nameStack])
        stack.axis = .horizontal
        stack.spacing = 12
        addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.top.left.equalTo(16)
        }
        
        addSubview(captionLabel)
        captionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(stack.snp.bottom).offset(12)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(captionLabel.snp.bottom).offset(20)
            make.left.equalTo(16)
        }
        
        addSubview(opntionButton)
        opntionButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(stack.snp.centerY)
            make.right.equalTo(-8)
        }
        
        addSubview(statsView)
        statsView.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(12)
            make.left.right.equalTo(0)
            make.height.equalTo(40)
        }
        
        let actionStack = UIStackView(arrangedSubviews: [commentButton,
                                                         retweetButton,
                                                         likeButton,
                                                         shareButton])
        actionStack.axis = .horizontal
        actionStack.distribution = .fillEqually
        actionStack.spacing = 72
        addSubview(actionStack)
        actionStack.snp.makeConstraints { (make) in
            make.top.equalTo(statsView.snp.bottom).offset(12)
            make.centerX.equalTo(self)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Handlers
    
    @objc func handleProfilePictureTapped() {
        
    }
    
    @objc func handleOptionTaped() {
        
    }
    
    @objc func commentButtonTapped() {
        
    }
    
    @objc func retweetButtonTapped() {
        
    }
    
    @objc func likeButtonTapped() {
        
    }
    
    @objc func shareButtonTapped() {
        
    }
    
    // MARK: - Helpres
    
    func configure() {
        guard let tweet = tweet else { return }
        let viewModel = TweetViewModel(tweet: tweet)
        
        captionLabel.text = tweet.caption
        fullnameLabel.text = tweet.user.fullname
        usernameLabel.text = viewModel.usernameText
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        dateLabel.text = viewModel.headerTs
        retweetsLabel.attributedText = viewModel.retweetAttributedString
        likesLabel.attributedText = viewModel.likesAttributedString
    }
}
