//
//  MainTabController.swift
//  TwitterCloneAdamKramar
//
//  Created by Adam Kramar on 16/07/2020.
//  Copyright © 2020 Adam Kramar. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

class MainTabController: UITabBarController {
    
    // MARK: - Properties
    
    var user: User? {
        didSet {
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedViewController else { return }
            
            feed.user = user
        }
    }
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: K.IMAGE.NEW_TWEET), for: .normal)
        button.addTarget(self, action: #selector(handleActionButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .twitterBlue
        authenticateUserAndConfigureUI()
    }
    
    // MARK: - API
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        UserService.shared.fetchUser(uid: uid) { (user) in
            self.user = user
        }
    }
    
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginViewController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            print("DEBUG: User is logged in.")
            configeruViewControllers()
            configureUI()
            fetchUser()
        }
    }
    
    func logUserOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("DEBUG: Failed to sign out with error: \(error)")
        }
    }
    
    // MARK: - Handlers
    
    @objc func handleActionButtonPressed() {
        guard let user = user else { return }
        let viewController = UploadTweetViewController(user: user)
        let nav = UINavigationController(rootViewController: viewController)
        present(nav, animated: true, completion: nil)
    }
    
    // MARK: - UI Configuration
    
    func configureUI() {
        
        view.addSubview(actionButton)
        actionButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(56)
            make.bottom.equalTo(-64)
            make.right.equalTo(-16)
        }
        actionButton.layer.cornerRadius = 56 / 2
        
    }
    
    func configeruViewControllers() {
        
        let feed = FeedViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let nav1 = templateNavigationController(image: UIImage(named: K.IMAGE.FEED_ICON), rootViewController: feed)
        
        let explore = ExploreViewController()
        let nav2 = templateNavigationController(image: UIImage(named: K.IMAGE.EXPLORE_ICON), rootViewController: explore)
        
        let notifications = NotificationsViewController()
        let nav3 = templateNavigationController(image: UIImage(named: K.IMAGE.NOTIFICATINS_ICON), rootViewController: notifications)
        
        let conversations = ConversationsViewController()
        let nav4 = templateNavigationController(image: UIImage(named: K.IMAGE.CONVERSATIONS_ICON), rootViewController: conversations)
        
        viewControllers = [nav1, nav2, nav3, nav4]
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        
        return nav
    }
}
