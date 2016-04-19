//
//  DetailedViewController.swift
//  Byggo(v1)
//
//  Created by Benjamin Eibye on 27/03/2016.
//  Copyright © 2016 Benjamin Eibye. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UICollectionViewDelegate {
    
    var check: Int! = 0
    var adresse: String!
    var sagId : Int!
    var tableArray: [String] = []
    var tableArrayType: [Int] = []
    var publicJSON: JSON = []
    
    
    @IBOutlet weak var kunde1: UILabel!
    @IBOutlet weak var kunde2: UILabel!
    @IBOutlet weak var ID: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tagBilledButton: UIButton!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var filLabel: UILabel!
    @IBOutlet weak var sagLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tagBilledButton.hidden = true
        self.statusButton.hidden = true
        self.table.hidden = true
        self.filLabel.hidden = true
        self.ID.hidden = true
        
        tableArray.append("Tegninger")
        tableArrayType.append(0)
        tableArray.append("Konstruktion")
        tableArrayType.append(1)
        tableArray.append("Rapporter")
        tableArrayType.append(2)
        tableArray.append("Kontrakter")
        tableArrayType.append(3)
        tableArray.append("Billeder")
        tableArrayType.append(4)
        tableArray.append("Andet")
        tableArrayType.append(5)
        
        self.title = adresse
        
        //print(sagId)
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if self.check == 1 {
            
            self.tagBilledButton.hidden = false
            self.statusButton.hidden = false
            self.table.hidden = false
            self.filLabel.hidden = false
            self.sagLabel.hidden = true
            self.ID.hidden = false
            
            let token = NSUserDefaults.standardUserDefaults().objectForKey("token")
            let id = NSUserDefaults.standardUserDefaults().objectForKey("id")
            
            Alamofire.request(.GET, "https://www.byggo.co/ios/sag.php", parameters: ["ios_token": token!, "id": id!, "sagId": self.sagId!])
                .responseJSON { response in
                    print(response.request)  // original URL request
                    
                    if let value = response.result.value {
                        let json = JSON(value)
                        self.publicJSON = json
                        
                        self.kunde1.text = "\(json[0]["kunde"]["kunde1"].stringValue): \(json[0]["kunde"]["kunde1tel"].stringValue)"
                        self.kunde2.text = "\(json[0]["kunde"]["kunde2"].stringValue): \(json[0]["kunde"]["kunde2tel"].stringValue)"
                        self.ID.text = "ID: \(json[0]["sag_id"].stringValue)"
                        
                    }
                    
            }
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableArray.count
    }
    

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel!.text = self.tableArray[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("FilListe", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == "FilListe" {
            
            let index = self.tableView.indexPathForSelectedRow! as NSIndexPath
            let vc = segue.destinationViewController as! fil
            
            vc.sagId = sagId
            vc.type = tableArrayType[index.row + 1]
            
            self.tableView.deselectRowAtIndexPath(index, animated: true)
            
        }
        
    }
    
}