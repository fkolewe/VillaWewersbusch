//
//  BackTableVc.swift
//  Villa Wewersbusch App
//
//  Created by Felix Kolewe on 11.03.17.
//  Copyright © 2017 Felix Kolewe. All rights reserved.
//

import Foundation

class BackTableVC: UITableViewController {
    
    var tableArray = [String]()

    override func viewDidLoad() {
        tableArray = ["Home", "Speiseplan", "Schule", "Internat"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableArray[indexPath.row], for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = tableArray[indexPath.row]
        
        
        return cell
    }
    
}
