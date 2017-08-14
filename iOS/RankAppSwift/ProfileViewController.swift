//
//  ProfileViewController.swift
//  RankAppSwift
//
//  Created by mohammad shiblee on 01/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit
class ProfileViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UIActionSheetDelegate, UIPickerViewDelegate, UITextFieldDelegate, UIPickerViewDataSource
{

    @IBOutlet weak var txtFieldPicker: UITextField!
    
    var  pickerData = ["Hide All","245,India", "12455,World", "245,UP,India"]
    var picker = UIPickerView()
    
    var isOpen:Bool?
    
    
 //   @IBOutlet weak var viewAdd: UIView!
    
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var actionSheetBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var txtView: UITextView!
   
    
    var images=["img1.png","img2.png","img3.png","img4.png","img5.png","img6.png","img7.png","img8.png","img9.png"]
    
    override func viewDidLayoutSubviews()
    {
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 865)
        
       

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.collectionView.delegate=self
        self.collectionView.dataSource=self
        
        picker.delegate = self
        picker.dataSource = self
        txtFieldPicker.inputView = picker
        
        followBtn.layer.cornerRadius = 5
        
      //  clipsToBounds = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    // text view
    
    private func textViewDidBeginEditing(_ textView: UITextView) {
        if txtView.textColor == UIColor.lightGray {
            txtView.text = nil
            txtView.textColor = UIColor.black
        }
    }
    
    private func textViewDidEndEditing(_ textView: UITextView) {
        if txtView.text.isEmpty
        {
            txtView.text = "Write something about your photo"
            txtView.textColor = UIColor.lightGray
        }
    }
    
    
    //***************** CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "CellIdentifier", for: indexPath) as! ProfileCollectionViewCell
        cell.imgView.image=UIImage(named: images[indexPath.row])
        
        return cell
    }

    //******************* Action Sheet
    
    @IBAction func ActionSheetBtnClick(_ sender: UIButton)
    {
        let actionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Report", "Block")
        
        actionSheet.show(in: self.view)
    }

    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int)
    {
        switch (buttonIndex){
            
        case 0:
            print("Cancel")
        case 1:
            print("Report")
        case 2:
            print("Block")
        default:
            print("Default")
        
        }
    }
   // **************** PickerView
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int

    {
        return 1
    }
    
  public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerData.count
    }
    
    
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        txtFieldPicker.text = pickerData[row]
        self.view.endEditing(false)
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
    
//    func textFieldShouldBeginEditing(textField: UITextField) -> Bool
//    {
//        pickerViewOutlet.isHidden = false
//              return false
//    }
//    
    
    
    
 }

