//
//  MainViewController.swift
//  GarageOpener
//
//  Created by David Gatti on 6/7/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

import UIKit
import Parse

class MainViewController: UIViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var msgLastUser: UILabel!
    @IBOutlet weak var msgLastUserName: UILabel!
    @IBOutlet weak var msgLastDate: UILabel!
    @IBOutlet weak var msgUseCount: UILabel!
    @IBOutlet weak var btnOC: UIButton!
    
    var setting = AppSettings.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask to be notyfied the app comes back from baground.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "willEnterForeground:", name: UIApplicationWillEnterForegroundNotification, object: nil)
        
        self.loda()
    }
    
    func loda() {

        var state = self.GarageDoorState()
                
        dispatch_async(dispatch_get_main_queue()) {
            self.btnOC.setTitle(state.btn, forState: UIControlState.Normal)
            self.msgLastUser.text = "was the last person to " + state.str + "."
            self.msgLastUserName.text = self.setting.lastUser
            self.msgUseCount.text = String(self.setting.useCount)
            
            // Format and display the date based on the iPhone locale.
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
                
                var state = self.GarageDoorState()
                self.setting.isOpen = state.open
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    // Update the date to now.
                    let date = NSDate()
                    let formatter = NSDateFormatter()
                    formatter.dateStyle = .LongStyle
                    formatter.timeStyle = .LongStyle
                    formatter.stringFromDate(date)
                    
                    self.msgLastDate.text = formatter.stringFromDate(self.setting.lastUsed)
                    self.msgLastUser.text = "was the last person to " + state.str + "."
                    self.msgLastUserName.text = "You"
                    self.setting.useCount++
                    self.msgUseCount.text = String(self.setting.useCount)
                    
                    sender.setTitle(state.btn, forState: UIControlState.Normal)
                    
                    self.setting.set({ (result) -> Void in })
                    
                    sender.enabled = true
                    self.spinner.hidden = true
                    
                }
            }
        }
    }
    
    func GarageDoorState() -> (btn: String, str: String, open: Int){
        
        var btnState: String
        var strState: String
        var isOpen: Int
        
        if self.setting.isOpen == 0 {
            btnState = "Close"
            strState = "open"
            isOpen = 1
        } else {
            btnState = "Open"
            strState = "close"
            isOpen = 0
        }
        
        return (btnState, strState, isOpen)
        
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