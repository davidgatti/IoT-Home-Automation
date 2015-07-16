//
//  ResetPasswordViewController.swift
//  GarageOpener
//
//  Created by David Gatti on 6/27/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

import UIKit
import Parse

class ResetPasswordViewController: UIViewController {


    @IBOutlet weak var tfEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func actReset(sender: AnyObject) {
    
        PFUser.requestPasswordResetForEmailInBackground(tfEmail.text!)
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("mainView") as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
}
