//
//  RegisterNewAccountViewController.swift
//  TestAssignment2
//
//  Created by Pavan Gandhi on 30/06/16.
//  Copyright © 2016 Pavan Gandhi. All rights reserved.
//

import UIKit

class RegisterNewAccountViewController: BaseViewController,IQDropDownTextFieldDelegate, UIScrollViewDelegate, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var txtUserName : UITextField!
    @IBOutlet var txtPassword : UITextField!
    
    @IBOutlet var txtEmail : UITextField!
    @IBOutlet weak var imgProfilePic : UIImageView!
    @IBOutlet weak var btnPickImage : UIButton!
    @IBOutlet weak var birthDateTextField: IQDropDownTextField!
    
    @IBOutlet var btnSignUp : UIButton!
    @IBOutlet var btnLogin : UIButton!
    
    var imagePicker = UIImagePickerController()
    var flagForImage : NSString = NSString()
    var selectedBirthdate : NSDate = NSDate()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarWithBackOption("Register New Account")
        
        
        
        
        self.txtEmail!.attributedPlaceholder = NSAttributedString(string:"Email",
                                                                     attributes:[NSForegroundColorAttributeName: UIColor.blackColor()])
        self.txtUserName!.attributedPlaceholder = NSAttributedString(string:"UserName",
                                                                     attributes:[NSForegroundColorAttributeName: UIColor.blackColor()])
        self.txtPassword!.attributedPlaceholder = NSAttributedString(string:"Password",
                                                                     attributes:[NSForegroundColorAttributeName: UIColor.blackColor()])
        self.btnSignUp?.layer.cornerRadius = 5.0
        
        
        self.navigationController?.navigationBar.translucent = false
        self.txtEmail?.returnKeyType = UIReturnKeyType.Next
        self.txtUserName?.returnKeyType = UIReturnKeyType.Next
        self.txtPassword?.returnKeyType = UIReturnKeyType.Done
        
        AppUtilities.paddingTextField(self.txtEmail, size: 40.0)
        AppUtilities.paddingTextField(self.txtUserName, size: 40.0)
        AppUtilities.paddingTextField(self.txtPassword, size: 40.0)
        AppUtilities.paddingTextField(self.birthDateTextField, size: 40.0)
        
        let numberToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 150))
        numberToolbar.barStyle = UIBarStyle.BlackTranslucent
        numberToolbar.items = NSArray(objects:
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil),
                                      UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil),
                                      UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "returnBirthDateField:")) as? [UIBarButtonItem]
        numberToolbar.sizeToFit()
        
        birthDateTextField?.inputAccessoryView = numberToolbar
        birthDateTextField.isOptionalDropDown = false
        birthDateTextField.dropDownMode = IQDropDownMode.DatePicker
        

        imgProfilePic.layer.borderWidth = 1.0
        imgProfilePic.layer.masksToBounds = false
        imgProfilePic.layer.borderColor = UIColor.whiteColor().CGColor
        imgProfilePic.layer.cornerRadius = imgProfilePic.frame.size.width/2
        imgProfilePic.clipsToBounds = true
        imagePicker.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func returnBirthDateField(sender: AnyObject)
    {
        self.birthDateTextField!.resignFirstResponder()
    }

    override func viewWillAppear(animated: Bool)
    {
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        self.navigationController?.navigationBarHidden = false
        AppUtilities.drawClearBorderToTextfield(self.txtUserName!, cornerRadius: 5.0, borderRadius: 1.0)
        AppUtilities.drawClearBorderToTextfield(self.txtPassword!, cornerRadius: 5.0, borderRadius: 1.0)
        AppUtilities.drawClearBorderToTextfield(self.txtEmail!, cornerRadius: 5.0, borderRadius: 1.0)
        AppUtilities.drawClearBorderToTextfield(self.birthDateTextField!, cornerRadius: 5.0, borderRadius: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(textField: IQDropDownTextField, didSelectDate date: NSDate?) {
        print(date)
        self.selectedBirthdate = date!
    }
    
    @IBAction func SignUpbtnPressed(sender: AnyObject)
    {
        if sender.tag == 1
        {
            // SignUP phase
            if(self.isValidInformation())
            {
                if flagForImage.length > 0
                {
                    if AppUtilities.isConnectedToNetwork()
                    {
                        self.callAPIforSignUpNewAccount()
                    }
                    else
                    {
                        self.showAlertWithMessage(APP_TITLE, message: INTERNET_CONNECTION_OFF)
                    }
                }
                else
                {
                    AppUtilities.showAlertWithMessage(APP_TITLE, message: "Please choose your profile picture.")
                }
            }
            else
            {
                self.showAlertWithMessage(APP_TITLE, message: "Please enter valid credentials for login.")
            }
        }
        else if sender.tag == 2
        {
            // Sign in phase
           self.navigationController?.popViewControllerAnimated(true)
            
        }
        
    }
    
    @IBAction func btnPickUpImageClicked(sender: AnyObject)
    {
        let optionMenu = UIAlertController(title: nil, message: "Where would you like the image from?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let photoLibraryOption = UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction!) -> Void in
            print("from library")
            //shows the photo library
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .PhotoLibrary
            self.imagePicker.modalPresentationStyle = .Popover
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        })
        let cameraOption = UIAlertAction(title: "Take a photo", style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction!) -> Void in
            print("take a photo")
            //shows the camera
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .Camera
            self.imagePicker.modalPresentationStyle = .Popover
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
            
        })
        let cancelOption = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancel")
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        
        //Adding the actions to the action sheet. Camera will only show up as an option if the camera is available in the first place.
        optionMenu.addAction(photoLibraryOption)
        optionMenu.addAction(cancelOption)
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == true {
            optionMenu.addAction(cameraOption)} else {
            print ("I don't have a camera.")
        }
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        print("finished picking image")
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //handle media here i.e. do stuff with photo
        
        print("imagePickerController called")
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgProfilePic.image = chosenImage
        self.flagForImage = "YES"
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        //what happens when you cancel
        //which, in our case, is just to get rid of the photo picker which pops up
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    func callAPIforSignUpNewAccount()
    {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        let imageData:NSData = UIImagePNGRepresentation(imgProfilePic.image!)!
        let strBase64:String = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)

        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let bdate = dateFormatter.stringFromDate(self.selectedBirthdate)
        
        let urlStr : NSString = NSString(format: "http://atlant.cearsinfotech.com/api.php")
        let dict : NSMutableDictionary = NSMutableDictionary(objects: [(self.txtUserName.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()))!,"12345", strBase64, bdate, (self.txtEmail.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()))!,"signup"], forKeys: [PRM_USERNAME, PRM_PASSWORD, PRM_PROFILE_PIC, PRM_BIRTH_DATE, PRM_EMAIL, PRM_METHOD_TYPE])
        
        let manager :AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        let requestObj : AFHTTPRequestSerializer = AFHTTPRequestSerializer()
        let responseObj : AFHTTPResponseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer = requestObj
        manager.responseSerializer = responseObj
        manager.responseSerializer.acceptableContentTypes = nil
        
        manager.POST(urlStr as String, parameters: dict, success: { (opration : AFHTTPRequestOperation!, responseObject : AnyObject!) -> Void in
            
            do
            {
                let resultOfContact : NSMutableDictionary = try NSJSONSerialization.JSONObjectWithData((responseObject as? NSData)!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableDictionary
                NSLog("Login Response : %@", resultOfContact)
                MBProgressHUD.hideAllHUDsForView(self.view, animated: false)
                
                if resultOfContact.valueForKey("success")?.integerValue == 1
                {
                    let welcomeMessage : NSString = NSString(format: "Welcome to Mr. %@. You are registered successfully.", resultOfContact.valueForKey("data")?.valueForKey("username") as! String)
                    let alertSuccess : UIAlertView = UIAlertView(title: APP_TITLE, message: welcomeMessage as String, delegate: self, cancelButtonTitle: "OK")
                    alertSuccess.tag = 1011
                    alertSuccess.show()
                    
                }
                else
                {
                    AppUtilities.showAlertWithMessage(APP_TITLE, message: resultOfContact.valueForKey("message") as! String)
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

    func isValidInformation()->Bool
    {
        // check Email Address is validate and password is empty or not
        if((AppUtilities.isValidEmailAddress((self.txtEmail!.text)!)) && NSString(string : self.txtUserName!.text!).length != 0 && NSString(string : self.txtPassword!.text!).length != 0)
        {
            return true
        }
        else
        {
            // check Email Is valid or not
            if((AppUtilities.isValidEmailAddress((self.txtEmail?.text)!)))
            {
                // check email is empty or not
                if(NSString(string : self.txtEmail!.text!).length == 0)
                {
                    AppUtilities.drawRedBorderToTextfield(self.txtEmail!, cornerRadius:5.0, borderRadius: 1.0)
                }
                else
                {
                    AppUtilities.drawClearBorderToTextfield(self.txtEmail!, cornerRadius: 5.0, borderRadius: 1.0)
                }
            }
            else
            {
                AppUtilities.drawRedBorderToTextfield(self.txtEmail!, cornerRadius:5.0, borderRadius: 1.0)
            }
            
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

    override func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 1011 {
            if buttonIndex == 0 {
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
}
