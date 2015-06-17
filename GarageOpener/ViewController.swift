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
        
        // Check if the app was run for the first time
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.stringForKey("userName") {
            
            httpGet("") { (data, error) -> Void in
                
                if error == nil {
                    
                    // If we have the remote connected to the internets, 
                    // then we can continue getting data and show the main interface.
                    if data["connected"] {
                        
                        println("Particle is Connected")
                        
                        var settings = AppSettings.sharedInstance

                        settings.get({ (result) -> Void in
                            println("Get - Response")
                            
                            dispatch_async(dispatch_get_main_queue()) {
                                println("MainTransition")
                                
                                self.performSegueWithIdentifier("mainTransition", sender: self)
                            }
                        })
                        
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
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("firstLogin", sender: self)
            }

        }
    }
}

