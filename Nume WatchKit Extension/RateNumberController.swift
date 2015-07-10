//
//  InterfaceController.swift
//  Nume WatchKit Extension
//
//  Created by Daniel Hsu on 4/29/15.
//  Copyright (c) 2015 Daniel Hsu. All rights reserved.
//

import WatchKit
import NumeKit
import Foundation


class RateNumberController: WKInterfaceController {
    
    // Model
    var user = User(userToken: 1, userNumber: 3, userActivity: "happy", userName: "Daniel", userEmail: "daniel@tradecrafted.com", userFacebookID: "12345") //dummy data for testing now
    
    @IBOutlet weak var lineImage: WKInterfaceImage!
    
    // Views
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        addNumber.setBackgroundImageNamed("arrowr")
        minusNumber.setBackgroundImageNamed("arrowl")
        lineImage.setImageNamed("line")
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        return self.user
    }
    
    //create plus and minus buttons for rating numbers
    @IBOutlet weak var addNumber: WKInterfaceButton!
    @IBOutlet weak var minusNumber: WKInterfaceButton!
    @IBOutlet weak var ratingLabel: WKInterfaceLabel!

    let maxNumber = 5
    let minNumber = -5
    var ratingNumber = 0  {
        didSet {
            ratingLabel.setText("\(ratingNumber)")
            addNumber.setEnabled(ratingNumber < maxNumber)
            minusNumber.setEnabled(ratingNumber > minNumber)
            self.user.userNumber = ratingNumber
            setColor(ratingNumber)
        }
    }
    @IBAction func increaseRating() {
        if ratingNumber == maxNumber {
            return
        }
        ratingNumber += 1
    }
    
    @IBAction func decreaseRating() {
        if ratingNumber == minNumber {
            return
        }
        ratingNumber -= 1
    }
    
    func setColor(number: Int) {
        switch number {
        case -5:
            ratingLabel.setTextColor(UIColor(red:0.27, green:0.49, blue:0.75, alpha:1.0))
        case -4:
            ratingLabel.setTextColor(UIColor(red:0.08, green:0.63, blue:0.86, alpha:1.0))
        case -3:
            ratingLabel.setTextColor(UIColor(red:0.10, green:0.74, blue:0.93, alpha:1.0))
        case -2:
            ratingLabel.setTextColor(UIColor(red:0.51, green:0.83, blue:0.97, alpha:1.0))
        case -1:
            ratingLabel.setTextColor(UIColor(red:0.71, green:0.89, blue:0.98, alpha:1.0))
        case 0:
            ratingLabel.setTextColor(UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0))
        case 1:
            ratingLabel.setTextColor(UIColor(red:1.00, green:0.94, blue:0.79, alpha:1.0))
        case 2:
            ratingLabel.setTextColor(UIColor(red:0.98, green:0.87, blue:0.56, alpha:1.0))
        case 3:
            ratingLabel.setTextColor(UIColor(red:0.98, green:0.84, blue:0.41, alpha:1.0))
        case 4:
            ratingLabel.setTextColor(UIColor(red:0.98, green:0.77, blue:0.20, alpha:1.0))
        default:
            ratingLabel.setTextColor(UIColor(red:0.96, green:0.65, blue:0.21, alpha:1.0))
        }
    }
    
   

}
