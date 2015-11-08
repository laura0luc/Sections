//
//  ViewController.swift
//  Sections
//
//  Created by LAURA LUCRECIA SANCHEZ PADILLA on 07/10/15.
//  Copyright © 2015 LAURA LUCRECIA SANCHEZ PADILLA. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let sectionsTableIdentifier = "SectionsTableIdentifier"
    var names :[String : [String]]!
    var keys : [String]!
    
    var searchController : UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: sectionsTableIdentifier)
        let path = NSBundle.mainBundle().pathForResource("sortednames", ofType: "plist")
        let namesDict = NSDictionary(contentsOfFile: path!)
        names = namesDict as! [String : [String]]!
        let temp = namesDict?.allKeys as! [String]
        keys = temp.sort()
        
        let resultsController = SearchResultsController()
        resultsController.names = names
        resultsController.keys = keys
        searchController = UISearchController(searchResultsController: resultsController)
        
        let searchBar = searchController.searchBar
        searchBar.scopeButtonTitles = ["All", "Short", "Long"]
        searchBar.placeholder = "Enter a search term"
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
        searchController.searchResultsUpdater = resultsController
        
        
        tableView.sectionIndexBackgroundColor = UIColor.blackColor()
        tableView.sectionIndexTrackingBackgroundColor = UIColor.darkGrayColor()
        tableView.sectionIndexColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return keys.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = keys[section]
        let nameSection = names[key]!
        return nameSection.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(sectionsTableIdentifier, forIndexPath: indexPath)
        let key = keys[indexPath.section]
        let nameSection = names[key]!
        cell.textLabel?.text = nameSection[indexPath.row]
        return cell
        
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return keys
    }
}

