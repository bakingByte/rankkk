//
//  NotificationViewController.swift
//  RankAppSwift
//
//  Created by mohammad shiblee on 01/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController, UIScrollViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    @IBOutlet weak var postCollectionView: UICollectionView!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    @IBOutlet weak var searchImgView: UIImageView!
    @IBOutlet weak var searchTF: UITextField!
//    @IBOutlet weak var searchImageView: UIImageView!
//    @IBOutlet weak var searchTF: UITextField!
//    @IBOutlet weak var scroll_view1: UIScrollView!
//    
//    @IBOutlet weak var scroll_view2: UIScrollView!
//    @IBOutlet weak var pic1: UIImageView!
//    @IBOutlet weak var postScroll_View: UIScrollView!
//    @IBOutlet weak var pic2: UIImageView!
//    @IBOutlet weak var pic3: UIImageView!
//    @IBOutlet weak var view1: UIView!
//    @IBOutlet weak var view2: UIView!
//    @IBOutlet weak var view3: UIView!
    
    override func viewDidLayoutSubviews()
    {
     scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 550)
    }
    override func viewDidLoad()
    {
        
       self.searchTF.delegate=self
        searchTF.endEditing(true)
      
//
////        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
//           tap.cancelsTouchesInView = false
//            view.addGestureRecognizer(tap)
//
//    }
//    
//    func dismissKeyboard() {
//        //Causes the view (or one of its embedded text fields) to resign the first responder status.
//         searchImgView.isHidden = false
//        view.endEditing(true)
//    }
//
//    
     func textFieldDidBeginEditing(_ textField: UITextField) {
        if !(textField.text?.isEmpty)!{
            searchImgView.isHidden = false
            
        } else {
            searchImgView.isHidden = true        }
    }

  
   }
    
    
    @IBAction func commentClick(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "CommentVC") as! CommentViewController
                self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    //collectionView Delegate Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //TCell
        if collectionView == postCollectionView
        {
            let cellID = "DBPostCell"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! DashboardPostCollectionViewCell
            return cell
            
        }
        else
        {
            let cellID = "TCell"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TrendingCollectionViewCell
            return cell
        }
       
        
        // Configure the cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "PostDetailsVC") as! PostDetailsViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == postCollectionView
        {
            let itemWidth = collectionView.bounds.width
            let itemHeight = collectionView.bounds.height
            
            return CGSize(width: itemWidth, height: itemHeight)
        }
        else
        {
            let itemHeight = collectionView.bounds.height
            return CGSize(width: 150, height: itemHeight)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
