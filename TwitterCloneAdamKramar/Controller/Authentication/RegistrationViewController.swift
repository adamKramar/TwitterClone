//
//  RegistrationViewController.swift
//  TwitterCloneAdamKramar
//
//  Created by Adam Kramar on 16/07/2020.
//  Copyright © 2020 Adam Kramar. All rights reserved.
//

import UIKit
import SnapKit

class RegistrationViewController: UIViewController {
    
    // MARK: - Properties
    
    private let imagePickerController = UIImagePickerController()
    
    private let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textField: emailTextField)

        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)

        return view
    }()
    
    private lazy var fullNameContainerView: UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: fullNameTextField)

        return view
    }()
    
    private lazy var userNameContainerView: UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: userNameTextField)

        return view
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().inputTextField(withPlaceholder: "Email")
        
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().inputTextField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        
        return tf
    }()
    
    private let fullNameTextField: UITextField = {
           let tf = Utilities().inputTextField(withPlaceholder: "Full name")
           
           return tf
       }()
    
    private let userNameTextField: UITextField = {
        let tf = Utilities().inputTextField(withPlaceholder: "Username")
        
        return tf
    }()
       
    private let signUpButton: UIButton = {
           let button = Utilities().whiteButton(withTitle: "Sign Up")
           button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
           
           return button
       }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Already have an account?", " Log In")
        button.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Handlers
    
    @objc func handleAddProfilePhoto() {
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func handleSignup() {
        
    }
    
    @objc func handleShowLogIn() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UI Configuration
    
    func configureUI() {
        
        view.backgroundColor = .twitterBlue
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        view.addSubview(addPhotoButton)
        addPhotoButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(128)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, fullNameContainerView, userNameContainerView, signUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.top.equalTo(addPhotoButton.snp_bottomMargin).offset(40)
            make.right.equalTo(-32)
            make.left.equalTo(32)
        }
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.bottom.equalTo(-8)
        }
    }
    
    // MARK: - Helpers
    
}

// MARK: - UIImagePickerControllerDelegate

extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        
        addPhotoButton.layer.cornerRadius = 128 / 2
        addPhotoButton.layer.masksToBounds = true
        addPhotoButton.layer.borderColor = UIColor.white.cgColor
        addPhotoButton.layer.borderWidth = 3
        addPhotoButton.imageView?.contentMode = .scaleAspectFill
        addPhotoButton.imageView?.clipsToBounds = true
        addPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
}
