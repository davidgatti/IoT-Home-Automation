//
//  STUFF.swift
//  GarageOpener
//
//  Created by David Gatti on 6/6/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

import Foundation

var token = AppSettings.sharedInstance.token
var device = AppSettings.sharedInstance.deviceID

func httpGet(name: String, callback: (NSData, NSError?) -> Void) {
    
    let url = "https://api.particle.io/v1/devices/" + device + "/" + name + "?access_token=" + token
    
    let request = NSMutableURLRequest(URL: NSURL(string: url)!)
    var session = NSURLSession.sharedSession()
    var task = session.dataTaskWithRequest(request){(data, response, error) -> Void in
        
        if error != nil {
            
            callback(data, error)
            
        } else {
            
            callback(data, nil)
            
        }
    }
    
    task.resume()
}

func httpPost(name: String, parameters: String, callback: (NSData, NSError?) -> Void) {

    var postString = "access_token=" + token + "&" + parameters
    
    let url = "https://api.particle.io/v1/devices/" + device + "/" + name
    
    let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
    
    var session = NSURLSession.sharedSession()
    var task = session.dataTaskWithRequest(request){(data, response, error) -> Void in
        
        if error != nil {
            
            callback(data, error)
            
        } else {
            
            callback(data, nil)
            
        }
    }
    
    task.resume()
}