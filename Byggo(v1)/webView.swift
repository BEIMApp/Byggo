//
//  webView.swift
//  Byggo(v1)
//
//  Created by Benjamin Eibye on 20/04/2016.
//  Copyright © 2016 Benjamin Eibye. All rights reserved.
//

import UIKit

var filId:Int = 20

class webView: UIViewController {

    let token = NSUserDefaults.standardUserDefaults().objectForKey("token")
    let id = NSUserDefaults.standardUserDefaults().objectForKey("id")
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        
        let url = NSURL(string: "https://www.byggo.co/ios/showfil.php?ios_token=\(token!)&id=\(id!)&filId=\(filId)")
        let requestObj = NSURLRequest(URL: url!)
        webView.loadRequest(requestObj)
        print(url)
        
    }
    
    @IBAction func share(sender: AnyObject) {
        
        let textToShare = "Swift is awesome!  Check out this website about it!"
        
        if let myWebsite = NSURL(string: "http://www.codingexplorer.com/") {
            let objectsToShare = [textToShare, myWebsite]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view

            self.presentViewController(activityVC, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func fullscreen(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
}
