//
//  User.swift
//  Nume
//
//  Created by Daniel Hsu on 5/13/15.
//  Copyright (c) 2015 Daniel Hsu. All rights reserved.
//

import Foundation

class User: NSObject {
    var userToken: Int?
    var userNumber: Int?
    var userActivity: String?
    var userName: String?
    var userEmail: String?
    
    init(userToken: Int, userNumber: Int, userActivity: String, userName: String) {
        self.userToken = userToken
        self.userNumber = userNumber
        self.userActivity = userActivity
        self.userName = userName
        super.init()
    }
    
    init(userToken: Int, userName: String) {
        self.userToken = userToken
        self.userName = userName
        super.init()
    }
    
    init(userName: String, userEmail: String) {
        self.userName = userName
        self.userEmail = userEmail
        super.init()
    }
    
    init(userNumber: Int, userActivity: String, userName: String) {
        self.userNumber = userNumber
        self.userActivity = userActivity
        self.userName = userName
        super.init()
    }
    
    class func postUser(userName: String, userEmail: String) {
        
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest()
        
        //POST the new user to the server
        request.HTTPMethod = "POST"
        request.URL = NSURL(string: "https://whispering-everglades-1936.herokuapp.com/users")
        
        var params = ["name": userName, "email": userEmail] as Dictionary<String, String>
        var err: NSError?
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request)
        task.resume()
        
    }
    
    class func postUserDetails(theUser: User, dictation: String, rating: Int, completionHandler : (users: [User]?, error: NSError?) -> Void) {
                
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest()
        
        //POST the user's new dictation and number rating to the server
        request.HTTPMethod = "POST"
        request.URL = NSURL(string: "https://whispering-everglades-1936.herokuapp.com/users/\(theUser.userToken)")
        
        var params = ["message": dictation, "rating": rating] as Dictionary<String, AnyObject>
        var err: NSError?
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            
            NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
                if let error = error {
                    completionHandler(users: nil, error: error)
                } else if let newUsers = self.usersFromNetworkResponseData(data) {
                    completionHandler(users: newUsers, error: nil)
                }
                
            }
        })
        task.resume()
        
    }
    
    
    // This function does everything necessary to get users from the server and update both our models and our views when they arrive.
    class func getOneUser(theUser: User, completionHandler : (users: [User]?, error: NSError?) -> Void) {
        
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest()
        request.HTTPMethod = "GET"
        request.URL = NSURL(string: "https://whispering-everglades-1936.herokuapp.com/users/\(theUser.userToken)")
        
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
    
    class func getLastFourUsers(completionHandler : (users: [User]?, error: NSError?) -> Void) {
        
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
    
    class func userDetailsFromNetworkResponseData(responseData : NSData) -> Array <User>? {
        
        var serializationError : NSError?
        
        let userAPIDictionaries = NSJSONSerialization.JSONObjectWithData(
            responseData,
            options: nil,
            error: &serializationError
            ) as! Array<Dictionary<String, AnyObject>>
        
        if let serializationError = serializationError {
            return nil
        }
        
        var users = userAPIDictionaries.map({ (userAPIDictionary) -> User in
            
            let userName = userAPIDictionary["name"] as! String
            let dictationText = userAPIDictionary["message"] as! String
            let ratingNumber = userAPIDictionary["rating"] as! Int

            return User(userNumber: ratingNumber, userActivity: dictationText, userName: userName)
            
        })
        
        return users
    }
    
    // This function gives you an array of Users built out of data received from the server.

    class func usersFromNetworkResponseData(responseData : NSData) -> Array <User>? {
        
        var serializationError : NSError?
        
        let userAPIDictionaries = NSJSONSerialization.JSONObjectWithData(
            responseData,
            options: nil,
            error: &serializationError
            ) as! Array<Dictionary<String, AnyObject>>
        
        if let serializationError = serializationError {
            return nil
        }
        
        var users = userAPIDictionaries.map({ (userAPIDictionary) -> User in

            let userToken = userAPIDictionary["id"] as! Int
            let userName = userAPIDictionary["name"] as! String
            
            return User(userToken: userToken, userName: userName)
            
        })
        
        return users
    }
}