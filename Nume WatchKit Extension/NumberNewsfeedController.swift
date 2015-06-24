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
    @IBOutlet weak var userProfilePhoto: WKInterfaceButton!
    @IBOutlet weak var userProfileImage: WKInterfaceImage!
    
    @IBOutlet weak var friend1ProfilePhoto: WKInterfaceButton!
    @IBOutlet weak var friend1NumberResultLabel: WKInterfaceLabel!
    
    @IBOutlet weak var friend2ProfilePhoto: WKInterfaceButton!
    @IBOutlet weak var friend2NumberResultLabel: WKInterfaceLabel!
    
    @IBOutlet weak var friend3ProfilePhoto: WKInterfaceButton!
    @IBOutlet weak var friend3NumberResultLabel: WKInterfaceLabel!
    
    @IBOutlet weak var friend4ProfilePhoto: WKInterfaceButton!
    @IBOutlet weak var friend4NumberResultLabel: WKInterfaceLabel!
    
    
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
            self.user.userFacebookID = defaults!.stringForKey("userFBProfilePicIDKey")
            let profileURL = "http://graph.facebook.com/\(self.user.userFacebookID!)/picture?width=40&height=40"
            loadImage(profileURL, forImageView: userProfileImage)
            

            
            // Populate the last four users' rating numbers into the social feed view
            User.getLastFourUsers({ (users, error) -> Void in
                if let error = error {
                    println(error)
                } else {
                    
                    let ratingOne = users![0].userNumber!
                    self.friend1NumberResultLabel.setText("\(ratingOne)")
                    
                    let ratingTwo = users![1].userNumber!
                    self.friend2NumberResultLabel.setText("\(ratingTwo)")
                    
                    let ratingThree = users![2].userNumber!
                    self.friend3NumberResultLabel.setText("\(ratingThree)")
                    
                    let ratingFour = users![3].userNumber!
                    self.friend4NumberResultLabel.setText("\(ratingFour)")
                }
            })
            
        } else {
            self.numberResultLabel.setText("")
        }
        
        
    }
    
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
    
    func loadImage(url:String, forImageView: WKInterfaceImage) {
        // load image
        let image_url:String = url
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let url:NSURL = NSURL(string:image_url)!
            var data:NSData = NSData(contentsOfURL: url)!
            var placeholder = UIImage(data: data)!
            
            // update ui
            dispatch_async(dispatch_get_main_queue()) {
                forImageView.setImage(placeholder)
            }
        }
        
    }
    
    // Actions to reveal further user details
    func insertUserDetailsIntoUser(index: Int) {
        User.getLastFourUsers { (users, error) -> Void in
            if let error = error {
                println(error)
            } else {
                self.user.userName = users![index].userName!
                self.user.userNumber = users![index].userNumber!
                self.user.userActivity = users![index].userActivity!
            }
        }
    }
    
    @IBAction func receiveFriendOneDetailToSend() {
        self.insertUserDetailsIntoUser(0)
        self.pushControllerWithName("UserDetail", context: self.user )
    }
    @IBAction func receiveFriendTwoDetailToSend() {
        self.insertUserDetailsIntoUser(1)
        self.pushControllerWithName("UserDetail", context: self.user )
    }
    @IBAction func receiveFriendThreeDetailToSend() {
        self.insertUserDetailsIntoUser(2)
        self.pushControllerWithName("UserDetail", context: self.user )
    }
    @IBAction func receiveFriendFourDetailToSend() {
        self.insertUserDetailsIntoUser(3)
        self.pushControllerWithName("UserDetail", context: self.user )
    }
    @IBAction func receiveUserDetailToSend() {
        self.pushControllerWithName("UserDetail", context: self.user )
    }
   
}
