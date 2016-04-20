//
//  biledHandler.swift
//  Byggo(v1)
//
//  Created by Benjamin Eibye on 20/04/2016.
//  Copyright © 2016 Benjamin Eibye. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

var getImageFile = UIImage()

class biledHandler: UIViewController {
    @IBOutlet weak var image: UIImageView!

    @IBOutlet weak var textField: UITextField!
    
    @IBAction func send(sender: AnyObject) {
   
        
    
    }
    
    
    override func viewDidLoad() {
        
        self.image.image = getImageFile
        
    }
    
    
    
}
