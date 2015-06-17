//
//  Avatar.swift
//  GarageOpener
//
//  Created by David Gatti on 6/16/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

import Foundation
import UIKit
import Parse

class Avatar: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var msgSaving: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var btnSaveImage: UIButton!
    @IBOutlet weak var btnTakePhotho: UIButton!
    @IBOutlet var imageView: UIImageView!
    
    //MARK: Constant
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("I'm Here")
        imagePicker.delegate = self
        
    }
    
    //MARK: Actions
    @IBAction func loadImageButtonTapped(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: Functions
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
        
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
        
        }
        
        dismissViewControllerAnimated(true, completion: nil)

    }
    
    @IBAction func saveImage(sender: AnyObject) {
        
        spinner.hidden = false
        msgSaving.hidden = false
        btnSaveImage.enabled = false
        btnTakePhotho.enabled = false
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let userID = defaults.stringForKey("userID")
        
        let imageData = UIImagePNGRepresentation(imageView.image)
        let imageFile:PFFile = PFFile(data: imageData)
        
        var query = PFObject(withoutDataWithClassName: "Users", objectId: userID)
        query["avatar"] = imageFile
        query.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            self.performSegueWithIdentifier("backFromNewAccount", sender: self)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}