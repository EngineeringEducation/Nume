//
//  NumberNewsfeedController.swift
//  Nume
//
//  Created by Daniel Hsu on 5/8/15.
//  Copyright (c) 2015 Daniel Hsu. All rights reserved.
//

import Foundation
import WatchKit

class NumberNewsfeedController: WKInterfaceController {
    
    // Model
    var user : User?
    
    @IBOutlet weak var numberResultLabel: WKInterfaceLabel!
    @IBOutlet weak var dictationResultLabel: WKInterfaceLabel!
    @IBOutlet weak var userProfilePhoto: WKInterfaceButton!
    
    // Views
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Make sure data was passed properly and update the label accordingly
        if let val = context as? User {
            self.numberResultLabel.setText("\(val.userNumber)")
            self.dictationResultLabel.setText("\(val.userActivity)")
            

            // Placing dictation text and number rating into NSUserDefaults
            // Placing pulling user's FB profile picture image from NSUserDefaults
            let appGroupID = "group.io.github.dhsu210.Nume"
            if let defaults = NSUserDefaults(suiteName: appGroupID) {
                defaults.setValue(val.userNumber, forKey: "userNumberKey")
                defaults.setValue(val.userActivity, forKey: "userActivityKey")
//            self.userProfilePhoto.setBackgroundImage((defaults.objectForKey("userProfilePhotoKey") as! UIImage))
            }
            
            
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
    
    @IBAction func openParentAppToSend() {
        let defaults = NSUserDefaults.standardUserDefaults()        
        let userDictionary = defaults.dictionaryRepresentation()
        
        NumberNewsfeedController.openParentApplication(userDictionary) {
            (replyDictionary, error) -> Void in
            
            if let castedResponseDictionary = replyDictionary as? [String: AnyObject],
                responseNumber = castedResponseDictionary["userNumberKey"] as? Int,
                responseActivity = castedResponseDictionary["userActivityKey"] as? String
            {
                println("Congratulations, you successfully rated a \(responseNumber) with '\(responseActivity)'")
            }
        }
    }
   
}
