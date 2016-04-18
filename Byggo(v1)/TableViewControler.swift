//
//  TableViewControler.swift
//  Byggo(v1)
//
//  Created by Benjamin Eibye on 27/03/2016.
//  Copyright © 2016 Benjamin Eibye. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TableViewController: UITableViewController, UISplitViewControllerDelegate {
    
    var tableCount: Int = 0
    var adresse: String = ""
    var publicJSON: JSON = []
    
    
    override func viewDidAppear(animated: Bool) {
        
        self.tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token = NSUserDefaults.standardUserDefaults().objectForKey("token")
        let id = NSUserDefaults.standardUserDefaults().objectForKey("id")
        
        Alamofire.request(.GET, "https://www.byggo.co/ios/sag.php", parameters: ["ios_token": token!, "id": id!])
            .responseJSON { response in
                print(response.request)  // original URL request
                
                
                if let value = response.result.value {
                    let json = JSON(value)
                    self.tableCount =  json.count
                    self.publicJSON = json
                }
        }
        
        self.splitViewController!.delegate = self;
        self.splitViewController!.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
    
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
        return tableCount
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UICell
        
        myCell.adresse.text = publicJSON[indexPath.row]["adresse"].stringValue
        myCell.salg.text = "Salg: \(publicJSON[indexPath.row]["byg"]["salg"].stringValue)"
        myCell.byg.text = "Byg: \(publicJSON[indexPath.row]["byg"]["byggeleder"].stringValue)"
        myCell.status.text = "Status: \(publicJSON[indexPath.row]["status"].stringValue)"
        myCell.afdeling.text = "Afdeling: \(publicJSON[indexPath.row]["afdeling"].stringValue)"
        
        return myCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showDetail", sender: self)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDetail" {
            
            let index = self.tableView.indexPathForSelectedRow! as NSIndexPath
            
            let nav = segue.destinationViewController as! UINavigationController
            
            let vc = nav.viewControllers[0] as! DetailViewController
            
            vc.adresse = publicJSON[index.row]["adresse"].stringValue
            vc.sagId = publicJSON[index.row]["sag_id"].intValue
            vc.check = 1
            
            print(publicJSON[index.row]["sag_id"].intValue)
            
            self.tableView.deselectRowAtIndexPath(index, animated: true)
            
        }
        
    }
    
    // MARK: - UISplitViewControllerDelegate
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
        
        return true
        
    }
    
    
    
    
    
    
    
    
    
}