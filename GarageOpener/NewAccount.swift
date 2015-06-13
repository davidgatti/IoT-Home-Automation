//
//  NewAccount.swift
//  GarageOpener
//
//  Created by David Gatti on 6/13/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

import Foundation
import UIKit

class NewAccount: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtName.delegate = self;
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        println(textField.text!)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(textField.text, forKey: "name_preference")
        self.performSegueWithIdentifier("backFromNewAccount", sender: self)
    
        return true
    }
    
}