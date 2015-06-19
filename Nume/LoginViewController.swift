//
// FBLoginViewController.swift
// Nume 
// 
// Created by Jason Eng on 4/30/15. 
// Copyright (c) 2015 Daniel Hsu. All rights reserved. 
//

import UIKit
import NumeKit

class LoginViewController: UIViewController, UIScrollViewDelegate, FBSDKLoginButtonDelegate {
    
    // Model
    var user: User!
    
    @IBOutlet weak var numifyUserLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet weak var profilePic: FBSDKProfilePictureView?
    
    var pageImages: [UIImage] = []
    var pageViews: [UIImageView?] = []
    let skipButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    
    // Views
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        numifyUserLabel.text = "Numify"
        numifyUserLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 38)
        
        self.profilePic!.layer.cornerRadius = 40
        self.profilePic!.clipsToBounds = true
        self.profilePic!.layer.borderColor = UIColor.whiteColor().CGColor
        self.profilePic!.layer.borderWidth = 3.0
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
            graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                
                if ((error) != nil) {
                    // Process error
                    println("Error: \(error)")
                } else {
                    println("fetched user: \(result)")
                    let userName : NSString = result.valueForKey("name") as! NSString
                    println("User Name is: \(userName)")
                    let userEmail : NSString = result.valueForKey("email") as! NSString
                    println("User Email is: \(userEmail)")
                    
                    let appGroupID = "group.io.github.dhsu210.Nume"
                    if let defaults = NSUserDefaults(suiteName: appGroupID) {
                        defaults.setValue(userName, forKey: "userNameKey")
                    }
                    
                    self.numifyUserLabel.text = "Hi, \(userName)!"
                    self.numifyUserLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 14)
                }
            })
            
        }
        
        let loginView : FBSDKLoginButton = FBSDKLoginButton()
        self.view.addSubview(loginView)
        loginView.frame = CGRectMake(28, 600, 319, 30)
        loginView.setTranslatesAutoresizingMaskIntoConstraints(true)
        loginView.readPermissions = ["public_profile", "email", "user_friends"]
        loginView.delegate = self
        
        skipButton.frame = CGRectMake(28, 600, 319, 30)
        skipButton.backgroundColor = UIColor.whiteColor()
        skipButton.setTitle("Skip Tutorial", forState: UIControlState.Normal)
        skipButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(skipButton)
        skipButton.hidden = false
    }
    
    func buttonAction(sender:UIButton!){
        sender.hidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        
        pageImages = [UIImage(named:"1.png")!,
            UIImage(named:"2.png")!,
            UIImage(named:"3.png")!,
            UIImage(named:"4.png")!]
        
        let pageCount = pageImages.count
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(pageImages.count), pagesScrollViewSize.height)
        
        loadVisiblePages()
    }
    
    // Facebook Delegate Methods
    // helps you know if the user did login correctly and if they did you can grab their information.
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        println("User Logged In")
        
        if ((error) != nil) {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {

                if (FBSDKAccessToken.currentAccessToken() != nil) {
                    let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
                    graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                        
                        if ((error) != nil) {
                            // Process error
                            println("Error: \(error)")
                            self.numifyUserLabel.text = "error"
                        } else {
                            println("fetched user: \(result)")
                            let userName : NSString = result.valueForKey("name") as! NSString
                            println("User Name is: \(userName)")
                            let userEmail : NSString = result.valueForKey("email") as! NSString
                            println("User Email is: \(userEmail)")

                            // Saves FB login user details into server
                            User.postUser(userName as String, userEmail: userEmail as String, completionHandler: { (user, error) -> Void in
                                if let error = error {
                                    println(error)
                                } else {
                                    user!.userName = userName as String
                                    user!.userEmail = userEmail as String
                                }
                            })
                            
                           
                            let appGroupID = "group.io.github.dhsu210.Nume"
                            if let defaults = NSUserDefaults(suiteName: appGroupID) {
                                defaults.setValue(userName, forKey: "userNameKey")
                                defaults.setInteger(userToken, forKey: "userTokenKey")
                            }
                            
                            
                            
                            
                            // Updates top of login controller with user details after FB login
                            self.numifyUserLabel.text = "Hi, \(userName)!"
                            self.numifyUserLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 14)
                        }
                    })
                    
                }
                
            }
            
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User Logged Out")
        if (FBSDKAccessToken.currentAccessToken() == nil) {
            numifyUserLabel.text = "Numify"
            self.numifyUserLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 38)
        }
    }

    func loadPage(page: Int) {
        
        if page < 0 || page >= pageImages.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        if let pageView = pageViews[page] {
            // Do nothing. The view is already loaded.
        } else {
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            
            let newPageView = UIImageView(image: pageImages[page])
            newPageView.contentMode = .ScaleAspectFit
            newPageView.frame = frame
            scrollView.addSubview(newPageView)
            
            pageViews[page] = newPageView
        }
    }
    
    func purgePage(page: Int) {
        
        if page < 0 || page >= pageImages.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        // Remove a page from the scroll view and reset the container array
        if let pageView = pageViews[page] {
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
        
    }
    
    func loadVisiblePages() {
        
        // First, determine which page is currently visible
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        if (page == 3) {
            skipButton.hidden = true
        }
        
        // Update the page control
        pageControl.currentPage = page
        
        // Work out which pages you want to load
        let firstPage = page - 1
        let lastPage = page + 1
        
        // Purge anything before the first page
        for var index = 0; index < firstPage; ++index {
            purgePage(index)
        }
        
        // Load pages in our range
        for var index = firstPage; index <= lastPage; ++index {
            loadPage(index)
        }
        
        // Purge anything after the last page
        for var index = lastPage+1; index < pageImages.count; ++index {
            purgePage(index)
        }
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Load the pages that are now on screen
        loadVisiblePages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // method to grab the Users Facebook data. You can call this method anytime after a user has logged in by calling self.returnUserData()
    func returnUserData() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil) {
                // Process error
                println("Error: \(error)")
            } else {
                println("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                println("User Name is: \(userName)")
                if let userEmail : NSString = result.valueForKey("email") as? NSString {
                    println("User Email is: \(userEmail)")
                }
                
                let appGroupID = "group.io.github.dhsu210.Nume"
                if let defaults = NSUserDefaults(suiteName: appGroupID) {
                    defaults.setValue(userName, forKey: "userNameKey")
                }
                
                let userEmail : NSString = result.valueForKey("email") as! NSString
                println("User Email is: \(userEmail)")
                
            }
        })
    }
}