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

    let maxNumber = 5
    let minNumber = -5
    var ratingNumber = 0  {
        didSet {
            ratingLabel.setText("\(ratingNumber)")
            addNumber.setEnabled(ratingNumber < maxNumber)
            minusNumber.setEnabled(ratingNumber > minNumber)
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
   

}
