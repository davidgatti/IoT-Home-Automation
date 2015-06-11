//
//  ViewController.swift
//  GarageOpener
//
//  Created by David Gatti on 6/5/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let name = defaults.stringForKey("name_preference") {
            
            httpGet("") { (data, error) -> Void in
                
                if error != nil {
                    
                    println(error!.localizedDescription)
                    
                } else {
                    
                    var result = NSString(data: data, encoding: NSASCIIStringEncoding)!
                    
                    var json = JSON(data: data)
                    
                    if !json["connected"] {
                        
                        self.performSegueWithIdentifier("errorTransition", sender: self)
                        
                    } else {
                        httpGet("username") { (data, error) -> Void in
                            
                            if error != nil {
                                
                                println(error!.localizedDescription)
                                
                            } else {
                                
                                var result = NSString(data: data, encoding: NSASCIIStringEncoding)!
                                var json = JSON(data: data)
                                
                                var setting = AppSettings.sharedInstance
                                let userName:JSON = json["result"]
                                setting.lastUser = userName.string!
                                
                                self.performSegueWithIdentifier("mainTransition", sender: self)
                            }
                        }
                    }
                }
            }
            
        } else {
            
            UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
            
        }
    }
}

