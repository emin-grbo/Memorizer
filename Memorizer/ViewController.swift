//
//  ViewController.swift
//  Memorizer
//
//  Created by Emin Roblack on 1/9/19.
//  Copyright © 2019 emiN Roblack. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  
  let dataSource = MemoryDataSource()

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = dataSource
  }
  
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let vc = storyboard?.instantiateViewController(withIdentifier: "MemoryVC") as? MemoryViewController else { fatalError("Unable to find MemoryVC") }
    
    let item = dataSource.item(index: indexPath.row)
    vc.item = item
    
    navigationController?.pushViewController(vc, animated: true)
  }
  
  
}

