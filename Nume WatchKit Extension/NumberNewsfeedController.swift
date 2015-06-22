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
            
            
            // Placing dictation text and number rating into NSUserDefaults
            // Placing pulling user's FB profile picture image from NSUserDefaults
            let appGroupID = "group.io.github.dhsu210.Nume"
            let defaults = NSUserDefaults(suiteName: appGroupID)
            defaults!.setValue(val.userNumber, forKey: "userNumberKey")
            defaults!.setValue(val.userActivity, forKey: "userActivityKey")
            self.user.userToken = defaults!.integerForKey("userTokenKey")
            
            
            // Populate the last four users' rating numbers into the social feed view
            User.getLastFourUsers({ (users, error) -> Void in
                if let error = error {
                    println(error)
                } else {
                    self.friend1NumberResultLabel.setText("1")
                    self.friend2NumberResultLabel.setText("2")
                    self.friend3NumberResultLabel.setText("3")
                    self.friend4NumberResultLabel.setText("4")
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
    
    @IBAction func receiveUserDetailToSend() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let userDictionary = defaults.dictionaryRepresentation()
        
        NumberNewsfeedController.openParentApplication(userDictionary) {
            (replyDictionary, error) -> Void in
            
            if let castedResponseDictionary = replyDictionary as? [String: AnyObject],
                responseNumber = castedResponseDictionary["userNumberKey"] as? Int,
                responseActivity = castedResponseDictionary["userActivityKey"] as? String,
                responseName = castedResponseDictionary["userNameKey"] as? String
            {
                self.user.userName = responseName
                println("Congratulations, \(responseName) successfully rated a \(responseNumber) with '\(responseActivity)'")
            }
            self.pushControllerWithName("UserDetail", context: self.user)
        }
    }
   
}
