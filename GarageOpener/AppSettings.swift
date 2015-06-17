//
//  Settings.swift
//  GarageOpener
//
//  Created by David Gatti on 6/8/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

import Foundation
import Parse

class AppSettings {

    //MARK: Static
    static let sharedInstance = AppSettings()

    //MARK: Variables
    var isOpen: Int = 0
    var useCount: Int = 0
    var lastUser: String = ""
    var lastUsed: NSDate = NSDate.distantPast() as! NSDate
    var avatar: UIImage!
    var userID: String {
        get {
            var tmpUserID: String = ""
            
            let defaults = NSUserDefaults.standardUserDefaults()
            if let userID = defaults.stringForKey("userID") {
                tmpUserID = userID
            }
            
            return tmpUserID
        }
    }

    //MARK: Secrets
    var ParticleToken: String = ""
    var ParticleDeviceID: String = ""
    var ParseAppID: String = ""
    var ParseClientKey: String = ""
    
    //MARK: Initialization
    init() {
        
        // Get the Token and Device ID for Particle
        var myDict: NSDictionary?

        if let path = NSBundle.mainBundle().pathForResource("Secrets", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        
        // Particle.io
        if let tmpParseToken = myDict?.objectForKey("ParticleToken") as? String {
            self.ParticleToken = tmpParseToken
        }
        
        if let tmpParseDeviceID = myDict?.objectForKey("ParticleDeviceID") as? String {
            self.ParticleDeviceID = tmpParseDeviceID
        }
        
        // Parse.com
        if let tmpParseAppID = myDict?.objectForKey("ParseAppID") as? String {
            self.ParseAppID = tmpParseAppID
        }
        
        if let tmpParseClientID = myDict?.objectForKey("ParseClientID") as? String {
            self.ParseClientKey = tmpParseClientID
        }
    }
    
    //MARK: Get
    
    func get(completition:() -> ()) {
        
        println("get")
        
        var count: Int = 0
        
        getLastUser { (result) -> Void in
            println("GetLastUser - result")
            count++
        }
        
        getUseCount { (result) -> Void in
            println("GetUserCount - result")
            count++
        }
        
        while true {
            if count == 2 {
                return completition()
            }
        }
    }
    
    private func getLastUser(completition:() -> ()) {
        println("GetLastUser - Header")
        
        var qHistory = PFQuery(className: "History")
        qHistory.orderByDescending("createdAt")
        qHistory.getFirstObjectInBackgroundWithBlock { (lastEntry: PFObject?, error) -> Void in
            
            println("GetLastUser - qHistory")
            
            var qUser = PFQuery(className: "Users")
            
            qUser.getObjectInBackgroundWithId((lastEntry?.objectForKey("userID") as? String)!) {
                (name: PFObject?, error) -> Void in
                
                println("GetLastUser - qUser")
                
                self.lastUser = (name?.objectForKey("name") as? String)!
                
                if let file = name?.objectForKey("avatar") as? PFFile, data = file.getData() {
                    self.avatar = UIImage(data: data)
                }

                self.getLastUsed(name!.createdAt!, completition: { () -> () in
                
                    return completition()
                })
                
                
            }
        }
        
        println("GetLastUser - Footer")
        
        
        
    }
    
    private func getUseCount(completition:() -> ()) {
        println("GetUserCount - Header")
        
        var qGarageDoor = PFQuery(className:"GarageDoor")
        qGarageDoor.getObjectInBackgroundWithId("eX9QCJGga5") { (garage: PFObject?, error: NSError?) -> Void in
            self.useCount = (garage!.objectForKey("useCount") as! Int)
            return completition()
        }
        

    }
    
    private func getLastUsed(time: NSDate, completition:() -> ()) {
        println("GetLastUsed - Header")
        
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
        let history = PFObject(className: "History")
        history["userID"] = self.userID
        history["object"] = 1
        history["state"] = self.isOpen
        history.saveInBackground()
    }
    
    private func setGarageDoor(completition: (result: String) -> Void) {
        var query = PFObject(withoutDataWithClassName: "GarageDoor", objectId: "eX9QCJGga5")
        query["useCount"] = self.useCount
        query.saveInBackground()
    }
}
