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

class fil: UICollectionViewController, UISplitViewControllerDelegate {

    var sagId = 1
    var type: Int = 2
    var JSONCount: Int = 0
    var publicJSON: JSON = []
    
    override func viewDidLoad() {
        // ViewDidLoad Fucntion
        let token = NSUserDefaults.standardUserDefaults().objectForKey("token")
        let id = NSUserDefaults.standardUserDefaults().objectForKey("id")
        
        Alamofire.request(.GET, "https://www.byggo.co/ios/fil.php", parameters: ["ios_token": token!, "id": id!, "sagId": self.sagId, "type": self.type])
            .responseJSON { response in
                print(response.request)  // original URL request
                
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    self.publicJSON = json
                    self.JSONCount = json.count
                    self.collectionView?.reloadData()
                    
                }
                
        }

        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        //self.collectionView?.reloadData()
        
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.JSONCount
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("filCell", forIndexPath: indexPath) as! filCell
        
        cell.filNavn.text = publicJSON[indexPath.row]["navn"].stringValue
        
        let filType = publicJSON[indexPath.row]["type"].stringValue
        
        // '', '', '', '', '', '', '', 'fw', 'xlsx'
        
        switch filType {
        case "png":
            cell.typeImage.image = UIImage(named: "png_Symbol")
        case "jpeg":
            cell.typeImage.image = UIImage(named: "jpeg_Symbol")
        case "jpg":
            cell.typeImage.image = UIImage(named: "jpeg_Symbol")
        case "docx":
            cell.typeImage.image = UIImage(named: "pdf_Symbol")
        case "pdf":
            cell.typeImage.image = UIImage(named: "pdf_Symbol")
        case "pptx":
            cell.typeImage.image = UIImage(named: "ppt_Symbol")
        case "xlsx":
            cell.typeImage.image = UIImage(named: "excel_Symbol")
        default:
            cell.typeImage.image = UIImage(named: "pdf_Symbol")
        }
        
        
        //cell.typeImage.image = UIImage(named: "jpeg_Symbol")
        
        
        return cell
    }
    
}
