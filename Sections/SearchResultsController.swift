//
//  SearchResultsController.swift
//  Sections
//
//  Created by LAURA LUCRECIA SANCHEZ PADILLA on 07/10/15.
//  Copyright © 2015 LAURA LUCRECIA SANCHEZ PADILLA. All rights reserved.
//

import UIKit

private let longNameSize = 6
private let shortNameButtonIndex  = 1
private let longNamesButtonIndex = 2

class SearchResultsController: UITableViewController, UISearchResultsUpdating {
    
    let sectionsTableIdentifier = "SectionsTableIdentifier"
    var names :[String : [String]] = [String : [String]]()
    var keys : [String] = [String]()
    var filteredNames : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: sectionsTableIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNames.count
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        filteredNames.removeAll()
        let searchingString = searchController.searchBar.text
        let buttonIndex = searchController.searchBar.selectedScopeButtonIndex
        if !(searchingString!.isEmpty){
            
            let filter : String -> Bool = { name in
                let tempName : NSString = name
                let nameLength = tempName.length
                if (buttonIndex == shortNameButtonIndex && nameLength >= longNameSize) || (buttonIndex == longNameSize && nameLength < longNameSize){
                    return false
                }
                let range = tempName.rangeOfString(searchingString!, options: NSStringCompareOptions.CaseInsensitiveSearch)
                if range.length <= 0{
                    return false
                }else{
                    return true
                }
            }
            
            
            for key in keys{
                let namesForKey = names[key]!
                let matches = namesForKey.filter(filter)
                filteredNames += matches
            }
        }
        
        
        self.tableView.reloadData()
    }

    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(sectionsTableIdentifier)
        cell!.textLabel?.text = filteredNames[indexPath.row]
        // Configure the cell...

        return cell!
    }
    


}
