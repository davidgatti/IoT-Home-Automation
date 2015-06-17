//
//  NewAccount.swift
//  GarageOpener
//
//  Created by David Gatti on 6/13/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

import Foundation
import UIKit
import Parse

class NewAccount: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtName.delegate = self;
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        let user = PFObject(className: "Users")
        user["name"] = textField.text!
        user.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue(textField.text, forKey: "userName")
            defaults.setValue(user.objectId!, forKey: "userID")
            
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("takePhotho", sender: self)
            }
        }
        
        return true
    }
    
}