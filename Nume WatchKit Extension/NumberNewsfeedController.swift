//
//  NumberNewsfeedController.swift
//  Nume
//
//  Created by Daniel Hsu on 5/8/15.
//  Copyright (c) 2015 Daniel Hsu. All rights reserved.
//

import Foundation
import WatchKit

class NumberNewsfeedController: WKInterfaceController {
    
    // Model
    @IBOutlet weak var numberResult: WKInterfaceLabel!
    
    // Views
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Make sure data was passed properly and update the label accordingly
        if let val: Int = context as? Int {
            self.numberResult.setText("\(val)")
        } else {
            self.numberResult.setText("")
        }
        
        
//        NSNotificationCenter.defaultCenter().addObserverForName("numberChanged", object: nil, queue: nil) { (numberNotification) -> Void in
//            let numberResult = numberNotification.userInfo!["changedNumber"] as! Int
//            self.numberResult.setText("\(numberResult)")
//        }
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
