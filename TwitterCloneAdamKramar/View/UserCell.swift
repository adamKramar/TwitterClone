//
//  UserCell.swift
//  TwitterCloneAdamKramar
//
//  Created by Adam Kramar on 13/08/2020.
//  Copyright © 2020 Adam Kramar. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    // MARK: - Properties
    
    var user: User? {
        didSet {
            configure()
        }
    }
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        
        iv.layer.cornerRadius = 40 / 2
        iv.backgroundColor = .twitterBlue
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
        }
        
        return iv
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    // MARK: - Lyfecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(12)
        }
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        stack.axis = .vertical
        stack.spacing = 2
        addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.left.equalTo(profileImageView.snp.right).offset(12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let user = user else { return }
        profileImageView.sd_setImage(with: user.profileImageUrl)
        usernameLabel.text = user.username
        fullnameLabel.text = user.fullname
    }
}
