//
//  Information.swift
//  Nume
//
//  Created by Daniel Hsu on 6/26/15.
//  Copyright (c) 2015 Daniel Hsu. All rights reserved.
//

import Foundation

public class Information: NSObject {
    
    static let appGroupID = "group.io.github.dhsu210.Nume"
    static let defaults = NSUserDefaults(suiteName: appGroupID )!

    public class func storeName(userName: String) {
        defaults.setValue(userName, forKey: "userNameKey")
    }
    
    public class func storeUniqueID(idNumber: Int) {
        defaults.setInteger(idNumber, forKey: "userTokenKey")
    }
    
    public class func storeFacebookID(facebookID: String) {
        defaults.setValue(facebookID, forKey: "userFacebookIDKey")
    }
    
    public class func storeRating(rating: Int) {
        defaults.setValue(rating, forKey: "userNumberKey")
    }
    
    public class func storeActivity(activity: String) {
        defaults.setValue(activity, forKey: "userActivityKey")
    }
    
    public class func getFacebookID() -> String {
        return defaults.valueForKey("userFacebookIDKey") as! String
    }
    
    public class func getRating() -> Int {
        return defaults.valueForKey("userNumberKey")as! Int
    }
    
    public class func getActivity() -> String {
        return defaults.valueForKey("userActivityKey") as! String
    }
    
    public class func getName() -> String {
        return defaults.valueForKey("userNameKey") as! String
    }
    
}