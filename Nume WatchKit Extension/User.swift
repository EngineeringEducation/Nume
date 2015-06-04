//
//  User.swift
//  Nume
//
//  Created by Daniel Hsu on 5/6/15.
//  Copyright (c) 2015 Daniel Hsu. All rights reserved.
//

import Foundation
import WatchKit

class User: NSObject {
    var userToken: Int
    var userNumber: Int
    var userActivity: String
    var userName: String
    
    init(userToken: Int, userNumber: Int, userActivity: String, userName: String) {
        self.userToken = userToken
        self.userNumber = userNumber
        self.userActivity = userActivity
        self.userName = userName
        super.init()
    }
}
