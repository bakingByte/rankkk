//
//  SignUpViewController.swift
//  RankAppSwift
//
//  Created by Mohammad Shiblee on 15/06/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var txt_firstname: UITextField!
    @IBOutlet weak var txt_lastname: UITextField!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    var loginDetails: NSDictionary!
        var commonMethod = CommonClass()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSignUp(_ sender: Any){
        
        if isValid(){
//            loginDetails = ["firstname" :txt_firstname.text ?? "" ,"name":txt_lastname.text ?? "","email":txt_email.text ?? "","password":txt_password.text ?? "","device_type":kDEVICE_TYPE_VALUE, "device_id":"wqwqwqwqwqwq","device_token":"hjsaghsahhs", "channel":"APP"]
//            
//            print("%@",loginDetails)
            loginDetails = ["password_confirmation" :txt_password.text ?? "" ,"name":txt_lastname.text ?? "","email":txt_email.text ?? "","password":txt_password.text ?? "", "channel":"APP"]
            
            print("%@",loginDetails)
            
            
            let manager          = WebServices()
            manager.getServerDataWith(dict_Parameters: loginDetails, withPostType: kTRIP_REGISTRATION, completionHandler: { (response, responseCode, nil) in
                
                print(response ?? "")
                
//                self.dismiss(animated: true, completion: nil)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GlobeViewController") as! GlobeViewController
                self.navigationController?.present(nextViewController, animated: true, completion: nil)
                
            }
            )}
    }
    
    // Velidation from all text fields
    func isValid() -> Bool
    {
        if txt_firstname.text!.isEmpty || txt_firstname.text?.trimmingCharacters(in: .whitespaces) == ""
        {
            commonMethod.showPopup(Title: "Unable to Create Account", Message: "Please provide all the required information.", Self: self)
            
            
            return false
        }
        else if txt_email.text!.isEmpty
        {
            
            commonMethod.showPopup(Title: "Unable to Create Account", Message: "Please provide all the required information.", Self: self)
            return false
        }
        else if !ShowNotificationView().isValidEmail(txt_email.text!)
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

    @IBAction func BackButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }

}
