//
//  InterfaceController.swift
//  Nume WatchKit Extension
//
//  Created by Daniel Hsu on 4/29/15.
//  Copyright (c) 2015 Daniel Hsu. All rights reserved.
//

import WatchKit
import Foundation


class RateNumberController: WKInterfaceController {
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //create plus and minus buttons for rating numbers
    @IBOutlet weak var addNumber: WKInterfaceButton!
    @IBOutlet weak var minusNumber: WKInterfaceButton!
    @IBOutlet weak var ratingLabel: WKInterfaceLabel!

    var ratingNumber = 0  {
        didSet {
            ratingLabel.setText("\(ratingNumber)")
            if ratingNumber < 5 {
                addNumber.setEnabled(true)
            } else {
                addNumber.setEnabled(false)
            }
            if ratingNumber > -5 {
                minusNumber.setEnabled(true)
            } else {
                minusNumber.setEnabled(false)
            }
        }
    }
    @IBAction func increaseRating() {
        ratingNumber += 1
    }
    
    @IBAction func decreaseRating() {
        ratingNumber -= 1
    }
   

}
