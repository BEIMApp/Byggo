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

class fil: UICollectionViewController, UISplitViewControllerDelegate, UIViewControllerTransitioningDelegate {

    var sagId = 1
    var type: Int = 2
    
    
    var JSONCount: Int = 0
    var publicJSON: JSON = []
    var tableArray: [String] = []
    
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

        tableArray.append("Tegninger")
        tableArray.append("Konstruktion")
        tableArray.append("Rapporter")
        tableArray.append("Kontrakter")
        tableArray.append("Billeder")
        tableArray.append("Andet")
        
        self.title = tableArray[type - 1]
        
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
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        //let index = self.tableView.indexPathForSelectedRow! as NSIndexPath
        
        print(indexPath.row)
        
        filId = publicJSON[indexPath.row]["id"].intValue
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pvc = storyboard.instantiateViewControllerWithIdentifier("webView") as UIViewController
        
        pvc.modalPresentationStyle = UIModalPresentationStyle.FullScreen
        
        self.presentViewController(pvc, animated: true, completion: nil)
        
    }
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presentingViewController: presentingViewController!)
    }

    
}
class HalfSizePresentationController : UIPresentationController {
    override func frameOfPresentedViewInContainerView() -> CGRect {
        return CGRect(x: 0, y: 0, width: containerView!.bounds.width, height: containerView!.bounds.height/2)
    }
}
