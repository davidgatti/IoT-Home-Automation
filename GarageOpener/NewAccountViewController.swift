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

class NewAccountViewController: UIViewController, UITextFieldDelegate {
    
    var tmpUserID: String?
    var tmpUserName: String?
    
    @IBOutlet weak var txtName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtName.delegate = self;
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        let user = PFObject(className: "Users")

        user["name"] = textField.text!
        user.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            self.tmpUserName = textField.text
            self.tmpUserID = user.objectId!
            
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("takePhotho", sender: self)
            }
        }
        
        return true
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var desitnationView: AvatarViewController = segue.destinationViewController as! AvatarViewController
        
        desitnationView.userID = self.tmpUserID
        desitnationView.userName = self.tmpUserName
    }
}