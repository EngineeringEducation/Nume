//
//  User.swift
//  Nume
//
//  Created by Daniel Hsu on 5/13/15.
//  Copyright (c) 2015 Daniel Hsu. All rights reserved.
//

import Foundation

public class User: NSObject {
    public var userToken: Int?
    public var userNumber: Int?
    public var userActivity: String?
    public var userName: String?
    public var userEmail: String?
    public var userFacebookID: String?
    
    public init(userToken: Int?, userNumber: Int?, userActivity: String?, userName: String, userEmail: String?, userFacebookID : String) {
        self.userToken = userToken
        self.userNumber = userNumber
        self.userActivity = userActivity
        self.userName = userName
        self.userEmail = userEmail
        self.userFacebookID = userFacebookID
        super.init()
    }
    
    public convenience init(userToken: Int, userName: String, userEmail: String, userFacebookID: String) {
        self.init(userToken: userToken, userNumber: nil, userActivity: nil, userName: userName, userEmail: userEmail, userFacebookID: userFacebookID)
    }
    
    public convenience init(userNumber: Int, userActivity: String, userName: String, userFacebookID: String) {
        self.init(userToken: nil, userNumber: userNumber, userActivity: userActivity, userName: userName, userEmail: nil, userFacebookID: userFacebookID)
    }
    
    public class func postUser(userName: String, userEmail: String, userFacebookID: String, completionHandler : (user: User?, error: NSError?) -> Void) {
        
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest()
        
        //POST the new user to the server
        request.HTTPMethod = "POST"
        request.URL = NSURL(string: "https://whispering-everglades-1936.herokuapp.com/users")
        
        let params = ["name": userName, "email": userEmail, "user_fb_id": userFacebookID] as [String:String]
        var err: NSError?
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            
            NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
                if let error = error {
                    completionHandler(user: nil, error: error)
                } else if let newUser = self.userProfileDetailsFromNetworkResponseData(data) {
                    completionHandler(user: newUser, error: nil)
                }
                
            }
        })

        task.resume()
        
    }
    
    public class func postUserDetails(token: Int, dictation: String, rating: Int) {
        
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest()
        
        //POST the user's new dictation and number rating to the server
        request.HTTPMethod = "POST"
        request.URL = NSURL(string: "https://whispering-everglades-1936.herokuapp.com/users/\(token)")
        
        let params = ["message": dictation, "rating": rating] as [String:AnyObject]
        var err: NSError?
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request)
        
        task.resume()
        
    }
    
    public class func getLastFourUsers(completionHandler : (users: [User]?, error: NSError?) -> Void) {
        
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest()
        request.HTTPMethod = "GET"
        request.URL = NSURL(string: "https://whispering-everglades-1936.herokuapp.com/users/lastfour")
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            
            NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
                if let error = error {
                    completionHandler(users: nil, error: error)
                } else if let newUsers = self.userDetailsFromNetworkResponseData(data) {
                    completionHandler(users: newUsers, error: nil)
                }
            }
        })
        
        task.resume()
    }
    
    
    // This function gives you an array of dictation + ratings for one User built out of data received from the server.
    
    public class func userDetailsFromNetworkResponseData(responseData : NSData) -> Array <User>? {
        
        var serializationError : NSError?
        
        let userAPIDictionaries = NSJSONSerialization.JSONObjectWithData(
            responseData,
            options: nil,
            error: &serializationError
            ) as! [[String : AnyObject]]
        
        if let serializationError = serializationError {
            return nil
        }
        
        var users = userAPIDictionaries.map({ (userAPIDictionary) -> User in
            
            let userName = userAPIDictionary["name"] as! String
            let dictationText = userAPIDictionary["message"] as! String
            let ratingNumber = userAPIDictionary["rating"] as! Int
            let userProfileID = userAPIDictionary["user_fb_id"] as! String
            
            return User(userNumber: ratingNumber, userActivity: dictationText, userName: userName, userFacebookID: userProfileID)
            
        })
        
        return users
    }
    
    // This function returns a User with its id, name, and email after being posted into the server
    
    class func userProfileDetailsFromNetworkResponseData(responseData : NSData) -> User? {
        
        var serializationError : NSError?
        
        let userAPIDictionaries = NSJSONSerialization.JSONObjectWithData(
            responseData,
            options: nil,
            error: &serializationError
            ) as! Dictionary<String, AnyObject>
        
        if let serializationError = serializationError {
            return nil
        }
        
        let userToken = userAPIDictionaries["id"] as! Int
        let userName = userAPIDictionaries["name"] as! String
        let userEmail = userAPIDictionaries["email"] as! String
        let userProfileID = userAPIDictionaries["user_fb_id"] as! String
            
        return User(userToken: userToken, userName: userName, userEmail: userEmail, userFacebookID: userProfileID)
        
    }
}