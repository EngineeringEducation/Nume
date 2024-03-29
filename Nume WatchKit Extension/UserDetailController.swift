//
//  UserDetailController.swift
//  Nume
//
//  Created by Daniel Hsu on 5/27/15.
//  Copyright (c) 2015 Daniel Hsu. All rights reserved.
//

import Foundation
import NumeKit
import WatchKit

class UserDetailController: WKInterfaceController {
    
    // Model
    var user : User!
    
    @IBOutlet weak var numberResultLabel: WKInterfaceLabel!
    @IBOutlet weak var dictationResultLabel: WKInterfaceLabel!
    @IBOutlet weak var userNameLabel: WKInterfaceLabel!
    @IBOutlet weak var userProfileImageBG: WKInterfaceGroup!
    
    // Views
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Make sure data was passed properly and update the label accordingly
        if let val = context as? User {
            self.numberResultLabel.setText("\(val.userNumber!)")
            self.dictationResultLabel.setText("\(val.userActivity!)")
            self.userNameLabel.setText("\(val.userName!)")
            
            loadProfileImage(userProfileImageBG, userID: val.userFacebookID!)
        } else {
            self.numberResultLabel.setText("")
        }

    }
    
    func loadProfileImage(profileImage : WKInterfaceGroup, userID: String) {
        let profileURL = "http://graph.facebook.com/\(userID)/picture?width=70&height=70" as NSString
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
}

