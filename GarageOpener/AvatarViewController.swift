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
    var imgObject = ImageResize()
    
    //MARK: Outlets
    @IBOutlet weak var msgSaving: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var btnSaveImage: UIButton!
    @IBOutlet weak var btnTakePhotho: UIButton!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func correctlyOrientedImage(image: UIImage) -> UIImage {
        if image.imageOrientation == UIImageOrientation.Up {
            return image
        }
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        image.drawInRect(CGRectMake(0, 0, image.size.width, image.size.height))
        var normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return normalizedImage;
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

        var smallImage = self.imgObject.resizeImage(imageView.image!, newSize: size)
        
        // Converting the image in to a JPG
        let imageData = UIImageJPEGRepresentation(self.correctlyOrientedImage(smallImage), 1.0)
        
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
                
                let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("mainView") as! UIViewController
                self.presentViewController(vc, animated: true, completion: nil)
            }
        }
    }
}