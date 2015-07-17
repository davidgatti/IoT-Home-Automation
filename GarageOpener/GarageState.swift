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
    var user: PFUser!
    var isOpen: Int = 0
    var useCount: Int = 0
    var lastUsed: NSDate = NSDate.distantPast() as NSDate
    
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
        
        let qHistory = PFQuery(className: "History")
        qHistory.orderByDescending("createdAt")
        qHistory.getFirstObjectInBackgroundWithBlock { (lastEntry: PFObject?, error) -> Void in
            
            self.isOpen = (lastEntry?.objectForKey("state") as? Int)!
            self.lastUsed = lastEntry!.createdAt!
            self.user = lastEntry?.objectForKey("user") as? PFUser

            self.user?.fetch()
            return completition()
        }
    }
    
    private func getUseCount(completition:() -> ()) {
        
        let qGarageDoor = PFQuery(className:"GarageDoor")
        qGarageDoor.getObjectInBackgroundWithId("eX9QCJGga5") { (garage: PFObject?, error: NSError?) -> Void in
            
            self.useCount = (garage!.objectForKey("useCount") as! Int)
            return completition()
        }
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
    
        let query = PFObject(withoutDataWithClassName: "GarageDoor", objectId: "eX9QCJGga5")
        
        query["useCount"] = self.useCount
        
        query.saveInBackground()
    }
}
