//
//  BaseViewController.swift
//  DoHomeCall
//
//  Created by Bigscal on 20/04/15.
//  Copyright (c) 2015 Bigscal. All rights reserved.
//

import UIKit

// constants
let useClosures = false

class BaseViewController: UIViewController, UIAlertViewDelegate
{
    // prepared local variables
    var actInd : UIActivityIndicatorView?
    var internetConnection:Bool = true;
	var userdefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
	var mywindow: UIWindow?
	
    override func viewDidLoad()
    {
        super.viewDidLoad()
	}

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    /*========================================================
    * function Name: setNavigationBarWithBackOption
    * function Purpose: to set navigation bar for view
    * function Parameters: title: NSString
    * function ReturnType: nil
    *=======================================================*/
    
    func setNavigationBarWithBackOption(title: NSString)
    {
        self.navigationController?.navigationBar.translucent = false
	    UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        // Left Navigation Item
        let btnLeft:UIButton! = UIButton()
        btnLeft!.frame = CGRectMake(0, 0, 18, 25)
        let addImage:UIImage = UIImage(named: "Back")!
        btnLeft!.setBackgroundImage(addImage, forState: UIControlState.Normal)
        btnLeft!.addTarget(self, action: "handleBackOption:",forControlEvents: UIControlEvents.TouchUpInside)
        let leftItem:UIBarButtonItem = UIBarButtonItem(customView: btnLeft!)
        self.navigationItem.leftBarButtonItem = leftItem
        
        // Title of Navigation Item
        let navigationTitleLbl:UILabel = UILabel(frame:CGRectMake(0, 0, 320, 40.0))
        navigationTitleLbl.text = title as String
        navigationTitleLbl.font =  UIFont.boldSystemFontOfSize(18.0)
        navigationTitleLbl.font =  UIFont(name: BOLD_FONT_NAME, size: 20.0)
        navigationTitleLbl.textColor=UIColor.whiteColor()
        navigationTitleLbl.textAlignment = NSTextAlignment.Center
        navigationTitleLbl.frame = CGRectMake(100, 0.0, 100, 100)
        self.navigationItem.titleView = navigationTitleLbl
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(named: "Navbar"),
                                                                    forBarMetrics: .Default)
    }
    
	override func viewWillAppear(animated: Bool) {
		
		UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)

	}
	func setNavigationBar(title: NSString)
	{
		self.navigationController?.navigationBar.translucent = false
		UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
		
		// Title of Navigation Item
		let navigationTitleLbl:UILabel = UILabel(frame:CGRectMake(0, 0, 320, 40.0))
		navigationTitleLbl.text = title as String
		navigationTitleLbl.font =  UIFont.boldSystemFontOfSize(18.0)
		navigationTitleLbl.font =  UIFont(name: BOLD_FONT_NAME, size: 20.0)
		navigationTitleLbl.textColor=UIColor.whiteColor()
		navigationTitleLbl.textAlignment = NSTextAlignment.Center
		navigationTitleLbl.frame = CGRectMake(100, 0.0, 100, 100)
		self.navigationItem.titleView = navigationTitleLbl
        self.navigationItem.hidesBackButton = true
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(named: "Navbar"),
                                                                    forBarMetrics: .Default)
	}

    @IBAction func logoutOption(sender: AnyObject)
	{
		var alert : UIAlertView = UIAlertView(title: APP_TITLE, message: "\nAre you sure to sign out from app?", delegate: self, cancelButtonTitle: "YES", otherButtonTitles: "NO")
		alert.tag = 101
		alert.show()
	}

    /*========================================================
    * function Name: handleBack
    * function Purpose: Go back to the previous view
    * function Parameters: sender: AnyObject
    * function ReturnType: nil
    *=======================================================*/
    
    @IBAction func handleBackOption(sender: AnyObject)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
	
    /*========================================================
    * function Name: showAlertWithMessage
    * function Purpose: showAlertWithMessage
    * function Parameters: var title: NSString ,var message:NSString
    * function ReturnType: nil
    * function Description: showAlertWithMessage
    *=====================================================*/
    
    func showAlertWithMessage(title: NSString , message:NSString)
    {
        let alert : UIAlertView = UIAlertView(title: title as String, message: message as String, delegate: self, cancelButtonTitle: "OK")
        alert.tag = 1
        alert.show()
    }
	
	func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
		if(alertView.tag == 101)
		{
			if(buttonIndex == 0)
			{
				NSUserDefaults.standardUserDefaults().removeObjectForKey("loginStatus")
				if let resultStatus = NSUserDefaults.standardUserDefaults().valueForKey("loginStatus") as? NSString
				{
					self.mywindow = UIWindow(frame: UIScreen.mainScreen().bounds)
					let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
					let navController : UINavigationController = storyBoard.instantiateInitialViewController() as! UINavigationController
					if(resultStatus.isEqualToString("yes"))
					{
						NSUserDefaults.standardUserDefaults().removeObjectForKey("loginStatus")
						let myStayVC = storyBoard.instantiateViewControllerWithIdentifier(LoginViewVCIdentifier) as! LoginViewController
						navController.viewControllers = [myStayVC]
						self.mywindow?.rootViewController = navController
						self.mywindow?.makeKeyAndVisible()
					}
				}
				else
				{
					NSUserDefaults.standardUserDefaults().removeObjectForKey("loginStatus")
					self.mywindow = UIWindow(frame: UIScreen.mainScreen().bounds)
					let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
					let navController : UINavigationController = storyBoard.instantiateInitialViewController() as! UINavigationController
					let myStayVC = storyBoard.instantiateViewControllerWithIdentifier(LoginViewVCIdentifier) as! LoginViewController
					navController.viewControllers = [myStayVC]
					self.mywindow?.rootViewController = navController
					self.mywindow?.makeKeyAndVisible()
				}
			}
		}
	}
}
