//
//  PostToRankViewController.swift
//  RankAppSwift
//
//  Created by Mohammad Shiblee on 25/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class PostToRankViewController: UIViewController {

     @IBOutlet weak var txtView: UITextView!
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
    
//        txtView.text = "Write few words"
//        txtView.textColor = UIColor.lightGray
//        txtView.becomeFirstResponder()
//        
//        txtView.selectedTextRange = txtView.textRange(from: txtView.beginningOfDocument, to: txtView.beginningOfDocument)
//        
//        txtView.layer.borderWidth = 1
//       // txtView.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
//        
//         txtView!.layer.borderColor = UIColor.green.cgColor
//        
//    // 5f9621
        
      
//    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    // text view
//    
//    private func textViewDidBeginEditing(_ textView: UITextView) {
//        if txtView.textColor == UIColor.lightGray {
//            txtView.text = nil
//            txtView.textColor = UIColor.black
//        }
//    }
//    
//    private func textViewDidEndEditing(_ textView: UITextView) {
//        if txtView.text.isEmpty
//        {
//            txtView.text = "Write few words"
//            txtView.textColor = UIColor.lightGray
//        }
//    }
    
    var imageArray = NSMutableArray()
    var stylist_id = NSNumber()
    var postImage:UIImage!
//    weak var delegate : PostVCDelegate?
    
    var spaceValidation:String = ""
    
    @IBOutlet weak var showPostImgView: UIButton!
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var txt_description: UITextField!
    
    @IBOutlet weak var postIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var postBtn: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postIndicator.isHidden = true
        
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        IQKeyboardManager.sharedManager().shouldShowTextFieldPlaceholder = false
        IQKeyboardManager.sharedManager().shouldHidePreviousNext = false
        
        imgView.image = postImage
        imageArray.add(postImage)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func postButtonSelectionAction(_ sender: Any) {
        
    }
    
    @IBAction func postButtonAction(_ sender: Any) {
        
        self.view .endEditing(true)
        spaceValidation = (txt_description.text?.trimmingCharacters(in: .whitespaces))!
        if spaceValidation == "" || spaceValidation == " "{
            appDelegate.showPopup(Title: "Oops", Message: "Please enter a description", Self: self)
        }else if ((txt_description.text?.characters.count)! > 200){
            appDelegate.showPopup(Title: "Oops", Message: "Descriptions must be under 200 characters.", Self: self)
        }else{
            txt_description.text = spaceValidation
            self.setImageWithDescreptionOnServer()
        }
    }
    
    func setImageWithDescreptionOnServer(){
        
        postIndicator.isHidden = false
        postIndicator.startAnimating()
        postBtn.isEnabled = false
        postBtn.setTitle("", for: .normal)
        backBtn.isEnabled = false
        txt_description.isEnabled = false
        
        
//        if let mainData = appDelegate.loginDict {
//            stylist_id = mainData["stylist_id"] as? NSNumber ?? 0
//        }
        let detailsDict: NSDictionary! = ["stylist_id":stylist_id,"desc":txt_description.text ?? "","imagePathKey":"image" ]
        
        let manager          = WebServices()
        manager.postToServerWithData1(dict_Parameters: detailsDict, withPostType: kADD_POST, andImages: imageArray, completionHandler: { (response, responseCode, nil) in
            
            if (responseCode?.intValue == 200 ){
//                self.delegate?.uploadCompleted()
                self.postIndicator.stopAnimating()
                self.txt_description.text = nil
                self.view .endEditing(true)
                self.postIndicator.isHidden = true
                self.postBtn.isEnabled = true
                self.postBtn.setTitle("Post", for: .normal)
                self.backBtn.isEnabled = true
                self.txt_description.isEnabled = true
                self.navigationController?.popViewController(animated: true)
                
            }else if (responseCode?.intValue == 100 ){
                self.postIndicator.stopAnimating()
                self.txt_description.text = nil
                self.view .endEditing(true)
                self.postIndicator.isHidden = true
                self.postBtn.isEnabled = true
                self.postBtn.setTitle("Post", for: .normal)
                self.backBtn.isEnabled = true
                self.txt_description.isEnabled = true
            }else if (responseCode?.intValue == 10){
                
                appDelegate.showPopup(Title: "Oops", Message: "The request timed out.", Self: self)
                self.postIndicator.stopAnimating()
                //                self.txt_description.text = nil
                self.view .endEditing(true)
                self.postIndicator.isHidden = true
                self.postBtn.isEnabled = true
                self.postBtn.setTitle("Post", for: .normal)
                self.backBtn.isEnabled = true
                self.txt_description.isEnabled = true
                
            }
        })
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        self.view .endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == txt_description {
            guard let text = txt_description.text else { return true }
            
            
            let newLength = text.characters.count + string.characters.count - range.length
            if (newLength <= 200 ){
                return true
            }else{
                self.showMessagePopUpAction()
                return false
            }
        }else{
            return true
        }
    }
    
    
    func showMessagePopUpAction() {
        
        let controller = UIAlertController(title: "Oops", message: "Descriptions must be under 200 characters.", preferredStyle: .alert)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in
            print("OK")
        }
        controller.addAction(cancelActionButton)
        present(controller, animated: true, completion: nil)
        
    }


}
