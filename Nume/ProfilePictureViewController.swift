//
//  ProfilePictureViewController.swift
//  Nume
//
//  Created by Jason Eng on 5/31/15.
//  Copyright (c) 2015 Daniel Hsu. All rights reserved.
//

import UIKit

class ProfilePictureViewController: UIViewController {
    
    @IBOutlet weak var profilePic:FBSDKProfilePictureView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profilePic!.layer.cornerRadius = 75
        self.profilePic!.clipsToBounds = true
        self.profilePic!.layer.borderColor = UIColor.whiteColor().CGColor
        self.profilePic!.layer.borderWidth = 3.0
        
        self.profilePic = FBSDKProfilePictureView()
        println(self.profilePic)
    }
}