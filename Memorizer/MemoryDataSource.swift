//
//  MemoryDataSource.swift
//  Memorizer
//
//  Created by Emin Roblack on 1/9/19.
//  Copyright © 2019 emiN Roblack. All rights reserved.
//

import UIKit

class MemoryDataSource: NSObject, UITableViewDataSource {
  
  var items = [MemoryItem]()
  
  //MARK:- Parsing the JSON ------------------------------------------------
  override init() {
    
    // Getting the JSON file from our bundle and assigning it to a constant
    guard let url = Bundle.main.url(forResource: "Items", withExtension: "json")
      else { fatalError("JSON not loaded") }
    
    // Turning that JSON object into DATA object
    guard let data = try? Data(contentsOf: url)
      else { fatalError("Unable to load JSON") }
    
    // Decoding / Parsing data from JSON
    let decoder = JSONDecoder()
    guard let savedItems = try? decoder.decode([MemoryItem].self, from: data)
      else { fatalError("Could not decode JSON") }
    
    items = savedItems
  }
  //------------------------------------------------------------------------

  
  
  //MARK:- Table delegate Methods ------------------------------------------------
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    let item = items[indexPath.row]
    
    cell.textLabel?.text = item.title
    cell.detailTextLabel?.text = item.text
    
    return cell
  }
  //------------------------------------------------------------------------
  
  func item(index: Int) -> MemoryItem {
    return items[index]
  }
  
}
