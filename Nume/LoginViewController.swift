//
//  FBLoginViewController.swift
//  Nume
//
//  Created by Jason Eng on 4/30/15.
//  Copyright (c) 2015 Daniel Hsu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var profilePic: FBSDKProfilePictureView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.profilePic!.layer.cornerRadius = 75
        self.profilePic!.clipsToBounds = true
        self.profilePic!.layer.borderColor = UIColor.blackColor().CGColor
        self.profilePic!.layer.borderWidth = 1.0

        
        let loginView = FBSDKLoginButton()
        self.view.addSubview(loginView)
        loginView.center = self.view.center
        loginView.delegate = self
        loginView.readPermissions = ["public_profile", "email", "user_friends"]
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
            // Or Show Logout Button
            self.returnUserData()
        }
        
        self.profilePic = FBSDKProfilePictureView()
        
        
    }
    // Facebook Delegate Methods
    // helps you know if the user did login correctly and if they did you can grab their information.
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        println("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
            
            self.returnUserData()
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User Logged Out")
    }
    
    // method to grab the Users Facebook data. You can call this method anytime after a user has logged in by calling self.returnUserData()
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                println("Error: \(error)")
            }
            else
            {
                println("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                println("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                println("User Email is: \(userEmail)")

            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateExtension() {
        // Prepare and send dictionary with NSUserDefaults data
        let appGroupID = "group.io.github.dhsu210.Nume"
        let defaults = NSUserDefaults(suiteName: appGroupID)
        let number = defaults!.stringForKey("userNumberKey")
        let activity = defaults!.stringForKey("userActivityKey")
    }
    
}