//
//  TakePhothoViewController.swift
//  GarageOpener
//
//  Created by David Gatti on 6/29/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

import UIKit

class TakePhothoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var ivPhotho: UIImageView!
    var user = User.sharedInstance
    
    //MARK: Constant
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
    }
    
    //MARK: Functions
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            ivPhotho.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: Actions
    
    @IBAction func actSave(sender: AnyObject) {
        
        var size: CGSize = CGSize(width: 100, height: 100)
        var img = ImageResize()
        var smallImage = img.resizeImage(ivPhotho.image!, newSize: size)
        
        // Converting the image in to a JPG
        let imageData = UIImageJPEGRepresentation(smallImage, 1.0)
        
        user.photho = imageData
        
        // Load the storry board and select the right view.
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("settings") as! UIViewController
        
        // Dismiss this veiw to keep the right history of views
        self.dismissViewControllerAnimated(true, completion: nil)
        
        // Transition to the next view
        self.presentViewController(vc, animated: true, completion: nil)
        
    }

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

}
