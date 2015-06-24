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

class NewAccountViewController: UIViewController {
    
    var tmpUserName: String?
    @IBOutlet weak var tfname: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func nextAddPhotho(sender: AnyObject) {
        
        self.performSegueWithIdentifier("takePhotho", sender: self)
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var desitnationView: AvatarViewController = segue.destinationViewController as! AvatarViewController

        desitnationView.userName = self.tfname.text
        desitnationView.userEmail = self.tfEmail.text
        desitnationView.userPassword = self.tfPassword.text
    }
}