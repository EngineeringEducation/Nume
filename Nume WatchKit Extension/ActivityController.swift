//
//  RateNumberController.swift
//  Nume
//
//  Created by Daniel Hsu on 5/4/15.
//  Copyright (c) 2015 Daniel Hsu. All rights reserved.
//

import WatchKit
import Foundation

class ActivityController: WKInterfaceController {
    
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

    //create button image
    @IBOutlet weak var microphoneButton: WKInterfaceButton!
    @IBOutlet weak var textResult: WKInterfaceLabel!
    @IBAction func onVoiceDictationTap() {
        presentTextInputControllerWithSuggestions(["Hanging out", "Drinking coffee","Watching movie","Studying","Listening to music","Going for a run", "Shopping","Driving","Cooking"], allowedInputMode: .AllowEmoji)
            {(input) -> Void in
                self.textResult.setText(input[0] as? String)
                println("INPUT: \(input)")
        }
        
    }
    
}