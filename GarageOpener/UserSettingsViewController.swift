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

    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var btnPhotho: UIButton!

    var user = User.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tfName.text = user.username
        self.tfEmail.text = user.email
    }
    
    // Make sure taht we update the new photho
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var image = UIImage(data: self.user.photho!)
        self.btnPhotho.setBackgroundImage(image, forState: UIControlState.Normal)
    }
    
    @IBAction func actCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    @IBAction func actSave(sender: AnyObject) {
        
        self.user.username = self.tfName.text
        self.user.email = self.tfEmail.text

        self.user.logOut()
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("credentialsNavigatin") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func logout(sender: AnyObject) {
        
        self.user.logOut()
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("credentialsNavigatin") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }

}
