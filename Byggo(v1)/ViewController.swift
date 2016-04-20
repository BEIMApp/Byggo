//
//  ViewController.swift
//  Byggo(v1)
//
//  Created by Benjamin Eibye on 25/03/2016.
//  Copyright © 2016 Benjamin Eibye. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var status: UILabel!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        print("start")
        
        let token = NSUserDefaults.standardUserDefaults().objectForKey("token")
        let id = NSUserDefaults.standardUserDefaults().objectForKey("id")
        
        if token != nil && id != nil {
            
            print(token)
            
            Alamofire.request(.GET, "https://www.byggo.co/ios/val.php", parameters: ["id": id!, "ios_token": token!])
                .responseJSON { response in
                    print(response.request)
                    switch response.result {
                    case .Success:
                        if let value = response.result.value {
                            
                            let JSON_response = JSON(value)
                            
                            if JSON_response[0]["log"] == true {
                            
                                NSUserDefaults.standardUserDefaults().setObject(JSON_response[0]["name"].stringValue, forKey: "name")
                                NSUserDefaults.standardUserDefaults().setObject(JSON_response[0]["intialer"].stringValue, forKey: "intialer")
                                NSUserDefaults.standardUserDefaults().setObject(JSON_response[0]["username"].stringValue, forKey: "username")
                                NSUserDefaults.standardUserDefaults().setObject(JSON_response[0]["rank"].stringValue, forKey: "rank")
                                NSUserDefaults.standardUserDefaults().setObject(JSON_response[0]["admin"].stringValue, forKey: "admin")
                                NSUserDefaults.standardUserDefaults().setObject(JSON_response[0]["sag"].stringValue, forKey: "sag")
                                
                                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                
                                let vc: AnyObject! = storyboard.instantiateViewControllerWithIdentifier("splitView")
                                
                                self.showViewController(vc as! UISplitViewController, sender: vc)
                                
                                
                            }
                            
                        }
                    case .Failure(let error):
                        print(error)
                        self.activityIndicator.stopAnimating()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    }
            }
        } else {
            print("No token was set")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    @IBAction func login(sender: AnyObject) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        if username.text != "" && password.text != "" {
            
            let userName: String = (username.text?.uppercaseString)!
            
            Alamofire.request(.GET, "https://www.byggo.co/ios/user.php", parameters: ["call": 1, "username": userName, "password": password.text!])
                .responseJSON { response in
                    switch response.result {
                    case .Success:
                        if let value = response.result.value {
                            let json = JSON(value)
                            
                            if json[0]["error"] == true {
                                self.status.text = "Kunne ikke finde brugeren"
                                print(response.request)
                                self.activityIndicator.stopAnimating()
                                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                                
                            } else {
                                NSUserDefaults.standardUserDefaults().setObject(value[0]["token"], forKey: "token")
                                NSUserDefaults.standardUserDefaults().setObject(value[0]["id"], forKey: "id")
                                self.activityIndicator.stopAnimating()
                                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                                
                                let token: AnyObject! = value[0]["token"]
                                let id: AnyObject! = value[0]["id"]
                                
                                Alamofire.request(.GET, "https://www.byggo.co/ios/val.php", parameters: ["id": id, "ios_token": token])
                                    .responseJSON { response in
                                        print(response.request)
                                        switch response.result {
                                        case .Success:
                                            if let value = response.result.value {
                                                
                                                let JSON_response = JSON(value)
                                                
                                                if JSON_response[0]["log"] == true {
                                                    
                                                    NSUserDefaults.standardUserDefaults().setObject(JSON_response[0]["name"].stringValue, forKey: "name")
                                                    NSUserDefaults.standardUserDefaults().setObject(JSON_response[0]["intialer"].stringValue, forKey: "intialer")
                                                    NSUserDefaults.standardUserDefaults().setObject(JSON_response[0]["username"].stringValue, forKey: "username")
                                                    NSUserDefaults.standardUserDefaults().setObject(JSON_response[0]["rank"].stringValue, forKey: "rank")
                                                    NSUserDefaults.standardUserDefaults().setObject(JSON_response[0]["admin"].stringValue, forKey: "admin")
                                                    NSUserDefaults.standardUserDefaults().setObject(JSON_response[0]["sag"].stringValue, forKey: "sag")
                                                    
                                                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                    
                                                    let vc: AnyObject! = storyboard.instantiateViewControllerWithIdentifier("splitView")
                                                    
                                                    self.showViewController(vc as! UISplitViewController, sender: vc)
                                                    
                                                    
                                                }
                                                
                                            }
                                        case .Failure(let error):
                                            print(error)
                                            self.activityIndicator.stopAnimating()
                                            UIApplication.sharedApplication().endIgnoringInteractionEvents()
                                        }
                                }
                                
                            }
                            
                        }
                    case .Failure(let error):
                        print(error)
                        self.activityIndicator.stopAnimating()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    }
            }
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

