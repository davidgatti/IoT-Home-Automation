//
//  GridViewController.swift
//  GarageOpener
//
//  Created by David Gatti on 6/28/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

import UIKit
import Parse

class GridViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actGarageOpener(sender: AnyObject) {
        // First, lets check if Particle is connected.
        httpGet("") { (data, error) -> Void in
            
            if error == nil {
                
                // If we have the remote connected to the internets,
                // then we can continue getting data and show the main interface.
                if data["connected"]
                {
                    self.performSegueWithIdentifier("garageDoorControll", sender: self)
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
}
