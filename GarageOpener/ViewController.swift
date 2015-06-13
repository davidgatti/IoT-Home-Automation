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
        
        // Check if the app was run for the first time
        if let name = defaults.stringForKey("name_preference") {
            
            httpGet("") { (data, error) -> Void in
                
                if error == nil {
                    
                    if data["connected"] {
                        
                        httpGet("username") { (data, error) -> Void in
                            
                            if error == nil {
                                
                                var setting = AppSettings.sharedInstance
                                let userName:JSON = data["result"]
                                let lastUsed:JSON = data["coreInfo"]["last_heard"]

                                setting.lastUser = userName.string!
                                setting.lastUsed = lastUsed.string!
                                
                                httpGet("isopen") { (data, error) -> Void in
                                    
                                    if error == nil {
                                        
                                        var setting = AppSettings.sharedInstance
                                        let isOpen:JSON = data["result"]
                                        
                                        setting.isOpen = isOpen.int!
                                        
                                        httpGet("usecount") { (data, error) -> Void in
                                            
                                            if error == nil {
                                                
                                                var setting = AppSettings.sharedInstance
                                                let useCount:JSON = data["result"]
                                                
                                                setting.useCount = useCount.int!
                                                
                                                dispatch_async(dispatch_get_main_queue()) {
                                                    self.performSegueWithIdentifier("mainTransition", sender: self)
                                                }
                                                
                                            }
                                            else
                                            {
                                                println(error!.localizedDescription)
                                            }
                                        }
                                    }
                                    else
                                    {
                                        println(error!.localizedDescription)
                                    }
                                }
                            }
                            else
                            {
                                println(error!.localizedDescription)
                            }
                        }
                    }
                    else
                    {
                        dispatch_async(dispatch_get_main_queue()) {
                            self.performSegueWithIdentifier("errorTransition", sender: self)
                        }
                    }
                }
                else
                {
                    println(error!.localizedDescription)
                }
            }
        }
        else
        {
            UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
        }
    }
}

