//
//  LoginViewController.swift
//  GarageOpener
//
//  Created by David Gatti on 6/25/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var tfUserEmail: UITextField!
    @IBOutlet weak var tfUserPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func actLogin(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(tfUserEmail.text, password:tfUserPassword.text) {
            (user: PFUser?, error: NSError?) -> Void in

            if user != nil {
                // Do stuff after successful
                
                let confirmed = user!["emailVerified"] as? Bool
                
                if confirmed == true {
                
                    self.performSegueWithIdentifier("backFromLogin", sender: self)
                } else {
                    
                    let email = user?.email
                    
                    user?.email = email
                    user?.save()
                    
                    self.performSegueWithIdentifier("resentEmailConfirmation", sender: self)
                    
                }
                
            } else {
                // The login failed. Check error to see why.
                
                println("The error occurd :)")
            }
        }
        
    }

}
