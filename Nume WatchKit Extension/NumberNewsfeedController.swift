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
    var friend1 = User(userToken: 1, userNumber: 3, userActivity: "happy", userName: "Dummy", userEmail: "dummy@tradecrafted.com", userFacebookID: "12345")
    var friend2 = User(userToken: 1, userNumber: 3, userActivity: "happy", userName: "Dummy", userEmail: "dummy@tradecrafted.com", userFacebookID: "12345")
    var friend3 = User(userToken: 1, userNumber: 3, userActivity: "happy", userName: "Dummy", userEmail: "dummy@tradecrafted.com", userFacebookID: "12345")
    var friend4 = User(userToken: 1, userNumber: 3, userActivity: "happy", userName: "Dummy", userEmail: "dummy@tradecrafted.com", userFacebookID: "12345")
    
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
            let userFacebookID = Information.getFacebookID()
            loadProfileImage(userProfileImageBG, userID: userFacebookID)
            
            // Load four friends' profile pics and rating numbers
            User.getLastFourUsers { (users, error) -> Void in
                if let error = error {
                    println(error)
                } else {
                    
                    for index in 0...3 {
                        let friendName = users![index].userName! as String
                        let friendRating = users![index].userNumber! as Int
                        let friendActivity = users![index].userActivity! as String
                        let friendFacebookID = users![index].userFacebookID! as String
                        
                        if index == 0 {
                            self.friend1.userName = friendName
                            self.friend1.userNumber = friendRating
                            self.friend1.userActivity = friendActivity
                            self.friend1.userFacebookID = friendFacebookID
                            
                            self.friend1NumberResultLabel.setText("\(friendRating)")
                            self.loadProfileImage(self.friend1ProfileImageBG, userID: friendFacebookID)
                        } else if index == 1 {
                            self.friend2.userName = friendName
                            self.friend2.userNumber = friendRating
                            self.friend2.userActivity = friendActivity
                            self.friend2.userFacebookID = friendFacebookID
                            
                            self.friend2NumberResultLabel.setText("\(friendRating)")
                            self.loadProfileImage(self.friend2ProfileImageBG, userID: friendFacebookID)
                        } else if index == 2 {
                            self.friend3.userName = friendName
                            self.friend3.userNumber = friendRating
                            self.friend3.userActivity = friendActivity
                            self.friend3.userFacebookID = friendFacebookID
                            
                            self.friend3NumberResultLabel.setText("\(friendRating)")
                            self.loadProfileImage(self.friend3ProfileImageBG, userID: friendFacebookID)
                        } else if index == 3 {
                            self.friend4.userName = friendName
                            self.friend4.userNumber = friendRating
                            self.friend4.userActivity = friendActivity
                            self.friend4.userFacebookID = friendFacebookID
                            
                            self.friend4NumberResultLabel.setText("\(friendRating)")
                            self.loadProfileImage(self.friend4ProfileImageBG, userID: friendFacebookID)
                        }
                    }
                    
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
    
    
    @IBAction func receiveFriendOneDetailToSend() {
        self.pushControllerWithName("UserDetail", context: self.friend1)
    }
    @IBAction func receiveFriendFourDetailToSend() {
        self.pushControllerWithName("UserDetail", context: self.friend4)
    }
    @IBAction func receiveFriendThreeDetailToSend() {
        self.pushControllerWithName("UserDetail", context: self.friend3)
    }
    @IBAction func receiveFriendTwoDetailToSend() {
        self.pushControllerWithName("UserDetail", context: self.friend2)
    }
    
    @IBAction func receiveUserDetailToSend() {
        
        let rating = Information.getRating()
        let activity = Information.getActivity()
        let name = Information.getName()
        let facebookID = Information.getFacebookID()
        
        var thisUser : User = User(userNumber: rating, userActivity: activity, userName: name, userFacebookID: facebookID)
        self.pushControllerWithName("UserDetail", context: thisUser)
    }
    
//    var interfaceProperty: WKInterfaceButton {
//        User.getLastFourUsers { (users, error) -> Void in
//            if let error = error {
//                println(error)
//            } else {
//                
//                self.user.userNumber = users![0].userNumber
//                self.user.userActivity = users![0].userActivity
//                self.user.userName = users![0].userName
//                self.user.userFacebookID = users![0].userFacebookID
//                
//            }
//            
//        }
//        self.pushControllerWithName("UserDetail", context: self.user)
//        
//        return WKInterfaceButton()
//    }

}
   
    

