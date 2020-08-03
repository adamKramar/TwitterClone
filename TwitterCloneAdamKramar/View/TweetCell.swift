//
//  TweetCell.swift
//  TwitterCloneAdamKramar
//
//  Created by Adam Kramar on 03/08/2020.
//  Copyright © 2020 Adam Kramar. All rights reserved.
//

import UIKit

protocol TweetCellDelegate: class {
    
    func didTapProfileImage(_ cell: TweetCell)
}

class TweetCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    weak var delegate: TweetCellDelegate?
    
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
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var commentButton: UIButton = {
        let button = Utilities().actionButton(withImageNamed: K.IMAGE.COMMENT_ICON)
        button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var retweetButton: UIButton = {
        let button = Utilities().actionButton(withImageNamed: K.IMAGE.RETWEET_ICON)
        button.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = Utilities().actionButton(withImageNamed: K.IMAGE.LIKE_ICON)
        button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = Utilities().actionButton(withImageNamed: K.IMAGE.SHARE_ICON)
        button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        
        return button
    }()
    private let infoLabel = UILabel()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.topMargin.equalTo(8)
            make.leftMargin.equalTo(8)
        }
        
        let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.top)
            make.left.equalTo(profileImageView.snp.right).offset(12)
            make.right.equalTo(-12)
        }
        
        let actionButtonStack = UIStackView(arrangedSubviews: [commentButton,
                                                               retweetButton,
                                                               likeButton,
                                                               shareButton])
        actionButtonStack.axis = .horizontal
        actionButtonStack.spacing = 72
        actionButtonStack.distribution = .fillEqually
        addSubview(actionButtonStack)
        actionButtonStack.snp.makeConstraints { (make) in
            make.bottom.equalTo(-8)
            make.centerX.equalTo(self)
        }
        
        
        let underlineView = UIView()
        underlineView.backgroundColor = .systemGroupedBackground
        addSubview(underlineView)
        underlineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(1)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Handlers
    
    @objc func handleCommentTapped() {
        
    }
    
    @objc func handleRetweetTapped() {
        
    }
    
    @objc func handleLikeTapped() {
        
    }
    
    @objc func handleShareTapped() {
        
    }
    
    @objc func handleProfilePictureTapped() {
        delegate?.didTapProfileImage(self)
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let tweet = tweet else { return }
        let viewModel = TweetViewModel(tweet: tweet)
        captionLabel.text = tweet.caption
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        infoLabel.attributedText = viewModel.userInfoText
    }
}
