
//
//  NotificationViewController.swift
//  RankAppSwift
//
//  Created by mohammad shiblee on 01/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController, UIScrollViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, NavigationViewDelegate
{
    @IBOutlet weak var postCollectionView: UICollectionView!
    
    @IBOutlet weak var secondPostCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    @IBOutlet weak var searchImgView: UIImageView!
    @IBOutlet weak var searchTF: UITextField!
    
    var postDic:NSMutableArray?
    var postArry:NSDictionary?
    var loginDetails: NSDictionary!
    var commonMethod = CommonClass()
    
    var profileImages:NSArray = ["bitmap.png","bitmapCopy.png","bitmapCopy2.png","bitmapCopy3.png","bitmapCopy4.png","bitmapCopy5.png","bitmapCopy6.png","bitmapCopy7.png","bitmapCopy8.png","bitmapCopy8.png"]
    
    
    override func viewDidLayoutSubviews()
    {
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 1410)
    }
    override func viewDidLoad()
    {
        self.searchTF.delegate=self
        searchTF.endEditing(true)
        
        searchTF.attributedPlaceholder = NSAttributedString(string: "Search",
                                                            attributes: [NSForegroundColorAttributeName: UIColor.white])
        
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            if !(textField.text?.isEmpty)!{
                searchImgView.isHidden = false
                
            } else {
                searchImgView.isHidden = true        }
        }
  
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getDataOnServer()
    }
    
    
    @IBAction func onSecondPostComment(_ sender: Any) {
        
//        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "CommentVC") as! CommentViewController
//        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    //  collectionView Delegate Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //TCell
        if collectionView == postCollectionView
        {
            
            let cellID = "DBPostCell"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! DashboardPostCollectionViewCell
            
                    //  let data: NSDictionary = self.postDic?.object(at: indexPath.row) as? NSDictionary ?? [:]
                    print(self.postDic ?? "")
                    let feedDic:NSDictionary = self.postDic?.object(at: indexPath.row) as? NSDictionary ?? [:]
            
                    cell.delegate = self as? NavigationViewDelegate
//                    cell.selectionStyle = .none
                    cell.tag = indexPath.row
                    let imgName:NSString = profileImages[indexPath.row] as? NSString ?? ""
            
                    print(feedDic)
                    print(imgName)
            
                    cell.setFeedValueOnView(feedDic: feedDic, imgName: imgName)
            
            return cell
            //            }
            //            else{
            //
            //                let cellID = "DBPostCell"
            //                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! DashboardPostCollectionViewCell
            //                cell.postImgView.image.
            //                return cell
            //
            //            }
            
        }
        if collectionView == secondPostCollectionView
        {
            let cellID = "secondDBPostCell"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SecondPostDBCollectionViewCell
            
            
            
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
        
        if collectionView == postCollectionView
        {
        
        print("You tapped cell number \(indexPath.row).")
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "PostDetailsVC") as! PostDetailsViewController
        secondViewController.postDetailDict = self.postDic?.object(at: indexPath.row) as? NSDictionary ?? [:]
        secondViewController.postImageStr = profileImages[indexPath.row] as? NSString ?? ""
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        
        //        if collectionView == postCollectionView
        //        {
        //        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "PostDetailsVC") as! PostDetailsViewController
        //        self.navigationController?.pushViewController(secondViewController, animated: true)
        //        }
        //        else{
        //            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "PostDetailsVC") as! PostDetailsViewController
        //            self.navigationController?.pushViewController(secondViewController, animated: true)
        //        }
        
//        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "PostDetailsVC") as! PostDetailsViewController
//        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == postCollectionView
        {
            let itemWidth = collectionView.bounds.width
            let itemHeight = collectionView.bounds.height
            
            return CGSize(width: itemWidth, height: itemHeight)
        }
        if collectionView == secondPostCollectionView
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
    
        func commentPost(_ sender: AnyObject, feedDetails: NSDictionary, index: Int) {
    
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CommentVC") as! CommentViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
    
        }
    
    
        func getDataOnServer(){
    
            AppDelegate.showPrgressHUD()
    
            let manager          = WebServices()
            manager.getTypeService(withPostType: kTRIP_TRIP_POST, completionHandler: { (response, responseCode, nil) in
                print(response ?? "")
    
                if let response1 = response {
                    if let result = response1["post_data"] as? NSMutableArray {
                        self.postDic = result
                        print(self.postDic ?? "")
                        self.trendingCollectionView.delegate = self
                        self.trendingCollectionView.dataSource = self
                        self.postCollectionView.delegate = self
                        self.postCollectionView.dataSource = self
                    }
                }
                AppDelegate.hidePrgressHUD()
            }
            )}
    
    
    //    func CommentDataOnServer(feedDetails :NSDictionary, commentText: NSString){
    //
    //        let post_id = feedDetails["id"] as? Int ?? 0
    //
    //        loginDetails = ["user_id" :"1" ,"post_id": post_id,"comment":commentText]
    //
    //        print("%@",loginDetails)
    //
    //        let manager          = WebServices()
    //        manager.getServerDataWith(dict_Parameters: loginDetails, withPostType: kTRIP_COMMENT_POST, completionHandler: { (response, responseCode, nil) in
    //
    //            print(response ?? "")
    //            self.getDataOnServer()
    //
    //        }
    //        )}
    
        func likePost(_ sender: AnyObject, feedDetails: NSDictionary, index: Int) {
    
            let post_id = feedDetails["id"] as? Int ?? 0
    
            loginDetails = ["id": post_id]
    
            print("%@",loginDetails)
    
            let manager          = WebServices()
            manager.getServerDataWith(dict_Parameters: loginDetails, withPostType: kTRIP_LIKE_POST, completionHandler: { (response, responseCode, nil) in
    
                print(response ?? "")
                //            self.getDataOnServer()
    
            })
    
        }
    
    
    
        func disLikePost(_ sender: AnyObject, feedDetails: NSDictionary, index: Int) {
    
            let post_id = feedDetails["id"] as? Int ?? 0
    
            loginDetails = ["id": post_id]
    
            print("%@",loginDetails)
    
            let manager          = WebServices()
            manager.getServerDataWith(dict_Parameters: loginDetails, withPostType: kTRIP_LIKE_POST, completionHandler: { (response, responseCode, nil) in
    
                print(response ?? "")
                //            self.getDataOnServer()
                
            })
        }
        
        func sharePost(_ sender: AnyObject, feedDetails: NSDictionary, index: Int) {
        }
}
