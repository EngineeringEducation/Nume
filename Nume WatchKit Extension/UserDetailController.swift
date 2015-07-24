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
    @IBOutlet weak var userBorderBG: WKInterfaceGroup!
    
    // Views
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
                    
        // Make sure data was passed properly and update the label accordingly
        if let val = context as? User {
            self.numberResultLabel.setText("\(val.userNumber!)")
            self.dictationResultLabel.setText("\(val.userActivity!)")
            self.userNameLabel.setText("\(val.userName!)")
            
            loadProfileImage(userProfileImageBG, userID: val.userFacebookID!)
            setColor(userNameLabel, label: numberResultLabel, number: val.userNumber!, border: userBorderBG)
        } else {
            self.numberResultLabel.setText("")
        }

    }
    
    func loadProfileImage(profileImage : WKInterfaceGroup, userID: String) {
        let profileURL = "http://graph.facebook.com/\(userID)/picture?width=40&height=40" as NSString
        let url: NSURL = NSURL(string: profileURL as String)!
        var data: NSData = NSData(contentsOfURL: url)!
        profileImage.setBackgroundImageData(data)
    }
    
    func setColor(username: WKInterfaceLabel, label: WKInterfaceLabel, number: Int, border: WKInterfaceGroup) {
        switch number {
        case -5:
            username.setTextColor(UIColor(red:0.27, green:0.49, blue:0.75, alpha:1.0))
            label.setTextColor(UIColor(red:0.27, green:0.49, blue:0.75, alpha:1.0))
            border.setBackgroundColor(UIColor(red:0.27, green:0.49, blue:0.75, alpha:1.0))
        case -4:
            username.setTextColor(UIColor(red:0.08, green:0.63, blue:0.86, alpha:1.0))
            label.setTextColor(UIColor(red:0.08, green:0.63, blue:0.86, alpha:1.0))
            border.setBackgroundColor(UIColor(red:0.08, green:0.63, blue:0.86, alpha:1.0))
        case -3:
            username.setTextColor(UIColor(red:0.10, green:0.74, blue:0.93, alpha:1.0))
            label.setTextColor(UIColor(red:0.10, green:0.74, blue:0.93, alpha:1.0))
            border.setBackgroundColor(UIColor(red:0.10, green:0.74, blue:0.93, alpha:1.0))
        case -2:
            username.setTextColor(UIColor(red:0.51, green:0.83, blue:0.97, alpha:1.0))
            label.setTextColor(UIColor(red:0.51, green:0.83, blue:0.97, alpha:1.0))
            border.setBackgroundColor(UIColor(red:0.51, green:0.83, blue:0.97, alpha:1.0))
        case -1:
            username.setTextColor(UIColor(red:0.71, green:0.89, blue:0.98, alpha:1.0))
            label.setTextColor(UIColor(red:0.71, green:0.89, blue:0.98, alpha:1.0))
            border.setBackgroundColor(UIColor(red:0.71, green:0.89, blue:0.98, alpha:1.0))
        case 0:
            username.setTextColor(UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0))
            label.setTextColor(UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0))
            border.setBackgroundColor(UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0))
        case 1:
            username.setTextColor(UIColor(red:1.00, green:0.94, blue:0.79, alpha:1.0))
            label.setTextColor(UIColor(red:1.00, green:0.94, blue:0.79, alpha:1.0))
            border.setBackgroundColor(UIColor(red:1.00, green:0.94, blue:0.79, alpha:1.0))
        case 2:
            username.setTextColor(UIColor(red:0.98, green:0.87, blue:0.56, alpha:1.0))
            label.setTextColor(UIColor(red:0.98, green:0.87, blue:0.56, alpha:1.0))
            border.setBackgroundColor(UIColor(red:0.98, green:0.87, blue:0.56, alpha:1.0))
        case 3:
            username.setTextColor(UIColor(red:0.98, green:0.84, blue:0.41, alpha:1.0))
            label.setTextColor(UIColor(red:0.98, green:0.84, blue:0.41, alpha:1.0))
            border.setBackgroundColor(UIColor(red:0.98, green:0.84, blue:0.41, alpha:1.0))
        case 4:
            username.setTextColor(UIColor(red:0.98, green:0.77, blue:0.20, alpha:1.0))
            label.setTextColor(UIColor(red:0.98, green:0.77, blue:0.20, alpha:1.0))
            border.setBackgroundColor(UIColor(red:0.98, green:0.77, blue:0.20, alpha:1.0))
        default:
            username.setTextColor(UIColor(red:0.94, green:0.27, blue:0.14, alpha:1.0))
            label.setTextColor(UIColor(red:0.94, green:0.27, blue:0.14, alpha:1.0))
            border.setBackgroundColor(UIColor(red:0.94, green:0.27, blue:0.14, alpha:1.0))
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
}

