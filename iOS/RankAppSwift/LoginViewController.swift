//
//  LoginViewController.swift
//  RankAppSwift
//
//  Created by Mohammad Shiblee on 15/06/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txt_username: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    var loginDetails: NSDictionary!
    @IBOutlet weak var lblearnIt: UILabel!
    var commonMethod = CommonClass()
    
    var facebookEmail : String = ""
    var facebookId : String = ""
    var facebookFirstName : String = ""
    var facebookLastName : String = ""
    var facebookURLImage : String = ""
    var facebookData : NSDictionary = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblearnIt.layer.borderWidth = 1.0
        lblearnIt.layer.borderColor = UIColor.white.cgColor
        lblearnIt.layer.masksToBounds = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        
        if isValid(){
            
            AppDelegate.showPrgressHUD()
                    loginDetails = ["email" :txt_username.text ?? "" ,"password":txt_password.text ?? ""]
                    print("%@",loginDetails)
                    let manager          = WebServices()
                    manager.getServerDataWith(dict_Parameters: loginDetails, withPostType: kTRIP_LOGIN, completionHandler: { (response, responseCode, nil) in
                        
                        AppDelegate.hidePrgressHUD()
                        
                        print(response ?? "")
                        if let success = response?["success"] as? NSNumber {
                            if success == 1 {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            self.navigationController?.pushViewController(nextViewController, animated: true)
                            }else{
                            self.commonMethod.showPopup(Title: "Warning", Message: "Email and password do'nt exist!", Self: self)
                            }
                        }
        }
            )}
    }
    
    // Velidation from all text fields
    func isValid() -> Bool
    {
        if txt_username.text!.isEmpty
        {
            commonMethod.showPopup(Title: "Unable to Create Account", Message: "Please provide all the required information.", Self: self)
            return false
        }
        else if !ShowNotificationView().isValidEmail(txt_username.text!)
        {
            commonMethod.showPopup(Title: "Unable to Create Account", Message: "Sorry, the email you entered is not valid.", Self: self)
            return false
        }
        else if txt_password.text!.isEmpty || txt_password.text?.trimmingCharacters(in: .whitespaces) == ""
        {
            commonMethod.showPopup(Title: "Unable to Create Account", Message: "Please provide all the required information.", Self: self)
            return false
        }
        else if txt_password.text!.characters.count < 6  || txt_password.text!.characters.count > 15
        {
            commonMethod.showPopup(Title: "Unable to Create Account", Message: "The passwords do not match.", Self: self)
            return false
        }
        return true
    }
    
    // keybord hide
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        
        self.view .endEditing(true)
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == txt_username {
            guard let text = txt_username.text else { return true }
            let newLength = text.characters.count + string.characters.count - range.length
            if (newLength <= 30 ){
                return true
            }else{
                commonMethod.showPopup(Title: "Name must be under 30 characters.", Message: "", Self: self)
                return false
            }
            
        }else if textField == txt_password {
            guard let text = txt_password.text else { return true }
            let newLength = text.characters.count + string.characters.count - range.length
            if (newLength <= 15 ){
                return true
            }else{
                commonMethod.showPopup(Title:"Password must be under 15 characters.", Message: "", Self: self)
                return false
            }
            
        }else{
            return true
        }
    }
    
    @IBAction func FacebookLoginButton(_ sender: Any) {
    
     view.endEditing(true)
     
     let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
     //fbLoginManager.loginBehavior = FBSDKLoginBehavior.Browser
     fbLoginManager.logOut()
     fbLoginManager.logIn(withReadPermissions: ["public_profile", "email", "user_friends"], from: self, handler: { (result, error) -> Void in
     
     //        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email", "user_friends"], handler: { (result, error) -> Void in
//     AppDelegate.hidePrgressHUD()
     if (error == nil)
     {
     print (result ?? "")
     self.returnUserData()
     
     }
     else
     {
     
     }
     })
     
     
     
     }
     
     func returnUserData(){
     if((FBSDKAccessToken.current()) != nil){
     FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
     if (error == nil){
     if let result = result as? NSDictionary{
     
     if let val = result["email"] as? String{
     // now val is not nil and the Optional has been unwrapped, so use it
     self.facebookEmail = val
     }
     print(self.facebookEmail)
     
     if let val = result.value(forKey: "id") as? String{
     // now val is not nil and the Optional has been unwrapped, so use it
     self.facebookId = val
     self.facebookURLImage  = "https://graph.facebook.com/" + val + "/picture?type=large"
     
     }
     print(self.facebookId)
     
     if let val = result.value(forKey: "name") as? String{
     // now val is not nil and the Optional has been unwrapped, so use it
     self.facebookFirstName = val
     }
     print(self.facebookFirstName)
     
     
     
     //                        if let picture = result.value(forKey: "picture") as? NSDictionary {
     //                            if let data = picture.value(forKey: "data") as? NSDictionary {
     //                                if let url = data.value(forKey: "url") as? String {
     //                                    self.facebookURLImage = url
     //                                }
     //                            }
     //
     //                        }
     print(self.facebookLastName)
     
     
     //{"s_id":"1","login_type":"1","device_type":"A","device_token":"456554654464","prof_image":"","name":"sumit","email":"sumit.shineweb@gmail.com"}
     
     if self.facebookEmail == "" {
//     appDelegate.showPopup(Title: "Please Email public of facebook account to use this app.", Message: "", Self: self)
     
     }
     else {
//     self.facebookLoginSeviceCall()
     }
     
     }
     }
     
     } )
     }
     }
     
     // MARK:- Facebook Login Methods
     func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
     {
     if(error != nil)
     {
     print(error.localizedDescription)
     return
     }
     
     if let userToken = result.token
     {
     // Get User access token
     let token:FBSDKAccessToken = result.token
     
     print("TOken = \(FBSDKAccessToken.current().tokenString)")
     print("User ID = \(FBSDKAccessToken.current().userID)")
     
     //            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
     //            let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("HomTabViewController") as! HomTabViewController
     //            self.navigationController?.pushViewController(nextViewController, animated: true)
     
     
     }
     }
     
     func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
     {
     print("User is logged out")
     }
    
//    func facebookLoginSeviceCall() {
//        
//        //    "s_id":"1","login_type":"1","device_type":"A","device_token":"456554654464","prof_image":"","name":"sumit","email":"sumit.shineweb@gmail.com"
//        
//        // device_id = UserDefaults.standard.value(forKey: "device_id")! as! String
//        loginDetails = ["s_id" : facebookId ,
//                        "login_type" : "1" ,
//                        "name" :facebookFirstName ,
//                        "profile_img" : self.facebookURLImage,
//                        "email":facebookEmail ,
//                        "device_id":appDelegate.deviceId,
//                        "device_type":kDEVICE_TYPE,
//                        "device_token":appDelegate.deviceToken ?? ""
//        ]
//        
//        print("%@",loginDetails)
//        
//        appDelegate.custumIndicatorShow(button: btnFacbook)
//        self.btnFacbook.setTitleColor(UIColor.clear, for: .normal)
//        
//        let manager          = WebServices()
//        manager.getServerDataWith(dict_Parameters: loginDetails, withPostType: kUSER_LOGIN, completionHandler: { (response, responseCode, nil) in
//            
//            appDelegate.custumIndicatorHide()
//            self.btnFacbook.setTitleColor(UIColor.white, for: .normal)
//            
//            if (responseCode?.intValue  == 200){
//                let mainResponse = response?["result"] as? NSDictionary ?? [:]
//                
//                AppDelegate.hidePrgressHUD()
//                appDelegate.mainDic = mainResponse
//                appDelegate.loginDict = mainResponse
//                appDelegate.PayPalConfigrationCheck = ""
//                UserDefaults.standard.set("", forKey: "EDITBUTTONSELECTION")
//                UserDefaults.standard.set("", forKey: "EDITTOBACKBUTTON")
//                print("\n\n login screen DATA AFTER PARSING IS============= \n\n\(appDelegate.mainDic)\n\n\n")
//                
//                do {
//                    UserDefaults.standard.set(mainResponse, forKey: "LoginData")
//                    UserDefaults.standard.set(mainResponse["sessionid"], forKey: "sessionid")
//                    UserDefaults.standard.synchronize()
//                }catch let error as NSError {
//                    print ("error :", error)
//                    UserDefaults.standard.set(nil, forKey: "sessionid")
//                    UserDefaults.standard.set(nil, forKey: "LoginData")
//                    UserDefaults.standard.synchronize()
//                }
//                
//                
//                if let profile_status = mainResponse["profile_status"] as? String {
//                    // if frofile complete
//                    if profile_status == "1" {
//                        
//                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
//                        self.navigationController?.pushViewController(nextViewController, animated: true)
//                        
//                        // if not  frofile complete
//                    } else {
//                        
//                        
//                        
//                        appDelegate.flagStep4Popup = false
//                        appDelegate.flagStep5Popup = false
//                        
//                        let alertView = UIAlertController(title: "HARE Account Creation Successful", message: "Congratulations on your new HARE account. Welcome to the family!", preferredStyle: .alert)
//                        alertView.addAction(UIAlertAction(title: "OK", style: .cancel, handler: self.okButtonClick))
//                        self.present(alertView, animated: true, completion: nil)
//                    }
//                    
//                }
//                
//                
//                
//            }else{
//                if (responseCode?.intValue  == 100){
//                    if let result =  response?["result"] as? String {
//                        appDelegate.showPopup(Title: "Unable to Create Account", Message: result, Self: self)
//                    }
//                    
//                    AppDelegate.hidePrgressHUD()
//                }
//                
//            }
//        })
//    }

}
