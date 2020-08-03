//
//  Utilities.swift
//  TwitterCloneAdamKramar
//
//  Created by Adam Kramar on 16/07/2020.
//  Copyright © 2020 Adam Kramar. All rights reserved.
//

import UIKit

struct Utilities {
    
    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        let iv = UIImageView()
        let deviderView = UIView()
        
        view.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        
        let hStack = UIStackView(arrangedSubviews: [iv, textField])
        hStack.axis = .horizontal
        hStack.spacing = 8
        
        view.addSubview(hStack)
        hStack.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(24)
        }
        
        iv.image = image
        iv.snp.makeConstraints { (make) in
            make.height.width.equalTo(24)
        }
        
        let vStack = UIStackView(arrangedSubviews: [hStack, deviderView])
        vStack.axis = .vertical
        vStack.spacing = 8
        
        view.addSubview(vStack)
        vStack.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
        }
        
        deviderView.backgroundColor = .white
        deviderView.snp.makeConstraints { (make) in
            make.height.equalTo(0.7)
        }
        
        return view
    }
    
    func inputTextField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        return tf
    }
    
    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes:
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
             NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: secondPart, attributes:
        [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
        NSAttributedString.Key.foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }
    
    func whiteButton(withTitle title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        button.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        
        return button
    }
    
    func actionButton(withImageNamed imageName: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.tintColor = .darkGray
        
        button.snp.makeConstraints { (make) in
            make.height.width.equalTo(20)
        }
        
        return button
    }
}
