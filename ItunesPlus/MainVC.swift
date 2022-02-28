//
//  ViewController.swift
//  ItunesPlus
//
//  Created by iYezan on 27/02/2022.
//

import UIKit

class MainVC: UIViewController, UISearchBarDelegate {

//    let mockdata = Itune.mockData
    var tableView = UITableView()
   
    
    // lets implement a UISearchController
    let searchBar = UISearchController(searchResultsController: nil)
    var items = [StoreItem]()
    
    let cellId = "Cell"
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        tableView.delegate      = self
        tableView.dataSource    = self
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        setupSearchBar()

    }
    
    fileprivate func setupSearchBar() {
        navigationItem.searchController                     = searchBar
        navigationItem.hidesSearchBarWhenScrolling          = false
        searchBar.searchBar.delegate                        = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        // later implement Almofire to search iTunes  API
        
        self.items = []
        self.tableView.reloadData()
        
        
        let searchTerm = searchBar.text ?? ""
        
        if !searchTerm.isEmpty {
            
            // set up query dictionary
            let query = [
                "term": searchTerm,
                "media": "music",
                "lang": "en_us",
                "limit": "20"
            ]
            // use the item controller to fetch items
            NetworkManager.shared.getItems(matching: query) { (fetchedItems) in
                if let fetchedItems = fetchedItems {
                    DispatchQueue.main.async {
                        self.items = fetchedItems
                        self.tableView.reloadData()
                    }
                }
            }
            // if successful, use the main queue to set self.items and reload the table view
            // otherwise, print an error to the console
        }
    }
}

