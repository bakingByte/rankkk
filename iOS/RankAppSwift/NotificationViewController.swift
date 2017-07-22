//
//  NotificationViewController.swift
//  RankAppSwift
//
//  Created by mohammad shiblee on 01/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var trendingCollectionView: UICollectionView!
    @IBOutlet weak var searchImgView: UIImageView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var table_view: UITableView!
    
    var profileImages:NSArray = ["bitmap.png","bitmapCopy.png","bitmapCopy2.png","bitmapCopy3.png","bitmapCopy4.png","bitmapCopy5.png","bitmapCopy6.png","bitmapCopy7.png","bitmapCopy8.png","bitmapCopy8.png"]
    
    
    var postDic:NSMutableArray?
    var postArry:NSDictionary?
    var loginDetails: NSDictionary!
    var commonMethod = CommonClass()

    override func viewDidLoad()
    {
        
    self.table_view.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostC")
        
        self.getDataOnServer()
        
       self.searchTF.delegate=self
        searchTF.endEditing(true)
    
     func textFieldDidBeginEditing(_ textField: UITextField) {
        if !(textField.text?.isEmpty)!{
            searchImgView.isHidden = false
            
        } else {
            searchImgView.isHidden = true        }
    }

   }
    
    //MARK: -  ############### TableView Delegate Method  ###############
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
//        return (feedArray.count)
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell:PostCell = tableView.dequeueReusableCell(withIdentifier: "PostC") as! PostCell
        
        let data: Dictionary = self.postDic?.object(at: indexPath.row) as? Dictionary ?? [:]
        //            /*
        
      //  "bitmap.png","bitmapCopy.png","bitmapCopy2.png","bitmapCopy3.png","bitmapCopy4.png","bitmapCopy5.png","bitmapCopy6.png","bitmapCopy7.png","bitmapCopy8.png","bitmapCopy8.png"
        //             "id": 1,
        //             "discription": "<p>Testing</p>\r\n",
        //             "comment": "Nice jobs.",
        //             "like": "1",
        //             "dislike": "2",
        //             "created_at": "2017-07-04 10:27:11",
        //             "updated_at": "2017-07-21 14:51:18",
        //             "deleted_at": null,
        //             "title": "Testing ",
        //             "photo": "1499164030-Screenshot_6.png",
        //             "user_name_id": 44
        //             */
        //
        cell.lblTitle.text = data["title"] as? String ?? ""
        cell.lblDiscrobtion.text = data["title"] as? String ?? ""
        cell.lblLikeCount.text = data["like"] as? String ?? ""
        cell.lblDisLikeCount.text = data["dislike"] as? String ?? ""
        
        
        let image = UIImage(named: profileImages[indexPath.row] as? String ?? "")
        cell.imgPost.image = image
        
        cell.btnLike.addTarget(self, action: #selector(self.likeButtonAction), for: .touchUpInside)
        
        cell.btnDisLike.addTarget(self, action: #selector(self.DisLikeButtonAction), for: .touchUpInside)
        
        cell.btnComment.addTarget(self, action: #selector(self.commentButtonAction), for: .touchUpInside)
        
        cell.btnShare.addTarget(self, action: #selector(self.shareButtonAction), for: .touchUpInside)
        

        
//        cell.delegate = self
//        cell.selectionStyle = .none
//        cell.tag = indexPath.row
//        cell.likeBtnTag.tag = indexPath.row
//        let feedDic:NSDictionary = feedArray[indexPath.row ] as? NSDictionary ?? [:]
//        cell.setFeedValueOnView(feedDic: feedDic)
//        cell.editDeleteBtn.isHidden = true
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return 329
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "PostDetailsVC") as! PostDetailsViewController
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
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

            return 10
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //TCell
            let cellID = "TCell"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TrendingCollectionViewCell
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "PostDetailsVC") as! PostDetailsViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)

    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView == postCollectionView
//        {
//            let itemWidth = collectionView.bounds.width
//            let itemHeight = collectionView.bounds.height
//            
//            return CGSize(width: itemWidth, height: itemHeight)
//        }
//        else
//        {
//            let itemHeight = collectionView.bounds.height
//            return CGSize(width: 150, height: itemHeight)
//        }
//        
//    }
    
    func getDataOnServer(){
        
        AppDelegate.showPrgressHUD()
        
            loginDetails = ["":""]
            print("%@",loginDetails)
            let manager          = WebServices()
            manager.getTypeService(withPostType: kTRIP_TRIP_POST, completionHandler: { (response, responseCode, nil) in
                print(response ?? "")
                
                if let response1 = response {
                    if let result = response1["post_data"] as? NSMutableArray {
                        self.postDic = result
                        print(self.postDic ?? "")
                        self.trendingCollectionView.delegate = self
                        self.trendingCollectionView.dataSource = self
                        self.table_view.delegate = self
                        self.table_view.dataSource = self
                    }
                }
                AppDelegate.hidePrgressHUD()
            }
        )}
    
    func likeButtonAction(){
        
    }
    
    func DisLikeButtonAction(){
        
    }
    
    func commentButtonAction(){
        
    }
    
    func shareButtonAction(){
        
    }


   
}
