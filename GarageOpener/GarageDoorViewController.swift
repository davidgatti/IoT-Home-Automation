//
//  MainViewController.swift
//  GarageOpener
//
//  Created by David Gatti on 6/7/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

import UIKit
import Parse

class GarageDoorViewController: UIViewController {
    
    //MARK: Variables
    var garageState = GarageState.sharedInstance
    
    //MARK: Outlets
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var msgLastUser: UILabel!
    @IBOutlet weak var msgLastUserName: UILabel!
    @IBOutlet weak var msgLastDate: UILabel!
    @IBOutlet weak var msgUseCount: UILabel!
    @IBOutlet weak var btnOC: UIButton!
    @IBOutlet weak var avatar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask to be notyfied the app comes back from baground.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "willEnterForeground:", name: UIApplicationWillEnterForegroundNotification, object: nil)
        
        self.loda()
    }
    
    //MARK: Functions
    func loda() {

        var state = self.garageDoorState()
                
        dispatch_async(dispatch_get_main_queue()) {
            // Format and display the date based on the iPhone locale.
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.LongStyle
            formatter.timeStyle = .MediumStyle
            
            self.avatar.image = self.garageState.avatar
            self.msgLastUserName.text = self.garageState.lastUser
            self.msgLastUser.text = "was the last person to " + state.str + "."
            self.msgLastDate.text = formatter.stringFromDate(self.garageState.lastUsed)
            self.btnOC.setTitle(state.btn, forState: UIControlState.Normal)
            self.msgUseCount.text = String(self.garageState.useCount)
        }
    }
    
    // Returnign the state of the garage door
    func garageDoorState() -> (btn: String, str: String, open: Int){
        
        var btnState: String
        var strState: String
        var isOpen: Int
        
        if self.garageState.isOpen == 0 {
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
    
    //MARK: Actions
    @IBAction func openclose(sender: UIButton) {
        
        // Disable the interface while opening/closing
        sender.enabled = false
        spinner.hidden = false
        
        // Calling the Particle function responsabile for closing and opening the garage door
        httpPost("openclose", "") { (data, error) -> Void in
            
            if error != nil {
                
                println(error!.localizedDescription)
                
            } else {
                
                var state = self.garageDoorState()
                
                self.garageState.isOpen = state.open
                
                //Updatign the interface on the main queue
                dispatch_async(dispatch_get_main_queue()) {
                    
                    // Update the date to now.
                    let date = NSDate()
                    let formatter = NSDateFormatter()
                    formatter.dateStyle = .LongStyle
                    formatter.timeStyle = .LongStyle
                    formatter.stringFromDate(date)
                    
                    self.msgLastUserName.text = "You"
                    self.msgLastUser.text = "was the last person to " + state.str + "."
                    self.msgLastDate.text = formatter.stringFromDate(self.garageState.lastUsed)
                    sender.setTitle(state.btn, forState: UIControlState.Normal)
                    self.msgUseCount.text = String(self.garageState.useCount++)
                    
                    // Saving settings
                    self.garageState.set({ (result) -> Void in })
                    
                    // Reenable the user interface
                    sender.enabled = true
                    self.spinner.hidden = true
                }
            }
        }
    }
    
    deinit {
        // make sure to remove the observer when this view controller is dismissed/deallocated
        NSNotificationCenter.defaultCenter().removeObserver(self, name: nil, object: nil)
    }
}