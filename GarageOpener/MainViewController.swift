//
//  MainViewController.swift
//  GarageOpener
//
//  Created by David Gatti on 6/7/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var btnOpenClose: UIButton!
    @IBOutlet weak var msgLastUser: UILabel!
    @IBOutlet weak var msgLastUserName: UILabel!
    @IBOutlet weak var msgLastDate: UILabel!
    @IBOutlet weak var msgUseCount: UILabel!
    
    var setting = AppSettings.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask to be notyfied the app comes back from baground.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "willEnterForeground:", name: UIApplicationWillEnterForegroundNotification, object: nil)
        
        self.loda()
    
    }
    
    func loda() {

        var btnState: String
        var strState: String
        
        if self.setting.isOpen == 0 {
            
            btnState = "Open"
            strState = "close"
            self.setting.isOpen = 1
            
        } else {
            
            btnState = "Close"
            strState = "open"
            self.setting.isOpen = 0
            
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            self.btnOpenClose.setTitle(btnState, forState: UIControlState.Normal)
            self.msgLastUser.text = "was the last person to " + strState + "."
            self.msgLastUserName.text = self.setting.lastUser
            self.msgUseCount.text = String(self.setting.useCount)
            
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.LongStyle
            formatter.timeStyle = .MediumStyle
            
            self.msgLastDate.text = formatter.stringFromDate(self.setting.lastUsed)
        }
    }
    
    @IBAction func openclose(sender: UIButton) {
        
        sender.enabled = false
        spinner.hidden = false
        
        httpPost("openclose", "") { (data, error) -> Void in
            
            if error != nil {
                
                println(error!.localizedDescription)
                
            } else {
                
                var result = NSString(data: data, encoding: NSASCIIStringEncoding)!
                var btnState: String
                var strState: String
                
                if self.setting.isOpen == 0 {
                    btnState = "Close"
                    strState = "open"
                    
                } else {
                    btnState = "Open"
                    strState = "close"
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    sender.setTitle(btnState, forState: UIControlState.Normal)
                    
                    self.msgLastUser.text = "was the last person to " + strState + "."
                    self.msgLastUserName.text = "You"
                    self.msgLastDate.text = "Now"

                    self.setting.useCount++
                    self.msgUseCount.text = String(self.setting.useCount)
                    
                    sender.enabled = true
                    self.spinner.hidden = true
                    
                }
                
                if self.setting.isOpen == 0 {
                    self.setting.isOpen == 1
                } else {
                    self.setting.isOpen == 0
                }
                
                let defaults = NSUserDefaults.standardUserDefaults()
                let name = defaults.stringForKey("name_preference")!
                
                httpPost("incrementuse", "") { (data, error) -> Void in }
                httpPost("updatename", "args=" + name) { (data, error) -> Void in }
                
            }
        }
    }
    
    // Detect when the app coems back from the baground.
    func willEnterForeground(notification: NSNotification!) {
        self.performSegueWithIdentifier("backLoading", sender: self)
    }
    
    deinit {
        // make sure to remove the observer when this view controller is dismissed/deallocated
        NSNotificationCenter.defaultCenter().removeObserver(self, name: nil, object: nil)
    }
}