//
//  Settings.swift
//  GarageOpener
//
//  Created by David Gatti on 6/8/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

import Foundation


class AppSettings {
    static let sharedInstance = AppSettings()
    
    var lastUser: String = ""
    var token: String = ""
    var deviceID: String = ""
    
    init() {
        var myDict: NSDictionary?
        
        if let path = NSBundle.mainBundle().pathForResource("Secrets", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        
        if let tmpToken = myDict?.objectForKey("token") as? String {
            self.token = tmpToken
        }
        
        if let tmpDeviceID = myDict?.objectForKey("deviceID") as? String {
            self.deviceID = tmpDeviceID
        }
    }
}
