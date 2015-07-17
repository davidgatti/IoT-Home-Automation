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
        
        print("User: " + tfUserEmail.text!)
        print("Password: " + tfUserPassword.text!)
        
        PFUser.logInWithUsernameInBackground(tfUserEmail.text!, password:tfUserPassword.text!) {
            (user: PFUser?, error: NSError?) -> Void in

            if user != nil {
                // Do stuff after successful
                
                let confirmed = user!["emailVerified"] as? Bool
                
                if confirmed == true {
                
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                    let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("mainView") as UIViewController
                    self.presentViewController(vc, animated: true, completion: nil)
                    
                } else {
                    
                    let email = user?.email
                    
                    user?.email = email
                    user?.save()
                    
                    self.performSegueWithIdentifier("resentEmailConfirmation", sender: self)
                    
                }
                
            } else {
                // The login failed. Check error to see why.
                
                print(error)
            }
        }
        
    }

}
