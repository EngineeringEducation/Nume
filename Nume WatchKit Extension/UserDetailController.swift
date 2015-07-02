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
            username.setTextColor(UIColor.redColor())
            label.setTextColor(UIColor.redColor())
            border.setBackgroundColor(UIColor.redColor())
        case -4:
            username.setTextColor(UIColor.greenColor())
            label.setTextColor(UIColor.greenColor())
            border.setBackgroundColor(UIColor.greenColor())
        case -3:
            username.setTextColor(UIColor.blueColor())
            label.setTextColor(UIColor.blueColor())
            border.setBackgroundColor(UIColor.blueColor())
        case -2:
            username.setTextColor(UIColor.yellowColor())
            label.setTextColor(UIColor.yellowColor())
            border.setBackgroundColor(UIColor.yellowColor())
        case -1:
            username.setTextColor(UIColor.orangeColor())
            label.setTextColor(UIColor.orangeColor())
            border.setBackgroundColor(UIColor.orangeColor())
        case 0:
            username.setTextColor(UIColor.redColor())
            label.setTextColor(UIColor.redColor())
            border.setBackgroundColor(UIColor.redColor())
        case 1:
            username.setTextColor(UIColor.blueColor())
            label.setTextColor(UIColor.blueColor())
            border.setBackgroundColor(UIColor.blueColor())
        case 2:
            username.setTextColor(UIColor.yellowColor())
            label.setTextColor(UIColor.yellowColor())
            border.setBackgroundColor(UIColor.yellowColor())
        case 3:
            username.setTextColor(UIColor.greenColor())
            label.setTextColor(UIColor.greenColor())
            border.setBackgroundColor(UIColor.greenColor())
        case 4:
            username.setTextColor(UIColor.orangeColor())
            label.setTextColor(UIColor.orangeColor())
            border.setBackgroundColor(UIColor.orangeColor())
        default:
            username.setTextColor(UIColor.redColor())
            label.setTextColor(UIColor.redColor())
            border.setBackgroundColor(UIColor.redColor())
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

