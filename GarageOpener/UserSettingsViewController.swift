//
//  UserSettingsViewController.swift
//  GarageOpener
//
//  Created by David Gatti on 6/28/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

import UIKit
import Parse

class UserSettingsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func actCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    @IBAction func actSave(sender: AnyObject) {
    
    }
    
    @IBAction func logout(sender: AnyObject) {
        
        PFUser.logOut()
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("credentialsNavigatin") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }

}
