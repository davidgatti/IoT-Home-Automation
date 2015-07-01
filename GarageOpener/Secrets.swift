//
//  TempStorage.swift
//  GarageOpener
//
//  Created by David Gatti on 6/30/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

import UIKit

class Secrets {
    
    // Creating a singletone
    static let sharedInstance = Secrets()
    
    //Secret variables
    var ParticleToken: String!
    var ParticleDeviceID: String!
    
    var ParseAppID: String!
    var ParseClientKey: String!
    
    init() {
        
        // Read the Secret file
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
}
