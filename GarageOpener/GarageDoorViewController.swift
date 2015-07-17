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

        let state = self.garageDoorState()
                
        dispatch_async(dispatch_get_main_queue()) {
            // Format and display the date based on the iPhone locale.
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.LongStyle
            formatter.timeStyle = .MediumStyle
            
            //self.avatar.image = UIImage(data: (self.garageState.user.objectForKey("profilePhotho") as? PFFile)!.getData()!)
            self.msgLastUserName.text = self.garageState.user.username
            self.msgLastUser.text = "was the last person to " + state.str + "."
            self.msgLastDate.text = formatter.stringFromDate(self.garageState.lastUsed)
            self.btnOC.setTitle(state.btn, forState: UIControlState.Normal)
            self.msgUseCount.text = String(self.garageState.useCount)
        }
    }
    
    // Returnign the state of the garage door
    func garageDoorState() -> (btn: String, str: String){
        
        var btnState: String
        var strState: String
        
        if self.garageState.isOpen == 0 {
            btnState = "Close"
            strState = "open"
            self.garageState.isOpen = 1
        } else {
            btnState = "Open"
            strState = "close"
            self.garageState.isOpen = 0
        }
        
        return (btnState, strState)
        
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
        
        // First, lets check if Particle is connected.
        httpGet("") { (data, error) -> Void in
            
            if error == nil {
                
                // If we have the remote connected to the internets,
                // then we can continue getting data and show the main interface.
                if  data["connected"] {
                    // Calling the Particle function responsabile for closing and opening the garage door
                    httpPost("openclose", parameters: "") { (data, error) -> Void in
                        
                        if error != nil {
                            
                            print(error!.localizedDescription)
                            
                        } else {
                            
                            let state = self.garageDoorState()
                            
                            self.garageState.user = PFUser.currentUser()
                            
                            //Updatign the interface on the main queue
                            dispatch_async(dispatch_get_main_queue()) {
                                
                                // Update the date to now.
                                let date = NSDate()
                                let formatter = NSDateFormatter()
                                formatter.dateStyle = .LongStyle
                                formatter.timeStyle = .LongStyle
                                formatter.stringFromDate(date)
                                
                                self.avatar.image = UIImage(data: (self.garageState.user.objectForKey("profilePhotho") as? PFFile)!.getData()!)
                                self.msgLastUserName.text = self.garageState.user.username
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
                else
                {
                    dispatch_async(dispatch_get_main_queue()) {
                        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                        let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("errorView") as UIViewController
                        self.presentViewController(vc, animated: true, completion: nil)
                    }
                }
            }
            else
            {
                print(error!.localizedDescription)
            }
        }
        
        
    }
    
    deinit {
        // make sure to remove the observer when this view controller is dismissed/deallocated
        NSNotificationCenter.defaultCenter().removeObserver(self, name: nil, object: nil)
    }
}