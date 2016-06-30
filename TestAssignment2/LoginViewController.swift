//
//  ViewController.swift
//  TestAssignment2
//
//  Created by Pavan Gandhi on 30/06/16.
//  Copyright © 2016 Pavan Gandhi. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController,UIScrollViewDelegate, UITextFieldDelegate {

    @IBOutlet var txtUserName : UITextField!
    @IBOutlet var txtPassword : UITextField!
    
    @IBOutlet var btnLogin : UIButton!
    @IBOutlet var btnNewUserSignup : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtUserName!.attributedPlaceholder = NSAttributedString(string:"UserName",
                                                                     attributes:[NSForegroundColorAttributeName: UIColor.blackColor()])
        self.txtPassword!.attributedPlaceholder = NSAttributedString(string:"Password",
                                                                     attributes:[NSForegroundColorAttributeName: UIColor.blackColor()])
        self.btnLogin?.layer.cornerRadius = 5.0

        
      
        self.txtUserName?.returnKeyType = UIReturnKeyType.Next
        self.txtPassword?.returnKeyType = UIReturnKeyType.Done
        
        AppUtilities.paddingTextField(self.txtUserName, size: 40.0)
        AppUtilities.paddingTextField(self.txtPassword, size: 40.0)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.navigationBar.translucent = true
        AppUtilities.drawClearBorderToTextfield(self.txtUserName!, cornerRadius: 5.0, borderRadius: 1.0)
        AppUtilities.drawClearBorderToTextfield(self.txtPassword!, cornerRadius: 5.0, borderRadius: 1.0)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginBtnPressed(sender: AnyObject)
    {
        if sender.tag == 1
        {
            // login phase
            if(self.isValidInformation())
            {
                if AppUtilities.isConnectedToNetwork()
                {
                    self.callAPILoginProcessVerification()
                }
                else
                {
                    self.showAlertWithMessage(APP_TITLE, message: INTERNET_CONNECTION_OFF)
                }
            }
            else
            {
                self.showAlertWithMessage(APP_TITLE, message: "Please enter valid credentials for login.")
            }
        }
        else if sender.tag == 2
        {
            // Registration phase
            let registerNewAccount = self.storyboard?.instantiateViewControllerWithIdentifier(RegisterNewAccountVCIdentifier) as! RegisterNewAccountViewController
            self.navigationController?.pushViewController(registerNewAccount, animated: true)

        }
        
    }
    
    func isValidInformation()->Bool
    {
        // check Email Address is validate and password is empty or not
        if((NSString(string : self.txtUserName!.text!).length != 0 && NSString(string : self.txtPassword!.text!).length != 0))
        {
            AppUtilities.drawClearBorderToTextfield(self.txtUserName!, cornerRadius: 5.0, borderRadius: 1.0)
            AppUtilities.drawClearBorderToTextfield(self.txtPassword!, cornerRadius: 5.0, borderRadius: 1.0)
            
            return true
        }
        else
        {
            if(NSString(string : self.txtUserName!.text!).length == 0)
            {
                AppUtilities.drawRedBorderToTextfield(self.txtUserName!, cornerRadius:5.0, borderRadius: 1.0)
            }else
            {
                AppUtilities.drawClearBorderToTextfield(self.txtUserName!, cornerRadius: 5.0, borderRadius: 1.0)
            }
            
            if(NSString(string : self.txtPassword!.text!).length == 0)
            {
                AppUtilities.drawRedBorderToTextfield(self.txtPassword!, cornerRadius:5.0, borderRadius: 1.0)
            }else
            {
                AppUtilities.drawClearBorderToTextfield(self.txtPassword!, cornerRadius: 5.0, borderRadius: 1.0)
            }
        }
        return false
    }
 
    func callAPILoginProcessVerification()
    {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        let urlStr : NSString = NSString(format: "http://atlant.cearsinfotech.com/api.php")
        let dict : NSMutableDictionary = NSMutableDictionary(objects: [(self.txtUserName.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()))!, (self.txtPassword.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()))!,"login"], forKeys: [PRM_USERNAME, PRM_PASSWORD, PRM_METHOD_TYPE])
        
        let manager :AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        let requestObj : AFHTTPRequestSerializer = AFHTTPRequestSerializer()
        let responseObj : AFHTTPResponseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer = requestObj
        manager.responseSerializer = responseObj
        manager.responseSerializer.acceptableContentTypes = nil
        
        manager.POST(urlStr as String, parameters: dict, success: { (opration : AFHTTPRequestOperation!, responseObject : AnyObject!) -> Void in
            MBProgressHUD.hideAllHUDsForView(self.view, animated: false)
            do
            {
                let resultOfContact : NSMutableDictionary = try NSJSONSerialization.JSONObjectWithData((responseObject as? NSData)!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableDictionary
                NSLog("Login Response : %@", resultOfContact)
                
                if resultOfContact.valueForKey("success")?.integerValue == 1
                {
                    let welcomeMessage : NSString = NSString(format: "Welcome to Mr. %@. Now You can enjoy with task reminders.", resultOfContact.valueForKey("data")?.valueForKey("username") as! String)
                    let alertSuccess : UIAlertView = UIAlertView(title: APP_TITLE, message: welcomeMessage as String, delegate: self, cancelButtonTitle: "OK")
                    alertSuccess.tag = 1010
                    alertSuccess.show()
                    
                }
                else
                {
                    AppUtilities.showAlertWithMessage(APP_TITLE, message: "Your username and password may be wrong. please try again.")
                }
      
            } catch
            {
                
                let result : NSString = String(data: (responseObject as? NSData)!, encoding: NSUTF8StringEncoding)!
                print(result)
            }
            
        }) { (operaiton : AFHTTPRequestOperation!, error : NSError!) -> Void in
            print(error.description)
            MBProgressHUD.hideAllHUDsForView(self.view, animated: false)
            AppUtilities.showAlertWithMessage(APP_TITLE, message: "Credentials verification failed. please try again")
        }
    }

    override func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 1010 {
            if buttonIndex == 0 {
                // home page
            }
        }
    }
}

