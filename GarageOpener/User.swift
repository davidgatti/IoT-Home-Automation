//
//  User.swift
//  GarageOpener
//
//  Created by David Gatti on 6/29/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

import UIKit
import Parse

class User {

    // Singleton
    
    static let sharedInstance = User()
    
    // Initialize the current user
    private var user = PFUser.currentUser()
    
    // Temp var to be set when new data comes in
    private var tmpUsername: String!
    private var tmpEmail: String!
    private var tmpPhotho: NSData!
    
    // Store the Username
    var username: String? {
        get {
            return self.tmpUsername
        }
        set(newValue) {
            self.tmpUsername = newValue
            save()
        }
    }
    
    // Store new data when it is comming in
    var email: String? {
        get {
            return self.tmpEmail
        }
        set(newValue) {
            self.tmpEmail = newValue
            save()
        }
    }
    
    // Store the image
    var photho: NSData? {
        get {
            return self.tmpPhotho
        }
        set(newValue) {
            self.tmpPhotho = newValue
            save()
        }
    }
    
    init() {
        
        println("Init")
        
        println("User Name: " + self.user!.username!)
        println("Email: " + self.user!.email!)
        
        self.tmpUsername = self.user!.username
        self.tmpEmail = self.user!.email
        self.tmpPhotho = (self.user!.objectForKey("profilePhotho") as? PFFile)!.getData()
    }
    
    private func save() {
        
        println("Saving")
        
        println("User Name: " + self.tmpUsername)
        println("Email: " + self.tmpEmail!)
        
        
        let imageFile = PFFile(name: "avatar.jpg", data: self.tmpPhotho)
        imageFile.save()
        
        self.user?.username = self.tmpUsername
        self.user?.email = self.tmpEmail
        self.user?.setObject(imageFile, forKey: "profilePhotho")
        self.user?.saveInBackground()
    }
    
    func logOut() {
        PFUser.logOut()
    }
}
