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
            username.setTextColor(UIColor(red:0.32, green:0.72, blue:0.28, alpha:1.0))
            label.setTextColor(UIColor(red:0.32, green:0.72, blue:0.28, alpha:1.0))
            border.setBackgroundColor(UIColor(red:0.32, green:0.72, blue:0.28, alpha:1.0))
        case -4:
            username.setTextColor(UIColor(red:0.50, green:0.76, blue:0.25, alpha:1.0))
            label.setTextColor(UIColor(red:0.50, green:0.76, blue:0.25, alpha:1.0))
            border.setBackgroundColor(UIColor(red:0.50, green:0.76, blue:0.25, alpha:1.0))
        case -3:
            username.setTextColor(UIColor(red:0.64, green:0.74, blue:0.22, alpha:1.0))
            label.setTextColor(UIColor(red:0.64, green:0.74, blue:0.22, alpha:1.0))
            border.setBackgroundColor(UIColor(red:0.64, green:0.74, blue:0.22, alpha:1.0))
        case -2:
            username.setTextColor(UIColor(red:0.76, green:0.67, blue:0.18, alpha:1.0))
            label.setTextColor(UIColor(red:0.76, green:0.67, blue:0.18, alpha:1.0))
            border.setBackgroundColor(UIColor(red:0.76, green:0.67, blue:0.18, alpha:1.0))
        case -1:
            username.setTextColor(UIColor(red:0.84, green:0.60, blue:0.16, alpha:1.0))
            label.setTextColor(UIColor(red:0.84, green:0.60, blue:0.16, alpha:1.0))
            border.setBackgroundColor(UIColor(red:0.84, green:0.60, blue:0.16, alpha:1.0))
        case 0:
            username.setTextColor(UIColor(red:0.90, green:0.54, blue:0.14, alpha:1.0))
            label.setTextColor(UIColor(red:0.90, green:0.54, blue:0.14, alpha:1.0))
            border.setBackgroundColor(UIColor(red:0.90, green:0.54, blue:0.14, alpha:1.0))
        case 1:
            username.setTextColor(UIColor(red:0.86, green:0.59, blue:0.15, alpha:1.0))
            label.setTextColor(UIColor(red:0.86, green:0.59, blue:0.15, alpha:1.0))
            border.setBackgroundColor(UIColor(red:0.86, green:0.59, blue:0.15, alpha:1.0))
        case 2:
            username.setTextColor(UIColor(red:0.87, green:0.57, blue:0.15, alpha:1.0))
            label.setTextColor(UIColor(red:0.87, green:0.57, blue:0.15, alpha:1.0))
            border.setBackgroundColor(UIColor(red:0.87, green:0.57, blue:0.15, alpha:1.0))
        case 3:
            username.setTextColor(UIColor(red:0.95, green:0.50, blue:0.13, alpha:1.0))
            label.setTextColor(UIColor(red:0.95, green:0.50, blue:0.13, alpha:1.0))
            border.setBackgroundColor(UIColor(red:0.95, green:0.50, blue:0.13, alpha:1.0))
        case 4:
            username.setTextColor(UIColor(red:0.95, green:0.39, blue:0.13, alpha:1.0))
            label.setTextColor(UIColor(red:0.95, green:0.39, blue:0.13, alpha:1.0))
            border.setBackgroundColor(UIColor(red:0.95, green:0.39, blue:0.13, alpha:1.0))
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

