//
//  PostToRankViewController.swift
//  RankAppSwift
//
//  Created by Mohammad Shiblee on 25/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class PostToRankViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate{
    
//    var imageCropVC : RSKImageCropViewController!
//    var refreshControl: UIRefreshControl!
    var imagePickerView = UIImagePickerController()
    @IBOutlet weak var txtView: UITextView!
    var imageArray = NSMutableArray()
    var stylist_id = NSNumber()
    var postImage:UIImage!
//    weak var delegate : PostVCDelegate?
    var spaceValidation:String = ""
    
    @IBOutlet weak var showPostImgView: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var txt_description: UITextField!
    
//    @IBOutlet weak var postIndicator: UIActivityIndicatorView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var postBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        postIndicator.isHidden = true
        
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        IQKeyboardManager.sharedManager().shouldShowTextFieldPlaceholder = false
        IQKeyboardManager.sharedManager().shouldHidePreviousNext = false
        
//        imgView.image = postImage
//        imageArray.add(postImage)
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
    
    @IBAction func addGallaryOrVideoSelectionAction(_ sender: Any) {
        
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let addAlertAction: UIAlertAction = UIAlertAction(title: "Gallery", style: .default) { action -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                self.imagePickerView.delegate = self
                self.imagePickerView.sourceType = UIImagePickerControllerSourceType.photoLibrary;
                self.imagePickerView.allowsEditing = false
                self.imagePickerView.navigationBar.isTranslucent = false
                //  self.imagePickerView.navigationBar.tintColor = .black
                //  self.imagePickerView.navigationBar.barTintColor = .black
                
                //                self.imagePickerView.navigationBar.barTintColor = .black // Background color
                //                self.imagePickerView.navigationBar.tintColor = UIColor.white // Cancel button ~ any UITabBarButton items
                //                self.imagePickerView.navigationBar.titleTextAttributes = [
                //                    NSForegroundColorAttributeName : UIColor.white
                //                ]
                UIApplication.shared.statusBarStyle = .default
                self.present(self.imagePickerView, animated: true, completion: nil)
                
            }
        }
        
        let alertAction: UIAlertAction = UIAlertAction(title: "Camera", style: .default) { action -> Void in
            print("Camera")
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                self.imagePickerView.delegate = self
                self.imagePickerView.sourceType = UIImagePickerControllerSourceType.camera;
                self.imagePickerView.allowsEditing = false
                self.present(self.imagePickerView, animated: true, completion: nil)
            }
        }
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        
        controller.addAction(addAlertAction)
        controller.addAction(alertAction)
        controller.addAction(cancelActionButton)
        present(controller, animated: true, completion: nil)
        
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
        
//        postIndicator.isHidden = false
//        postIndicator.startAnimating()
//        postBtn.isEnabled = false
//        postBtn.setTitle("", for: .normal)
//        backBtn.isEnabled = false
//        txt_description.isEnabled = false
        
        
//        if let mainData = appDelegate.loginDict {
//            stylist_id = mainData["stylist_id"] as? NSNumber ?? 0
//        }
        let detailsDict: NSDictionary! = ["user_name_id":44,"description":txtView.text ?? "","title": txt_description.text ?? "","imagePathKey":"image" ]
        print(imageArray)
        
        let manager          = WebServices()
        manager.postToServerWithData(dict_Parameters: detailsDict, withPostType: kADD_POST, andImages: imageArray, completionHandler: { (response, responseCode, nil) in
            
            if (responseCode?.intValue == 200 ){
//                self.delegate?.uploadCompleted()
//                self.postIndicator.stopAnimating()
                self.txt_description.text = nil
                self.view .endEditing(true)
//                self.postIndicator.isHidden = true
                self.postBtn.isEnabled = true
                self.postBtn.setTitle("Post", for: .normal)
                self.backBtn.isEnabled = true
                self.txt_description.isEnabled = true
                self.navigationController?.popViewController(animated: true)
                
            }else if (responseCode?.intValue == 100 ){
//                self.postIndicator.stopAnimating()
                self.txt_description.text = nil
                self.view .endEditing(true)
//                self.postIndicator.isHidden = true
                self.postBtn.isEnabled = true
                self.postBtn.setTitle("Post", for: .normal)
                self.backBtn.isEnabled = true
                self.txt_description.isEnabled = true
            }else if (responseCode?.intValue == 10){
                
                appDelegate.showPopup(Title: "Oops", Message: "The request timed out.", Self: self)
//                self.postIndicator.stopAnimating()
                //                self.txt_description.text = nil
                self.view .endEditing(true)
//                self.postIndicator.isHidden = true
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        UIApplication.shared.statusBarStyle = .lightContent
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.dismiss(animated: false, completion: { () -> Void in
                UIApplication.shared.statusBarStyle = .lightContent
                print(image)
                
                self.postImage = image
                self.imageArray.add(self.postImage)
//                UserDefaults.standard.set("post", forKey: "background")
//                let imageCropViewController = CDPImageCropViewController(image: image)
//                imageCropViewController?.delegate = self
//                print(image)
//                self.present(imageCropViewController!, animated: true, completion: nil)
                
                
                // nagendra
                
////                self.imageCropVC = RSKImageCropViewController(image: image, cropMode: RSKImageCropMode.custom)
////                
////                self.imageCropVC.delegate = self
////                
////                self.imageCropVC.dataSource = self
//                
//                self.navigationController?.present(self.imageCropVC, animated: true, completion: nil)
                
            })
        }
    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
//    {
//        self.dismiss(animated: false, completion: { () -> Void in
//            UIApplication.shared.statusBarStyle = .lightContent
//        })
//    }
//    // datasouce mettods
//    
//    func imageCropViewControllerCustomMaskRect(_ controller: RSKImageCropViewController) -> CGRect {
//        var maskSize = CGSize.zero
//        if controller.isPortraitInterfaceOrientation() {
//            maskSize = CGSize(width: CGFloat(SCREEN_WIDTH), height: CGFloat(205))
//        }
//        else {
//            maskSize = CGSize(width: CGFloat(220), height: CGFloat(205))
//        }
//        let viewWidth: CGFloat = controller.view.frame.width
//        let viewHeight: CGFloat = controller.view.frame.height
//        let maskRect = CGRect(x: CGFloat((viewWidth - maskSize.width) * 0.5), y: CGFloat((viewHeight - maskSize.height) * 0.5), width: CGFloat(maskSize.width), height: CGFloat(maskSize.height))
//        return maskRect
//        
//    }
//    
//    func imageCropViewControllerCustomMaskPath(_ controller: RSKImageCropViewController) -> UIBezierPath {
//        let rect: CGRect = controller.maskRect
//        //        let point1 = CGPoint(x: CGFloat(rect.minX), y: CGFloat(rect.maxY))
//        //        let point2 = CGPoint(x: CGFloat(rect.maxX), y: CGFloat(rect.maxY))
//        //        let point3 = CGPoint(x: CGFloat(rect.midX), y: CGFloat(rect.minY))
//        //        let triangle = UIBezierPath()
//        //        triangle.move(to: point1)
//        //        triangle.addLine(to: point2)
//        //        triangle.addLine(to: point3)
//        //        triangle.close()
//        return UIBezierPath.init(rect: rect)
//    }
//    
//    
//    func imageCropViewControllerCustomMovementRect(_ controller: RSKImageCropViewController) -> CGRect {
//        
//        return controller.maskRect
//    }
//    
//    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
//        self.dismiss(animated: false, completion: { () -> Void in
//            UIApplication.shared.statusBarStyle = .lightContent
//        })
//    }
//    
//    
//    func imageCropViewController(_ controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect) {
//        
//        self.dismiss(animated: false, completion: { () -> Void in
//            UIApplication.shared.statusBarStyle = .lightContent
//            self.confirmClick(with: croppedImage)
//        })
//        
//    }
//    
//    
//    func confirmClick(with image: UIImage) {
//        
//        print(image)
//        
////        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
////        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "postVC") as! postVC
//        postImage = image
//        imageArray.add(postImage)
//        print(imageArray)
////        nextViewController.delegate = self
////        self.navigationController?.pushViewController(nextViewController, animated: true)
////        
////        self.dismiss(animated: true, completion: nil)
//    }


}
