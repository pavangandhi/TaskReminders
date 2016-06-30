//
//  AppUtilities.swift
//  NationalGPRApp
//
//  Created by Bigscal on 13/09/14.
//  Copyright (c) 2014 Bigscal. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
class AppUtilities : NSObject
{
    
    /*========================================================
    * function Name: configureRestKit
    * function Purpose: to connect with API using Rest kit
    * function Parameters: (className : AnyObject, methodType : NSString, mappingArray : NSMutableArray, pathpattern :NSString
    * function ReturnType: void
    * function Description: configure with rest kit nased on parameter
    *=====================================================*/
    
    class func configureRestKit(className : AnyObject, methodType : NSString, mappingArray : NSMutableArray, pathpattern :NSString)
    {
        /*var response : RKResponseDescriptor = RKResponseDescriptor()
        var url : NSURL = NSURL(string: BASE_URL)!
        var client : AFHTTPClient = AFHTTPClient(baseURL: url);
        var objManager : RKObjectManager = RKObjectManager(HTTPClient: client);
        var objMapping : RKObjectMapping = RKObjectMapping(forClass: className.classForCoder)
         objMapping.addAttributeMappingsFromArray(mappingArray as [AnyObject])
        if(methodType == "GET")
        {
             response = RKResponseDescriptor(mapping: objMapping, method: RKRequestMethod.GET, pathPattern: pathpattern as String, keyPath: nil, statusCodes:NSIndexSet(index: 200))
        }else if(methodType == POST_METHOD)
        {
            response = RKResponseDescriptor(mapping: objMapping, method: RKRequestMethod.POST, pathPattern: pathpattern as String, keyPath: nil, statusCodes:NSIndexSet(index: 200))
        }
        
        RKObjectManager.sharedManager().requestSerializationMIMEType = "application/json"
        RKObjectManager.sharedManager().HTTPClient.setDefaultHeader("Role", value: PRM_KEY_ROLE)
        RKObjectManager.sharedManager().addResponseDescriptor(response)*/
    }

    
    /*===================================================
    * function Name : setUserDefaults
    * function Params: key:NSString ,value:NSString
    * fuction  Return type: nil
    * function Purpose: to set user default value
    ===================================================*/
    
    class func setUserDefaults(key:NSString ,value:NSString)
    {
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setObject(value, forKey: key as String)
            userDefaults.synchronize()
    }
    
    /*===================================================
    * function Name : getUserDefaults
    * function Params: key:NSString
    * fuction  Return type: NSString
    * function Purpose: to get user default value
    ===================================================*/
    
    class func resignTextField(textField:UITextField)
    {
        if(textField.isFirstResponder())
        {
            textField.resignFirstResponder()
        }
    }
    
    class func resignTextView(textField:UITextView)
    {
        if(textField.isFirstResponder())
        {
            textField.resignFirstResponder()
        }
    }
    
    // check internet connectivity
    class func isConnectedToNetwork() -> Bool {
        
        /*var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
        SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, UnsafePointer($0))
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags.ConnectionAutomatic
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == true {
        return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection) ? true : false*/
        
        let reachability = Reachability.reachabilityForInternetConnection()
        if reachability.isReachable() || reachability.isReachableViaWiFi() || reachability.isReachableViaWWAN()
        {
            return true
        }
        else
        {
            return false
        }
    }

    /*========================================================
    * function Name: corneradiusToview
    * function Purpose: To make corner radius
    * function Parameters: UIView
    * function ReturnType:
    * function Description:
    *=====================================================*/
    
   class func  corneradiusToview(view:UIView, radius:CGFloat)
   {
        view.layer.cornerRadius=radius
   }
    
    /*========================================================
    * function Name: corneradiusWithBorderToview
    * function Purpose:  corneradiusWithBorderToview
    * function Parameters: var view:UIView, var radius:CGFloat,var borderWidth:CGFloat
    * function ReturnType: nil
    * function Description: corneradiusWithBorderToview
    *=====================================================*/
    
    class func corneradiusWithBorderToview(view:UIView, radius:CGFloat,borderWidth:CGFloat)
    {
        view.layer.cornerRadius=radius
        view.layer.borderWidth=borderWidth
    }
    
    /*========================================================
    * function Name: isValidEmailAddress
    * function Purpose: check email address is valid
    * function Parameters: testStr: NSString
    * function ReturnType: Bool
    * function Description: check email address is valid
    *=====================================================*/
    
    class func isValidEmailAddress(testStr: NSString)->Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    /*========================================================
    * function Name: drawRedBorderToTextfield
    * function Purpose: drawRedBorderToTextfield
    * function Parameters: var txtField:UITextField,var cornerRadius:CGFloat,var borderRadius:CGFloat
    * function ReturnType: nil
    * function Description: drawRedBorderToTextfield
    *=====================================================*/
    
    class func drawRedBorderToTextfield(txtField:UITextField, cornerRadius:CGFloat, borderRadius:CGFloat)
    {
        txtField.layer.borderWidth=borderRadius
        txtField.layer.cornerRadius=cornerRadius
        txtField.layer.borderColor=UIColor.redColor().CGColor
        txtField.text=""
    }
    
    /*========================================================
    * function Name: drawClearBorderToTextfield
    * function Purpose: drawClearBorderToTextfield
    * function Parameters: var txtField:UITextField,var cornerRadius:CGFloat,var borderRadius:CGFloat
    * function ReturnType: nil
    * function Description: drawClearBorderToTextfield
    *=====================================================*/
    
    class func drawClearBorderToTextfield(txtField:UITextField,cornerRadius:CGFloat, borderRadius:CGFloat)
    {
        txtField.layer.borderWidth=borderRadius
        txtField.layer.cornerRadius=cornerRadius
        txtField.layer.borderColor=UIColor.grayColor().CGColor
    }
	
	
    /*========================================================
    * function Name: drawLightGrayBroderAndRadiusToview
    * function Purpose: drawLightGrayBroderAndRadiusToview
    * function Parameters: var view:UIView?,var cornerRadius:CGFloat,var borderWidth:CGFloat
    * function ReturnType: nil
    * function Description: drawLightGrayBroderAndRadiusToview
    *=====================================================*/
    
    class func drawLightGrayBroderAndRadiusToview(view:UIView?,cornerRadius:CGFloat,borderWidth:CGFloat)
    {
        view?.layer.borderWidth=borderWidth
        view?.layer.cornerRadius=cornerRadius
        view?.layer.borderColor=UIColor.redColor().CGColor
    }
    
    /*========================================================
    * function Name: ValidatePassword
    * function Purpose: check reenter password is match with above password
    * function Parameters: var strPassword:NSString,var strConfirmPassword:NSString
    * function ReturnType: nil
    * function Description: check reenter password is match with above password
    *=====================================================*/
    
    class func ValidatePassword(strPassword:NSString,strConfirmPassword:NSString) ->Bool
    {
      return  strPassword.isEqualToString(strConfirmPassword as String) as Bool
    }
    
    /*========================================================
    * function Name: isValidateMobileNumber
    * function Purpose: check mobile number is valid or not
    * function Parameters: var MobileNumber:NSString
    * function ReturnType: bool
    * function Description: check mobile number is valid or not
    *=====================================================*/
    
    class func isValidateMobileNumber(MobileNumber:NSString) -> Bool
    {
        //var mobileRegEx = "[0-9]{10}"
        //var mobileTest = NSPredicate(format: "SELF MATCHES %@", mobileRegEx)
       // return mobileTest!.evaluateWithObject(MobileNumber)
        return true
    }
    
    /*========================================================
    * function Name: testInternetConnection
    * function Purpose: check server is coonected with application
    * function Parameters: nil
    * function ReturnType: bool
    * function Description: check server is coonected with application
    *=====================================================*/
    
    class func isReachable()->Bool
    {
        /*var reachability:Reachability?
        reachability = Reachability(hostName:"192.168.1.23");
        reachability?.startNotifier();
        var netStatus = reachability?.currentReachabilityStatus()
        if(reachability?.currentReachabilityStatus().value == NotReachable.value)
        {
             return false
        }*/
        return true
    }
    
    /*========================================================
    * function Name: isiPad
    * function Purpose: check device is ipad or iphone
    * function Parameters: nil
    * function ReturnType: bool
    * function Description: check device is ipad or iphone
    *=====================================================*/
    
    class func isiPad()->Bool
    {
        return (UIDevice.currentDevice().userInterfaceIdiom == .Pad)
    }
    
    /*========================================================
    * function Name: increaseFontSizeOfButtonForIpad
    * function Purpose: increaseFontSizeOfButtonForIpad
    * function Parameters: var button:UIButton?
    * function ReturnType: nil
    * function Description: increaseFontSizeOfButtonForIpad
    *=====================================================*/
    
    class func increaseFontSizeOfButtonForIpad( button:UIButton?)
    {
        button?.titleLabel?.font = UIFont(name: FONT_NAME, size: 18.0)
    }
    
    /*========================================================
    * function Name: increaseFontSizeOfButtonForIpad
    * function Purpose: increaseFontSizeOfButtonForIpad
    * function Parameters: var button:UIButton?
    * function ReturnType: nil
    * function Description: increaseFontSizeOfButtonForIpad
    *=====================================================*/
    
    class func increaseFontSizeAndItalicFontOfButtonForIpad(button:UIButton?)
    {
        button?.titleLabel?.font = UIFont(name: "Roboto-LightItalic",size: 25.0)
    }
    
    /*========================================================
    * function Name: increaseFontSizeOfTextFieldForIpad
    * function Purpose: increaseFontSizeOfTextFieldForIpad
    * function Parameters: var button:UIButton?
    * function ReturnType: nil
    * function Description: increaseFontSizeOfTextFieldForIpad
    *=====================================================*/
    
    class func textFieldUtility( textField:UITextField?)
    {
        if(AppUtilities.isiPad())
        {
            textField?.layer.borderWidth = 1.0
            textField?.layer.cornerRadius = 7.0
            //textField?.font = UIFont.systemFontOfSize(18)
        }
        else
        {
             textField?.layer.borderWidth = 1
             textField?.layer.cornerRadius = 5.0
        }
        textField?.layer.borderColor = UIColor(red: 194/255, green: 194/255, blue: 194/255, alpha: 1.0).CGColor
        textField?.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
    }
    
    /*========================================================
    * function Name: increaseFontSizeOfLabelForIpad
    * function Purpose: increaseFontSizeOfLabelForIpad
    * function Parameters: var button:UIButton?
    * function ReturnType: nil
    * function Description: increaseFontSizeOfLabelForIpad
    *=====================================================*/
    
    class func increaseFontSizeOfLabelForIpad(label:UILabel?, bold:Bool)
    {
        if(bold)
        {
            label?.font = UIFont(name: BOLD_FONT_NAME ,size: 20.0)
        }
        else
        {
            label?.font = UIFont(name: FONT_NAME ,size: 12.0)
        }
    }
	
	class func drawRedBorderToTextView(txtField:UITextView, cornerRadius:CGFloat, borderRadius:CGFloat)
	{
		txtField.layer.borderWidth=borderRadius
		txtField.layer.cornerRadius=cornerRadius
		txtField.layer.borderColor=UIColor.redColor().CGColor
		txtField.text=""
	}
	
    /*========================================================
    * function Name: increaseFontSizeOfLabelForIpad
    * function Purpose: increaseMoreFontSizeOfLabelForIpad
    * function Parameters: var button:UIButton?
    * function ReturnType: nil
    * function Description: increaseMoreFontSizeOfLabelForIpad
    *=====================================================*/
    
    class func increaseMoreFontSizeOfLabelForIpad(label:UILabel?)
    {
        label?.font = UIFont(name: FONT_NAME, size: 24.0)
        label?.backgroundColor
    }
    
    /*===================================================
    * function Name : setCompalsoryTextfieldFont
    * function Params: textField:UITextField
    * fuction  Return type: nil
    * function Purpose: set textfield font
    ===================================================*/
    
    class func setCompalsoryTextfieldFont( textField:UITextField)
    {
        let textFieldFont = UIFont(name: FONT_NAME , size: 18.0)
        textField.font = textFieldFont
    }
    
    /*===================================================
    * function Name : changeBackgroundLabel
    * function Params: label:UILabel?
    * fuction  Return type: nil
    * function Purpose: set label background color
    ===================================================*/
    
    class func changeBackgroundLabel( label:UILabel?)
    {
        label?.backgroundColor = UIColor.redColor()
    }
    
    /*===================================================
    * function Name : clearBackgroundLabel
    * function Params:  label:UILabel?
    * fuction  Return type: nil
    * function Purpose: set clear background color of lable
    ===================================================*/
    
    class func clearBackgroundLabel( label:UILabel?)
    {
        label?.backgroundColor = UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 1.0)
    }
    
    /*===================================================
    * function Name : convertDate
    * function Params: target : String
    * fuction  Return type: String
    * function Purpose: convert date in (25 May, 1953) format
    ===================================================*/
    
    class func convertDate(target : String) -> String
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDateStr  = dateFormatter.dateFromString(target)!
        dateFormatter.dateFormat = "dd MMM, yyyy"
        return dateFormatter.stringFromDate(startDateStr)
    }
    
    /*===================================================
    * function Name : convertDateforDetails
    * function Params: target : String
    * fuction  Return type: String
    * function Purpose: convert date in (Sun, 22 Mar, 2015) format
    ===================================================*/
    
    class func convertDateforDetails(target : String) -> String
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDateStr  = dateFormatter.dateFromString(target)!
        dateFormatter.dateFormat = "EEE, dd MMM, yyyy"
        return dateFormatter.stringFromDate(startDateStr)
    }
    
    /*===================================================
    * function Name : convertshortdate
    * function Params: target : String
    * fuction  Return type: String
    * function Purpose: convert data in 05 / 24 format
    ===================================================*/
    
    class func convertshortdate(target : String) -> String
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDateStr  = dateFormatter.dateFromString(target)!
        dateFormatter.dateFormat = "MM / dd"
        return dateFormatter.stringFromDate(startDateStr)
    }
    
    /*===================================================
    * function Name : extractTime
    * function Params: target : NSString
    * fuction  Return type: NSString
    * function Purpose: to convert time in AM or PM format
    ===================================================*/
    
    class func extractTime(target : NSString) -> NSString
    {
        var target : NSString = target.substringWithRange(NSRange(location: 11, length: 5))
        if(target.substringWithRange(NSRange(location: 0, length: 2)) >= "12")
        {
            let hour : NSString = target.substringWithRange(NSRange(location: 0, length: 2)) as NSString
            let i : Int = hour.integerValue - 12
            target = (String(i) + target.substringWithRange(NSRange(location: 2, length: 3)) as NSString as String) + " PM"
        }
        else
        {
            let hour : NSString = target.substringWithRange(NSRange(location: 0, length: 2)) as NSString
            let i : Int = hour.integerValue
            target = (String(i) + target.substringWithRange(NSRange(location: 2, length: 3)) as NSString as String) + " AM"
        }
         return target
    }
    
    /*========================================================
    * function Name: showAlertWithMessage
    * function Purpose: showAlertWithMessage
    * function Parameters: var title: NSString ,var message:NSString
    * function ReturnType: nil
    * function Description: showAlertWithMessage
    *=====================================================*/
    
    class func showAlertWithMessage( title: NSString , message:NSString)
    {
        let alert : UIAlertView = UIAlertView(title: title as String, message: message as String, delegate: nil, cancelButtonTitle: "OK")
        alert.tag = 110101
        alert.show()
    }
    
    /*===================================================
    * function Name : paddingTextField
    * function Params: textField:UITextField!
    * fuction  Return type: none
    * function Purpose: To set textfield Padding
    ===================================================*/
    
    class func paddingTextField(textField:UITextField!, size : CGFloat)
    {
        let paddingView:UIView = UIView(frame: CGRectMake(0, 0, size, textField.frame.size.height))
        let paddingView1:UIView = UIView(frame: CGRectMake(0, 0, 30, textField.frame.size.height))
        textField.leftView = paddingView
        textField.rightView = paddingView1
        textField.rightViewMode = UITextFieldViewMode.Always
        textField.leftViewMode = UITextFieldViewMode.Always
    }
    
    /*===================================================
    * function Name : setViewBackgroundcolor
    * function Params: red : CGFloat, green : CGFloat, blue : CGFloat, alpha : CGFloat
    * fuction  Return type: none
    * function Purpose: To set background color
    ===================================================*/
    
    class func setViewBackgroundcolor(view : UIView, red : CGFloat, green : CGFloat, blue : CGFloat, alpha : CGFloat)
    {
        view.backgroundColor = UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    /*===================================================
    * function Name : setScrollViewBackgroundcolor
    * function Params: red : CGFloat, green : CGFloat, blue : CGFloat, alpha : CGFloat
    * fuction  Return type: none
    * function Purpose: To set background color
    ===================================================*/
    
    class func setScrollViewBackgroundcolor(view : UIScrollView, red : CGFloat, green : CGFloat, blue : CGFloat, alpha : CGFloat)
    {
        view.backgroundColor = UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 0.1)
    }
    
    /*========================================================
    * function Name: formarNumber
    * function Purpose: To format mobile number
    * function Parameters: mobileNo: NSString
    * function ReturnType: NSString
    *=======================================================*/
    
    class func formarNumber(var mobileNo: NSString) -> NSString {
        
        mobileNo = mobileNo.stringByReplacingOccurrencesOfString("(", withString: "")
        mobileNo = mobileNo.stringByReplacingOccurrencesOfString(")", withString: "")
        mobileNo = mobileNo.stringByReplacingOccurrencesOfString(" ", withString: "")
        mobileNo = mobileNo.stringByReplacingOccurrencesOfString("-", withString: "")
        mobileNo = mobileNo.stringByReplacingOccurrencesOfString("+", withString: "")
        let length = mobileNo.length
        if(length > 10) {
            mobileNo = mobileNo.substringFromIndex(length-10)
        }
        return mobileNo
    }
    
    /*========================================================
    * function Name: getLength
    * function Purpose: To get length of mobile number field
    * function Parameters: mobileNo: NSString
    * function ReturnType: Int
    *=======================================================*/
    
    class func getLength(var mobileNo: NSString) -> Int{
        
        mobileNo = mobileNo.stringByReplacingOccurrencesOfString("(", withString: "")
        mobileNo = mobileNo.stringByReplacingOccurrencesOfString(")", withString: "")
        mobileNo = mobileNo.stringByReplacingOccurrencesOfString(" ", withString: "")
        mobileNo = mobileNo.stringByReplacingOccurrencesOfString("-", withString: "")
        mobileNo = mobileNo.stringByReplacingOccurrencesOfString("+", withString: "")
        let length = mobileNo.length
        return length
    }
    
    /*========================================================
    * function Name: isBlankSpace
    * function Purpose: To check string contains only whitespace or not
    * function Parameters: txtString:String)
    * function ReturnType: bool
    *=======================================================*/
    
    class func isBlankSpace( txtString:String)->Bool
    {
        let whiteSpace : NSCharacterSet = NSCharacterSet.whitespaceCharacterSet()
        let trimText : NSString = txtString.stringByTrimmingCharactersInSet(whiteSpace)
        if(trimText.length == 0)
        {
            return true
        }
        return false
    }
    
    /*========================================================
    * function Name: trimText
    * function Purpose: To trim space of string
    * function Parameters:txtString:String
    * function ReturnType: NSString
    *=======================================================*/
    
    class func trimText( txtString:String)-> NSString
    {
        let whiteSpace : NSCharacterSet = NSCharacterSet.whitespaceCharacterSet()
        let trimPet : NSString = txtString.stringByTrimmingCharactersInSet(whiteSpace)
        return trimPet
    }
    
    /*========================================================
    * function Name: setCircleImage
    * function Purpose: to set button corner
    * function Parameters: btn: UIButton
    * function ReturnType: nil
    *=======================================================*/
//    class func setCircleImage(btn: AnyObject) {
//        btn.layer.cornerRadius = btn.frame.size.height / 2
//        //btn.layer.masksToBounds = true
//    }
	
    /*========================================================
    * function Name: getScreenWidth()
    * function Purpose: Get current devices width
    * function Parameters:
    * function ReturnType:
    *=======================================================*/
    class func getScreenWidth() -> CGFloat {
        let screenrect:CGRect = UIScreen.mainScreen().bounds
        return screenrect.width
    }
    
    /*========================================================
    * function Name: getScreenWidth()
    * function Purpose: Get current devices width
    * function Parameters:
    * function ReturnType:
    *=======================================================*/
    class func getScreenHeight() -> CGFloat {
        let screenrect:CGRect = UIScreen.mainScreen().bounds
        return screenrect.height
    }
	
	class func drawClearBorderToTextView(txtField:UITextView,cornerRadius:CGFloat, borderRadius:CGFloat)
	{
		txtField.layer.borderWidth=borderRadius
		txtField.layer.cornerRadius=cornerRadius
		txtField.layer.borderColor=UIColor.grayColor().CGColor
	}


}