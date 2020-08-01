//
//  ViewController.swift
//  MemoryApp
//
//  Created by Valerie 👩🏼‍💻 on 31/07/2020.
//

import UIKit

class ViewController: UITableViewController {
    let dataSource = MemoryDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        
        navigationItem.title = "Texts to Memorize"
        navigationController?.navigationBar.prefersLargeTitles =  true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "MemoryViewController") as? MemoryViewController else {
            fatalError("Unable to instantiate memory view controller")
        }
        
        let item = dataSource.item(at: indexPath.row)
        vc.item = item
        navigationController?.pushViewController(vc, animated: true)
    }
}

