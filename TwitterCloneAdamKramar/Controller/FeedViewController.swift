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

class FeedViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    var user: User? {
        didSet {
            configureLeftBarButton()
        }
    }
    
    private var tweets = [Tweet]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchTweets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .default
    }
    
    // MARK: - API
    
    func fetchTweets() {
        TweetService.shared.fetchTweets { (tweets) in
            self.tweets = tweets
        }
    }
    
    // MARK: - UI Configuration
    
    func configureUI() {
        view.backgroundColor = .white
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: K.ID.TWEET_CELL_ID)
        collectionView.backgroundColor = .white
        
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
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension FeedViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.ID.TWEET_CELL_ID, for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = TweetViewController(tweet: tweets[indexPath.row])
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UICollectionViewFlowLayout

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewModel = TweetViewModel(tweet: tweets[indexPath.row])
        let height = viewModel.size(width: view.frame.width).height
        return CGSize(width: view.frame.width, height: height + 72)
    }
}

// MARK: - TweetCellDelegate

extension FeedViewController: TweetCellDelegate {
    
    func didTapReplay(_ cell: TweetCell) {
        guard let tweet = cell.tweet else { return }
        let viewController = UploadTweetViewController(user: tweet.user, config: .reply(tweet))
        let nav = UINavigationController(rootViewController: viewController)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    
    func didTapProfileImage(_ cell: TweetCell) {
        guard let user = cell.tweet?.user else { return }
        let viewController = ProfileViewController(user: user)
        navigationController?.pushViewController(viewController, animated: true)
    }

}
