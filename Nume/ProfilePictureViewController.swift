//
//  ProfilePictureViewController.swift
//  Nume
//
//  Created by Jason Eng on 5/31/15.
//  Copyright (c) 2015 Daniel Hsu. All rights reserved.
//

import UIKit

class ProfilePictureViewController: UIViewController {
    
    @IBOutlet weak var profilePic: FBSDKProfilePictureView?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        // if there is NO user token, then show the login screen.
        // else, populate the profile picture and show logout button
        
        if (FBSDKAccessToken.currentAccessToken() == nil) {
            var login = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
            self.presentViewController(login, animated: true, completion: nil)
            
        } else {
            self.returnUserData()
            self.profilePic!.layer.cornerRadius = 75
            self.profilePic!.clipsToBounds = true
            self.profilePic!.layer.borderColor = UIColor.whiteColor().CGColor
            self.profilePic!.layer.borderWidth = 3.0

            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.frame = CGRectMake(28, 610, 319, 30)
            loginView.setTranslatesAutoresizingMaskIntoConstraints(true)
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User Logged Out")
        
    }
    
    // method to grab the Users Facebook data. You can call this method anytime after a user has logged in by calling self.returnUserData()
    func returnUserData() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil) {
                // Process error
                println("Error: \(error)")
            } else {
                println("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                println("User Name is: \(userName)")
                if let userEmail : NSString = result.valueForKey("email") as? NSString {
                    println("User Email is: \(userEmail)")
                }
                
                let appGroupID = "group.io.github.dhsu210.Nume"
                if let defaults = NSUserDefaults(suiteName: appGroupID) {
                    defaults.setValue(userName, forKey: "userNameKey")
                }
                
                let userEmail : NSString = result.valueForKey("email") as! NSString
                println("User Email is: \(userEmail)")
                
            }
        })
    }
}