//
//  DetailViewController.swift
//  Nume
//
//  Created by Daniel Hsu on 4/22/15.
//  Copyright (c) 2015 Daniel Hsu. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {

    //initialize variables
    
    
    //create slider for selecting number
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var ratinglabel: UILabel!
    //show large number while selecting on slider
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        var currentValue = Int(sender.value)
        ratinglabel.text = "\(currentValue)"
    }
    
    //take user file and add number selection





}

