//
//  ConversationsViewController.swift
//  TwitterCloneAdamKramar
//
//  Created by Adam Kramar on 16/07/2020.
//  Copyright © 2020 Adam Kramar. All rights reserved.
//

import UIKit

class ConversationsViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - UI Configuration
    
    func configureUI() {
        
        view.backgroundColor = .white
        navigationItem.title = "Messages"
    }
}
