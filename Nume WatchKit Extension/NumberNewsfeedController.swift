//
//  NumberNewsfeedController.swift
//  Nume
//
//  Created by Daniel Hsu on 5/8/15.
//  Copyright (c) 2015 Daniel Hsu. All rights reserved.
//

import Foundation
import NumeKit
import WatchKit

class NumberNewsfeedController: WKInterfaceController {
    
    // Model
    var user : User!
    
    @IBOutlet weak var numberResultLabel: WKInterfaceLabel!
    @IBOutlet weak var dictationResultLabel: WKInterfaceLabel!
    @IBOutlet weak var userProfileButton: WKInterfaceButton!
    @IBOutlet weak var userProfileImageBG: WKInterfaceGroup!
    
    @IBOutlet weak var friend1NumberResultLabel: WKInterfaceLabel!
    @IBOutlet weak var friend1ProfileButton: WKInterfaceButton!
    @IBOutlet weak var friend1ProfileImageBG: WKInterfaceGroup!
    
    @IBOutlet weak var friend2NumberResultLabel: WKInterfaceLabel!
    @IBOutlet weak var friend2ProfileButton: WKInterfaceButton!
    @IBOutlet weak var friend2ProfileImageBG: WKInterfaceGroup!
    
    @IBOutlet weak var friend3NumberResultLabel: WKInterfaceLabel!
    @IBOutlet weak var friend3ProfileButton: WKInterfaceButton!
    @IBOutlet weak var friend3ProfileImageBG: WKInterfaceGroup!
    
    @IBOutlet weak var friend4NumberResultLabel: WKInterfaceLabel!
    @IBOutlet weak var friend4ProfileButton: WKInterfaceButton!
    @IBOutlet weak var friend4ProfileImageBG: WKInterfaceGroup!
    
    // Views
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Pass in user data from previous interface controller
        user = context as! User
        
        // Make sure data was passed properly and update the label accordingly
        if let val = user {
            self.numberResultLabel.setText("\(val.userNumber!)")
            self.dictationResultLabel.setText("\(val.userActivity!)")
            
            // Load user FB profile pic
            let appGroupID = "group.io.github.dhsu210.Nume"
            let defaults = NSUserDefaults(suiteName: appGroupID)
            let userFacebookID = defaults!.valueForKey("userFacebookIDKey") as! String
            loadProfileImage(userProfileImageBG, userID: userFacebookID)
            
            // Load four friends' profile pics and rating numbers
            User.getLastFourUsers { (users, error) -> Void in
                if let error = error {
                    println(error)
                } else {
                    
                    let friend1Rating = users![0].userNumber
                    println(friend1Rating)
                    let friend1FacebookID = users![0].userFacebookID
    
                    self.friend1NumberResultLabel.setText("\(friend1Rating!)")
                    self.loadProfileImage(self.friend1ProfileImageBG, userID: friend1FacebookID!)
    
                    let friend2Rating = users![1].userNumber
                    println(friend2Rating)
                    let friend2FacebookID = users![1].userFacebookID
    
                    self.friend2NumberResultLabel.setText("\(friend2Rating!)")
                    self.loadProfileImage(self.friend2ProfileImageBG, userID: friend2FacebookID!)
    
                    let friend3Rating = users![2].userNumber
                    let friend3FacebookID = users![2].userFacebookID
    
                    self.friend3NumberResultLabel.setText("\(friend3Rating!)")
                    self.loadProfileImage(self.friend3ProfileImageBG, userID: friend3FacebookID!)
    
                    let friend4Rating = users![3].userNumber
                    let friend4FacebookID = users![3].userFacebookID
                    
                    self.friend4NumberResultLabel.setText("\(friend4Rating!)")
                    self.loadProfileImage(self.friend4ProfileImageBG, userID: friend4FacebookID!)
                    
                }
            }

            
        } else {
            self.numberResultLabel.setText("")
        }
    }
    
    
    func loadProfileImage(profileImage : WKInterfaceGroup, userID : String) {
        let profileURL = "http://graph.facebook.com/\(userID)/picture?width=40&height=40" as NSString
        let url: NSURL = NSURL(string: profileURL as String)!
        var data: NSData = NSData(contentsOfURL: url)!
        profileImage.setBackgroundImageData(data)
    }
    
    // Note to fix: should I be including async dispatching to quicken the image load times as below?
    //    func loadImage(url:String, forImageView: WKInterfaceImage) {
    //        // load image
    //        let image_url:String = url
    //        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
    //            let url:NSURL = NSURL(string:image_url)!
    //            var data:NSData = NSData(contentsOfURL: url)!
    //            var placeholder = UIImage(data: data)!
    //
    //            // update ui
    //            dispatch_async(dispatch_get_main_queue()) {
    //                forImageView.setImage(placeholder)
    //            }
    //        }
    //        
    //    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        return self.user
    }
    
    
    @IBAction func receiveFriendFourDetailToSend() {
        User.getLastFourUsers { (users, error) -> Void in
            if let error = error {
                println(error)
            } else {
                
                self.user.userNumber = users![3].userNumber
                self.user.userActivity = users![3].userActivity
                self.user.userName = users![3].userName
                self.user.userFacebookID = users![3].userFacebookID
            }
            
        }
        
        self.pushControllerWithName("UserDetail", context: self.user)
    }
    @IBAction func receiveFriendThreeDetailToSend() {
        User.getLastFourUsers { (users, error) -> Void in
            if let error = error {
                println(error)
            } else {
                
                self.user.userNumber = users![2].userNumber
                self.user.userActivity = users![2].userActivity
                self.user.userName = users![2].userName
                self.user.userFacebookID = users![2].userFacebookID
            }
            
        }
        self.pushControllerWithName("UserDetail", context: self.user)
    }
    @IBAction func receiveFriendTwoDetailToSend() {
        User.getLastFourUsers { (users, error) -> Void in
            if let error = error {
                println(error)
            } else {
                
                self.user.userNumber = users![1].userNumber
                self.user.userActivity = users![1].userActivity
                self.user.userName = users![1].userName
                self.user.userFacebookID = users![1].userFacebookID
                
            }
            
        }
        
        self.pushControllerWithName("UserDetail", context: self.user)
    }
    
    @IBAction func receiveUserDetailToSend() {
        let appGroupID = "group.io.github.dhsu210.Nume"
        let defaultGroup = NSUserDefaults(suiteName: appGroupID)
        
        let rating = defaultGroup!.valueForKey("userNumberKey") as! Int
        let activity = defaultGroup!.valueForKey("userActivityKey") as! String
        let name = defaultGroup!.valueForKey("userNameKey") as! String
        let facebookID = defaultGroup!.valueForKey("userFacebookIDKey") as! String
        
        var thisUser : User = User(userNumber: rating, userActivity: activity, userName: name, userFacebookID: facebookID)
        self.pushControllerWithName("UserDetail", context: thisUser)
    }
    
    @IBAction func receiveFriendOneDetailToSend() {
        User.getLastFourUsers { (users, error) -> Void in
            if let error = error {
                println(error)
            } else {
                
                self.user.userNumber = users![0].userNumber
                self.user.userActivity = users![0].userActivity
                self.user.userName = users![0].userName
                self.user.userFacebookID = users![0].userFacebookID
                
            }
            
        self.pushControllerWithName("UserDetail", context: self.user)
    }
    
   
    }
}
