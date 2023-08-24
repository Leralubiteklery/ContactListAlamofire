//
//  ContactListViewController.swift
//  ContactList
//
//  Created by Lera Savchenko on 22.08.23.
//

import UIKit

class ContactListViewController: UITableViewController {
    
    private var contacts: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
        downloadData()
        setupRefreshControl()
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contact", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.imageProperties.maximumSize = CGSize(width: 100, height: 100)
        content.imageProperties.cornerRadius = 50
        
        let contact = contacts[indexPath.row]
        content.text = contact.name?.first
        content.secondaryText = contact.name?.last
        
        if let imageURL = contact.picture?.thumbnail {
            NetworkManager.shared.fetchData(from: imageURL) { result in
                switch result {
                case .success(let imageData):
                    content.image = UIImage(data: imageData)
                    cell.contentConfiguration = content
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - Private Methods
extension ContactListViewController {
    @objc private func downloadData() {
        NetworkManager.shared.fetchUsers { result in
            switch result {
            case .success(let contacts):
                self.contacts = contacts
                self.tableView.reloadData()
                if self.refreshControl != nil {
                    self.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(downloadData), for: .valueChanged)
    }
}
