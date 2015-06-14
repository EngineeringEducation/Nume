//
// FBLoginViewController.swift
// Nume 
// 
// Created by Jason Eng on 4/30/15. 
// Copyright (c) 2015 Daniel Hsu. All rights reserved. 
//

import UIKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    // Model
    var user: User!
    
    // Views
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let loginView : FBSDKLoginButton = FBSDKLoginButton()
        //old code here
        // loginView.frame = CGRectMake(28, 610, 319, 30)
        
        loginView.setTranslatesAutoresizingMaskIntoConstraints(true)
        self.view.addSubview(loginView)
        
        //make dictionary for constraints
        let viewsDictionary = ["loginView":loginView]
        
        //sizing constraints H (horizontal) and V (vertical)
        let loginViewSize_constraint_H:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:[loginView(>=319.0)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let loginViewSize_constraint_V:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[loginView(>=30.0)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        loginView.addConstraints(loginViewSize_constraint_H)
        loginView.addConstraints(loginViewSize_constraint_V)
        
        //positioning constraints
        let loginView_constraint_H:NSArray = NSLayoutConstraint.constraintsWithVisualFormat("H:|-60-[loginView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let loginView_constraint_V:NSArray = NSLayoutConstraint.constraintsWithVisualFormat("V:|-30-[loginView]-0-|", options: NSLayoutFormatOptions.AlignAllLeading, metrics: nil, views: viewsDictionary)
        // // loginView.addConstraints(loginViewconstraintH as [AnyObject]) // loginView.addConstraints(loginViewconstraintV as [AnyObject])
        
        //
        
        loginView.readPermissions = ["public_profile", "email", "user_friends"]
        loginView.delegate = self
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            // User is already logged in, do work such as go to next view controller.
            
            // Or Show Logout Button
            
            performSegueWithIdentifier("NextView", sender: nil)
            
        } else {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
            
        }
        
        println("testing viewDidLoad")
        
    }
    
    // Facebook Delegate Methods
    // helps you know if the user did login correctly and if they did you can grab their information.
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        println("User Logged In")
        performSegueWithIdentifier("NextView", sender: nil)
        
        if ((error) != nil) {
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
                
                // Send user data to server database
                User.postUser(userName as String, userEmail: userEmail as String)
                
                
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}