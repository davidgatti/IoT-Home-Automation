//
//  ViewController.swift
//  GarageOpener
//
//  Created by David Gatti on 6/5/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

import UIKit
import Parse

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentUser = PFUser.currentUser()
        if currentUser != nil {
            
//            let garageState = GarageState.sharedInstance
//            garageState.get({ (result) -> Void in })
            
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("gridView", sender: self)
            }
            
        }
        else
        {
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("decisionView", sender: self)
            }
        }
    }
}

