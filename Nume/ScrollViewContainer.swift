//
//  ScrollViewContainer.swift
//  Nume
//
//  Created by Jason Eng on 5/26/15.
//  Copyright (c) 2015 Daniel Hsu. All rights reserved.
//

import Foundation

class ScrollViewContainer: UIView {
    
    @IBOutlet var scrollView: UIScrollView!
    
    // This function returns the farthest descendant of the receiver in the view hierarchy (including itself) that contains a specified point.
    override func hitTest(point: CGPoint, withEvent event: UIEvent!) -> UIView? {
    // HitTest is a low level overridable method for handling touches, or better said, for detection of the destination of the touches.
        
        let view = super.hitTest(point, withEvent: event)
        if let theView = view {
            if theView == self {
                return scrollView
            }
        }
        
        return view
    }
    
}