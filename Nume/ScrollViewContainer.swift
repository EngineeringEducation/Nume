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
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent!) -> UIView? {
        
        let view = super.hitTest(point, withEvent: event)
        if let theView = view {
            if theView == self {
                return scrollView
            }
        }
        
        return view
    }
    
}