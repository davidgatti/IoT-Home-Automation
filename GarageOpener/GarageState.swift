//
//  Settings.swift
//  GarageOpener
//
//  Created by David Gatti on 6/8/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

import Foundation
import Parse

class GarageState {

    //MARK: Static
    static let sharedInstance = GarageState()

    //MARK: Variables
    var isOpen: Int = 0
    var useCount: Int = 0
    var user: PFUser!
    var lastUser: String!
    var lastUsed: NSDate = NSDate.distantPast() as! NSDate
    var avatar: UIImage!
    
    //MARK: Get
    
    func get(completition:() -> ()) {
        
        var count: Int = 0
        
        getLastUser { (result) -> Void in
            count++
        }
        
        getUseCount { (result) -> Void in
            count++
        }
        
        while true {
            if count == 2 {
                return completition()
            }
        }
    }
    
    private func getLastUser(completition:() -> ()) {
        
        var qHistory = PFQuery(className: "History")
        qHistory.orderByDescending("createdAt")
        qHistory.getFirstObjectInBackgroundWithBlock { (lastEntry: PFObject?, error) -> Void in
            
            let user = lastEntry?.objectForKey("user") as? PFUser
            user?.fetch()
            
            self.lastUser = user!.username!
            self.isOpen = (lastEntry?.objectForKey("state") as? Int)!
            
            if let file = user?.objectForKey("profilePhotho") as? PFFile, data = file.getData() {
                self.avatar = UIImage(data: data)
            }

            self.getLastUsed(lastEntry!.createdAt!, completition: { () -> () in
            
                return completition()
            })
        
        }
    }
    
    private func getUseCount(completition:() -> ()) {
        
        var qGarageDoor = PFQuery(className:"GarageDoor")
        qGarageDoor.getObjectInBackgroundWithId("eX9QCJGga5") { (garage: PFObject?, error: NSError?) -> Void in
            self.useCount = (garage!.objectForKey("useCount") as! Int)
            return completition()
        }
    }
    
    private func getLastUsed(time: NSDate, completition:() -> ()) {
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.zzz'Z'"
        
        //var date:NSDate = dateFormatter.dateFromString(time)!
        self.lastUsed = time
    
        return completition()
    }
    
    //MARK: Set
    
    func set(completition: (result: String) -> Void) {
        setHistory { (result) -> Void in }
        setGarageDoor { (result) -> Void in }
    }
    
    private func setHistory(completition: (result: String) -> Void) {
        
        let user = PFUser.currentUser()
        let history = PFObject(className: "History")
        
        history["user"] = user
        history["applianceID"] = "eX9QCJGga5"
        history["state"] = self.isOpen
        
        history.saveInBackground()
    }
    
    private func setGarageDoor(completition: (result: String) -> Void) {
    
        var query = PFObject(withoutDataWithClassName: "GarageDoor", objectId: "eX9QCJGga5")
        
        query["useCount"] = self.useCount
        
        query.saveInBackground()
    }
}
