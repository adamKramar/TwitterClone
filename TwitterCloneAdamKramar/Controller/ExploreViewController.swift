//
//  ExploreViewController.swift
//  TwitterCloneAdamKramar
//
//  Created by Adam Kramar on 16/07/2020.
//  Copyright © 2020 Adam Kramar. All rights reserved.
//

import UIKit

class ExploreViewController: UITableViewController {
    
    // MARK: - Properties
    
     private var users = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var filteredUsers = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        fetchUsers()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .default
    }
    
    // MARK: - UI Configuration
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Explore"
        
        tableView.register(UserCell.self, forCellReuseIdentifier: K.ID.USER_CELL_ID)
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
    }
    
    // MARK: - Helpers
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a user"
        navigationItem.searchController = searchController
        definesPresentationContext = false
        
    }
    
    // MARK: - API
    
    func fetchUsers() {
        UserService.shared.fetchUsers { (users) in
            self.users = users
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ExploreViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? filteredUsers.count : users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ID.USER_CELL_ID, for: indexPath) as! UserCell
        let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        cell.user = user
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        let controller = ProfileViewController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UISearchResultsUpdating

extension ExploreViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        filteredUsers = users.filter({$0.username.contains(searchText)})
    }
    
}
