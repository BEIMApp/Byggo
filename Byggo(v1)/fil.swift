//
//  fil.swift
//  Byggo(v1)
//
//  Created by Benjamin Eibye on 19/04/2016.
//  Copyright © 2016 Benjamin Eibye. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class fil: UITableViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        // ViewDidLoad Fucntion
        self.tableView.reloadData()
        
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("filCell", forIndexPath: indexPath) as! filCell
        
        cell.filNavn.text = "Hey"
        
        print(indexPath.row)
        
        return cell
    }
    
}
