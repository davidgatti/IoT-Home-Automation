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
import ImageIO

class AvatarViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Variable
    var userID: String!
    var userName: String!
    var userEmail: String!
    var userPassword: String!
    
    //MARK: Constant
    let imagePicker = UIImagePickerController()
    
    //MARK: Outlets
    @IBOutlet weak var msgSaving: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var btnSaveImage: UIButton!
    @IBOutlet weak var btnTakePhotho: UIButton!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    //MARK: Functions
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
       
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func resizeImage(image: UIImage, newSize: CGSize) -> (UIImage) {
        
        let newRect = CGRectIntegral(CGRectMake(0,0, newSize.width, newSize.height))
        let imageRef = image.CGImage
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        // Set the quality level to use when rescaling
        CGContextSetInterpolationQuality(context, kCGInterpolationHigh)
        let flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height)
        
        CGContextConcatCTM(context, flipVertical)
        // Draw into the context; this scales the image
        CGContextDrawImage(context, newRect, imageRef)
        
        let newImageRef = CGBitmapContextCreateImage(context) as CGImage
        let newImage = UIImage(CGImage: newImageRef)
        
        // Get the resized image from the context and a UIImage
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    //MARK: Actions
    @IBAction func loadImageButtonTapped(sender: UIButton) {
        
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Front) != nil {
            
            // Use the camera if it exists
            
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            imagePicker.cameraDevice = UIImagePickerControllerCameraDevice.Front
            imagePicker.cameraCaptureMode = .Photo

        } else {
            
            // Use photho library if there is no camera
            
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .PhotoLibrary
        }
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveImage(sender: AnyObject) {
        
        // Disabling the interface interaction while saving.
        spinner.hidden = false
        msgSaving.hidden = false
        btnSaveImage.enabled = false
        btnTakePhotho.enabled = false
        
        // New size for the image
        var size: CGSize = CGSize(width: 100, height: 100)
        
        // Resizign the image
        var smallImage = resizeImage(imageView.image!, newSize: size)
        
        // Converting the image in to a JPG
        let imageData = UIImageJPEGRepresentation(smallImage, 1.0)
        
        // Converting the image in to a Pars file
        let imageFile = PFFile(name: "avatar.jpg", data: imageData)
        imageFile.save()
        
        // Making a Parse query
        let user = PFUser()
        user.username = self.userName
        user.email = self.userEmail
        user.password = self.userPassword
        user.setObject(imageFile, forKey: "profilePhotho")
        
        user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            if let error = error {
                let errorString = error.userInfo?["error"] as? NSString

                println(errorString)
                
            } else {
                
                let defaults = NSUserDefaults.standardUserDefaults()
                
                defaults.setValue(user.objectId!, forKey: "userID")
                
                self.performSegueWithIdentifier("backFromNewAccount", sender: self)
            }
        }
    }
}