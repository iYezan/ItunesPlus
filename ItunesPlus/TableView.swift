//
//  Ext+TableView.swift
//  ItunesPlus
//
//  Created by iYezan on 27/02/2022.
//

import UIKit

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let items = items[indexPath.row]
        cell.textLabel?.text = items.name
        
        // set label to the item's name
        cell.detailTextLabel?.text = items.description
        return cell
    }
}
