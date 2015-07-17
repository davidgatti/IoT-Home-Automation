//
//  STUFF.swift
//  GarageOpener
//
//  Created by David Gatti on 6/6/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

import Foundation

var token = Secrets.sharedInstance.ParticleToken
var device = Secrets.sharedInstance.ParticleDeviceID

func httpGet(name: String, callback: (JSON, NSError?) -> Void) {
    
    let url = "https://api.particle.io/v1/devices/" + device + "/" + name + "?access_token=" + token
    
    let request = NSMutableURLRequest(URL: NSURL(string: url)!)
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithRequest(request){(data, response, error) -> Void in
    let json = JSON(data: data!)
        
        if error != nil {
            
            callback(json, error)
            
        } else {
            
            callback(json, nil)
            
        }
    }
    
    task!.resume()
}

func httpPost(name: String, parameters: String, callback: (NSData, NSError?) -> Void) {

    let postString = "access_token=" + token + "&" + parameters
    
    let url = "https://api.particle.io/v1/devices/" + device + "/" + name
    
    let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
    
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithRequest(request){(data, response, error) -> Void in
        
        if error != nil {
            
            callback(data!, error)
            
        } else {
            
            callback(data!, nil)
            
        }
    }
    
    task!.resume()
}