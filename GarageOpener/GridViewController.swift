//
//  GridViewController.swift
//  GarageOpener
//
//  Created by David Gatti on 6/28/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

import UIKit
import Parse

class GridViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func actWaterUsage(sender: AnyObject) {
        self.performSegueWithIdentifier("waterUsage", sender: self)
    }
    
    @IBAction func actGarageOpener(sender: AnyObject) {
        let garageState = GarageState.sharedInstance
        
        garageState.get({ (result) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("garageDoorControll", sender: self)
            }
        })
    }
}
