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
            loadFriendsDetailsFromPhone()
            
        } else {
            self.numberResultLabel.setText("")
        }
    }
    
    func loadFriendsDetailsFromPhone() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let userDictionary = defaults.dictionaryRepresentation()
        
        NumberNewsfeedController.openParentApplication(userDictionary) {
            (replyDictionary, error) -> Void in
            
            if let castedResponseDictionary = replyDictionary as? [String: AnyObject] {
                
                let friend1Name = castedResponseDictionary["friend1NameKey"] as! String
                let friend1Rating = castedResponseDictionary["friend1RatingKey"] as! Int
                let friend1Activity = castedResponseDictionary["friend1ActivityKey"] as! String
                let friend1FacebookID = castedResponseDictionary["friend1FacebookIDKey"] as! String
                
                self.friend1NumberResultLabel.setText("\(friend1Rating)")
                self.loadProfileImage(self.friend1ProfileImageBG, userID: friend1FacebookID)
                
                let friend2Name = castedResponseDictionary["friend2NameKey"] as! String
                let friend2Rating = castedResponseDictionary["friend2RatingKey"] as! Int
                let friend2Activity = castedResponseDictionary["friend2ActivityKey"] as! String
                let friend2FacebookID = castedResponseDictionary["friend2FacebookIDKey"] as! String
                
                self.friend2NumberResultLabel.setText("\(friend2Rating)")
                self.loadProfileImage(self.friend2ProfileImageBG, userID: friend2FacebookID)
                
                let friend3Name = castedResponseDictionary["friend3NameKey"] as! String
                let friend3Rating = castedResponseDictionary["friend3RatingKey"] as! Int
                let friend3Activity = castedResponseDictionary["friend3ActivityKey"] as! String
                let friend3FacebookID = castedResponseDictionary["friend3FacebookIDKey"] as! String
                
                self.friend3NumberResultLabel.setText("\(friend3Rating)")
                self.loadProfileImage(self.friend3ProfileImageBG, userID: friend3FacebookID)
                
                let friend4Name = castedResponseDictionary["friend4NameKey"] as! String
                let friend4Rating = castedResponseDictionary["friend4RatingKey"] as! Int
                let friend4Activity = castedResponseDictionary["friend4ActivityKey"] as! String
                let friend4FacebookID = castedResponseDictionary["friend4FacebookIDKey"] as! String
                
                self.friend4NumberResultLabel.setText("\(friend4Rating)")
                self.loadProfileImage(self.friend4ProfileImageBG, userID: friend4FacebookID)
                
                // Insert friends data into App Group
                let appGroupID = "group.io.github.dhsu210.Nume"
                let defaultGroup = NSUserDefaults(suiteName: appGroupID)
                
                defaultGroup!.setValue(friend1Name, forKey: "friend1NameKey")
                defaultGroup!.setValue(friend1Rating, forKey: "friend1RatingKey")
                defaultGroup!.setValue(friend1Activity, forKey: "friend1ActivityKey")
                defaultGroup!.setValue(friend1FacebookID, forKey: "friend1FacebookIDKey")
                
                defaultGroup!.setValue(friend2Name, forKey: "friend2NameKey")
                defaultGroup!.setValue(friend2Rating, forKey: "friend2RatingKey")
                defaultGroup!.setValue(friend2Activity, forKey: "friend2ActivityKey")
                defaultGroup!.setValue(friend2FacebookID, forKey: "friend2FacebookIDKey")
                
                defaultGroup!.setValue(friend3Name, forKey: "friend3NameKey")
                defaultGroup!.setValue(friend3Rating, forKey: "friend3RatingKey")
                defaultGroup!.setValue(friend3Activity, forKey: "friend3ActivityKey")
                defaultGroup!.setValue(friend3FacebookID, forKey: "friend3FacebookIDKey")
                
                defaultGroup!.setValue(friend4Name, forKey: "friend4NameKey")
                defaultGroup!.setValue(friend4Rating, forKey: "friend4RatingKey")
                defaultGroup!.setValue(friend4Activity, forKey: "friend4ActivityKey")
                defaultGroup!.setValue(friend4FacebookID, forKey: "friend4FacebookIDKey")
            }
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
    
    
    @IBAction func receiveFriendOneDetailToSend() {
        let appGroupID = "group.io.github.dhsu210.Nume"
        let defaultGroup = NSUserDefaults(suiteName: appGroupID)
        
        let rating = defaultGroup!.valueForKey("friend1RatingKey") as! Int
        let activity = defaultGroup!.valueForKey("friend1ActivityKey") as! String
        let name = defaultGroup!.valueForKey("friend1NameKey") as! String
        let facebookID = defaultGroup!.valueForKey("friend1FacebookIDKey") as! String
        
        var friendOne : User = User(userNumber: rating, userActivity: activity, userName: name, userFacebookID: facebookID)
        self.pushControllerWithName("UserDetail", context: friendOne)
    }
    @IBAction func receiveFriendTwoDetailToSend() {
        let appGroupID = "group.io.github.dhsu210.Nume"
        let defaultGroup = NSUserDefaults(suiteName: appGroupID)
        
        let rating = defaultGroup!.valueForKey("friend2RatingKey") as! Int
        let activity = defaultGroup!.valueForKey("friend2ActivityKey") as! String
        let name = defaultGroup!.valueForKey("friend2NameKey") as! String
        let facebookID = defaultGroup!.valueForKey("friend2FacebookIDKey") as! String
        
        var friendTwo : User = User(userNumber: rating, userActivity: activity, userName: name, userFacebookID: facebookID)
        self.pushControllerWithName("UserDetail", context: friendTwo)
    }
    @IBAction func receiveFriendThreeDetailToSend() {
        let appGroupID = "group.io.github.dhsu210.Nume"
        let defaultGroup = NSUserDefaults(suiteName: appGroupID)
        
        let rating = defaultGroup!.valueForKey("friend3RatingKey") as! Int
        let activity = defaultGroup!.valueForKey("friend3ActivityKey") as! String
        let name = defaultGroup!.valueForKey("friend3NameKey") as! String
        let facebookID = defaultGroup!.valueForKey("friend3FacebookIDKey") as! String
        
        var friendThree : User = User(userNumber: rating, userActivity: activity, userName: name, userFacebookID: facebookID)
        self.pushControllerWithName("UserDetail", context: friendThree)
    }
    @IBAction func receiveFriendFourDetailToSend() {
        let appGroupID = "group.io.github.dhsu210.Nume"
        let defaultGroup = NSUserDefaults(suiteName: appGroupID)
        
        let rating = defaultGroup!.valueForKey("friend4RatingKey") as! Int
        let activity = defaultGroup!.valueForKey("friend4ActivityKey") as! String
        let name = defaultGroup!.valueForKey("friend4NameKey") as! String
        let facebookID = defaultGroup!.valueForKey("friend4FacebookIDKey") as! String
        
        var friendFour : User = User(userNumber: rating, userActivity: activity, userName: name, userFacebookID: facebookID)
        self.pushControllerWithName("UserDetail", context: friendFour)
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
   
}
