//
//  settings.swift
//  Byggo(v1)
//
//  Created by Benjamin Eibye on 28/03/2016.
//  Copyright © 2016 Benjamin Eibye. All rights reserved.
//

import UIKit

class settings: UIViewController {

    @IBOutlet weak var navn: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        
        navn.text = defaults.stringForKey("name")
        idLabel.text = "ID: \(defaults.stringForKey("id")!)"
        
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    @IBAction func logud(sender: AnyObject) {
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("id")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("token")
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("name")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("intialer")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("username")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("rank")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("admin")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("sag")
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc: AnyObject! = storyboard.instantiateViewControllerWithIdentifier("loginView")
        
        self.presentViewController(vc as! UIViewController, animated: true, completion: nil)
        
    }
    
}
 