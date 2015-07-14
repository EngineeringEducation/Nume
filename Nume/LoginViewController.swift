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
        numifyUserLabel.font = UIFont(name: "Bradley Hand", size: 30)
        
        self.profilePic!.layer.cornerRadius = 40
        self.profilePic!.clipsToBounds = true
        self.profilePic!.layer.borderColor = UIColor(red:0.98, green:0.79, blue:0.20, alpha:1.0).CGColor
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
                    let userFacebookID : NSString = result.valueForKey("id") as! NSString
                    println("User Facebook ID is: \(userFacebookID)")
                    
                    Information.storeName(userName as String)
                    Information.storeFacebookID(userFacebookID as String)
                    
                    self.numifyUserLabel.text = "Hi \(userName)!"
                    self.numifyUserLabel.font = UIFont(name: "Bradley Hand", size: 23)
                }
            })
            
        }
        
        let loginView : FBSDKLoginButton = FBSDKLoginButton()
        self.view.addSubview(loginView)
        loginView.frame = CGRectMake(36, 600, 300, 32)
        loginView.titleLabel!.font = UIFont(name: "Futura", size: 13)        
        loginView.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        loginView.setTranslatesAutoresizingMaskIntoConstraints(true)
        loginView.readPermissions = ["public_profile", "email", "user_friends"]
        loginView.delegate = self
        
        skipButton.frame = CGRectMake(36, 600, 300, 32)
        skipButton.backgroundColor = UIColor.whiteColor()
        skipButton.setTitleColor(UIColor(red:0.27, green:0.49, blue:0.75, alpha:1.0), forState: UIControlState.Normal)
        skipButton.setTitle("Skip Tutorial", forState: UIControlState.Normal)
        skipButton.titleLabel!.font = UIFont(name: "Futura", size: 13)
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
        
        pageImages = [UIImage(named:"01.png")!,
            UIImage(named:"02.png")!,
            UIImage(named:"03.png")!]
        
        let pageCount = pageImages.count
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        pageControl.pageIndicatorTintColor = UIColor(red:0.11, green:0.13, blue:0.45, alpha:1.0)
        pageControl.currentPageIndicatorTintColor = UIColor(red:0.98, green:0.79, blue:0.20, alpha:1.0)
        
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageImages.count), height: pagesScrollViewSize.height)
        
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
                            let userFacebookID : NSString = result.valueForKey("id") as! NSString
                            println("User Facebook ID is: \(userFacebookID)")
                            
                            
                            // Saves FB login user details into server
                            User.postUser(userName as String, userEmail: userEmail as String, userFacebookID: userFacebookID as String, completionHandler: { (user, error) -> Void in
                                if let error = error {
                                    println(error)
                                } else {
                                    let userToken : Int = user!.userToken!
                                    
                                    Information.storeName(userName as String)
                                    Information.storeUniqueID(userToken as Int)
                                    Information.storeFacebookID(userFacebookID as String)
                                  
                                }
                            })
                            
                            
                            // Updates top of login controller with user details after FB login
                            self.numifyUserLabel.text = "Hi \(userName)!"
                            self.numifyUserLabel.font = UIFont(name: "Bradley Hand", size: 23)
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
            self.numifyUserLabel.font = UIFont(name: "Bradley Hand", size: 30)
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
        
        if (page == 2) {
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
                
                Information.storeName(userName as String)
                
                let userEmail : NSString = result.valueForKey("email") as! NSString
                println("User Email is: \(userEmail)")
                
            }
        })
    }
}