//
//  WaterUsageTableViewController.swift
//  GarageOpener
//
//  Created by David Gatti on 7/16/15.
//  Copyright © 2015 David Gatti. All rights reserved.
//

import UIKit
import Parse

class WaterUsageTableViewController: UITableViewController {

    var alphabet = ["Hot: n/a", "Cold: n/a"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("loadParseData"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
        
        loadParseData()
    }

    func loadParseData() {
    
        let queryHotWater = PFQuery(className: "History_Water")
        queryHotWater.whereKey("tag", equalTo: "hot")
        queryHotWater.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            
            var ammountOfHotWater = 0.0;
            
            if let objects = objects as? [PFObject] {
                for object in objects {
                    
                    ammountOfHotWater += Double(object.objectForKey("value")! as! String)!
                }
                
                self.alphabet[0] = "Hot: " + String(ammountOfHotWater / 1000)
                
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
            
        }
        
        
        
        let queryColdWater = PFQuery(className: "History_Water")
        queryColdWater.whereKey("tag", equalTo: "cold")
        queryColdWater.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            
            var ammountOfColdtWater = 0.0;
            
            if let objects = objects as? [PFObject] {
                for object in objects {
                    
                    ammountOfColdtWater += Double(object.objectForKey("value")! as! String)!
                }
                
                self.alphabet[1] = "Cold: " + String(ammountOfColdtWater / 1000)
                
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return alphabet.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
        cell.textLabel?.text = self.alphabet[indexPath.row]

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
