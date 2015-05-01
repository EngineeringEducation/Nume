//
//  InterfaceController.swift
//  Nume WatchKit Extension
//
//  Created by Daniel Hsu on 4/29/15.
//  Copyright (c) 2015 Daniel Hsu. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override init() {
        super.init()
    }
    
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
    
    //create number ratings
    @IBOutlet weak var ratingLabel: WKInterfaceLabel!
    @IBOutlet weak var slider: WKInterfaceSlider!
    
    var ratingNumber = 0
    @IBAction func updateRating(value: Float) {
        ratingNumber = Int(value)
        ratingLabel.setText("\(ratingNumber)")

    }
   
    
    //create button image
    @IBOutlet weak var microphoneButton: WKInterfaceButton!
    
    @IBOutlet weak var textResult: WKInterfaceLabel!
    @IBAction func onVoiceDictationTap() {
        presentTextInputControllerWithSuggestions(nil, allowedInputMode: .Plain)
            {(input) -> Void in
                self.textResult.setText("\(input)")
                println("INPUT: \(input)")
        }
        
    }

}