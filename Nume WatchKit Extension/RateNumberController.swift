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

    var ratingNumber = 0
    @IBAction func increaseRating() {
        minusNumber.setEnabled(true)
        if ratingNumber == 4 {
            ratingNumber += 1
            ratingLabel.setText("\(ratingNumber)")
            addNumber.setEnabled(false)
        } else {
            addNumber.setEnabled(true)
            ratingNumber += 1
            ratingLabel.setText("\(ratingNumber)")
        }
    }
    
    @IBAction func decreaseRating() {
        addNumber.setEnabled(true)
        if ratingNumber == -4 {
            ratingNumber -= 1
            ratingLabel.setText("\(ratingNumber)")
            minusNumber.setEnabled(false)
        } else {
            minusNumber.setEnabled(true)
            ratingNumber -= 1
            ratingLabel.setText("\(ratingNumber)")
        }
    }
    
    //create number ratings
//    @IBOutlet weak var slider: WKInterfaceSlider!
    
//    @IBAction func updateRating(value: Float) {
//        ratingNumber = Int(value)
//        ratingLabel.setText("\(ratingNumber)")
//        
//    }
    
   

}
