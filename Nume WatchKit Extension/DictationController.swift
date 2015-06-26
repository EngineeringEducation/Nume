//
//  DictationController.swift
//  Nume WatchKit Extension
//
//  Created by Daniel Hsu on 5/12/15.
//  Copyright (c) 2015 Daniel Hsu. All rights reserved.
//

import WatchKit
import NumeKit
import Foundation

class DictationController: WKInterfaceController {

    // Model
    var user : User!
    @IBOutlet weak var microphoneButton: WKInterfaceButton!
    
    // Views
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Pass in user data from previous interface controller
        user = context as! User

        
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
    
    //create microphone button image and link to dictation
    @IBAction func onVoiceDictationTap() {
        presentTextInputControllerWithSuggestions(nil, allowedInputMode: .Plain)
            {(input) -> Void in
                println("INPUT: \(input)")
                if (input == nil) {
                    return
                }
                self.user!.userActivity! = input[0] as! String
                
                // Placing dictation text and number rating into NSUserDefaults
                let appGroupID = "group.io.github.dhsu210.Nume"
                let defaults = NSUserDefaults(suiteName: appGroupID)
                defaults!.setValue(self.user!.userNumber, forKey: "userNumberKey")
                defaults!.setValue(self.user!.userActivity, forKey: "userActivityKey")
                
                // Pulls username from logged in FB account on iPhone and sends userRating and userActivity to be posted via iPhone to server
                let defaultConnect = NSUserDefaults.standardUserDefaults()
                let userDictionary = defaultConnect.dictionaryRepresentation()
                NumberNewsfeedController.openParentApplication(userDictionary) {
                    (replyDictionary, error) -> Void in
                    
                    if let castedResponseDictionary = replyDictionary as? [String: AnyObject],
                        responseName = castedResponseDictionary["userNameKey"] as? String
                    {
                        self.user.userName = responseName
                        println("Congratulations, \(responseName) successfully rated a \(self.user!.userNumber!) with '\(self.user!.userActivity!)'")
                    }
                }

                
                self.pushControllerWithName("SocialFeed", context: self.user)
        }
        

        
    }

}
