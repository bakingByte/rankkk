//
//  PostCell.swift
//  RankAppSwift
//
//  Created by Santosh Maurya on 22/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    weak var delegate:NavigationViewDelegate?
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDiscrobtion: UILabel!
    
    @IBOutlet weak var imgPost: UIImageView!
    
    @IBOutlet weak var btnLike: UIButton!
    
    @IBOutlet weak var btnDisLike: UIButton!
    
    @IBOutlet weak var btnComment: UIButton!
    
    @IBOutlet weak var btnShare: UIButton!
    
    @IBOutlet weak var lblCommentCount: UILabel!
    
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var lblDisLikeCount: UILabel!
    
    var profileImages:NSArray = ["bitmap.png","bitmapCopy.png","bitmapCopy2.png","bitmapCopy3.png","bitmapCopy4.png","bitmapCopy5.png","bitmapCopy6.png","bitmapCopy7.png","bitmapCopy8.png","bitmapCopy8.png"]
    
    var likeCount = 0
    var dic:NSDictionary?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setFeedValueOnView(feedDic :NSDictionary, imgName :NSString)
    {
        print(feedDic)
        print(imgName)
        
        
        dic = feedDic
        print(dic ?? "")
        
        lblTitle.text = feedDic["title"] as? String ?? ""
        lblDiscrobtion.text = feedDic["title"] as? String ?? ""
        lblLikeCount.text = feedDic["like"] as? String ?? ""
        lblDisLikeCount.text = feedDic["dislike"] as? String ?? ""
        lblCommentCount.text = feedDic["comment"] as? String ?? ""
        
        let image = UIImage(named: imgName as String)
        imgPost.image = image
//        if let profileImageUrl  =   NSURL(string: feedDic["profile_img"] as? String ?? ""){
//            //            profile_image.sd_setImage(with: profileImageUrl as URL!)
//            profile_image.sd_setImage(with: profileImageUrl as URL!, placeholderImage: #imageLiteral(resourceName: "DefaultUserPick"),options:.progressiveDownload)
//            
//        }
//        
//        lbl_userName.text = feedDic["name"] as? String ?? ""
//        likeCount = Int(feedDic["like_count"] as? NSNumber ?? 0)
//        let postImageUrl  =   NSURL(string: (feedDic["post_image"] as? String) ?? "")
//        
//        img_homeFeed.setIndicatorStyle(UIActivityIndicatorViewStyle.gray)
//        img_homeFeed.setShowActivityIndicator(true)
//        //img_homeFeed.sd_setImage(with: postImageUrl as URL!)
//        img_homeFeed.sd_setImage(with: postImageUrl as URL!, placeholderImage: nil ,options:.progressiveDownload)
//        lbl_like_no.text = String(describing: likeCount )
//        
//        let commentCount = feedDic["comment_count"] as? NSNumber ?? 0
//        lbl_comment_no.text = String(describing: commentCount )
//        lbl_cutNamePrice.text = feedDic["description"] as? String ?? ""
//        
//        /*
//         "post_id": 26,
//         "post_image": "http://132.148.82.33:3004/posts/26/IMG-20170107-WA0004.jpeg",
//         "post_by": 1,
//         "is_for": "0",
//         "description": "hello sir ",
//         "like_count": 0,
//         "comment_count": 2,
//         "post_status": "0",
//         "createdon": "2017-01-20T09:12:59.000Z"
//         */
//        
//        print(feedDic["is_liked"] as? Int ?? 0)
//        let islike = feedDic["is_liked"] as? Int ?? 0
//        
//        if islike == 0
//        {
//            if let image = UIImage(named: "feed_Cell_like_img") {
//                like_btn.setImage(image, for: .normal)
//            }
//        }
//        else if islike == 1
//        {
//            if let image = UIImage(named: "feed_Cell_like_selected_img") {
//                like_btn.setImage(image, for: .normal)
//            }
//        }
    }
    
//            self.delegate?.likeFeed!(sender as AnyObject, feedDetails: dic!, index: (sender as AnyObject).tag)
    
    @IBAction func btnLikeButtonAction(_ sender: Any) {
        let myString = lblLikeCount.text
        let myInt = Int(myString!)
        let b = myInt! + 1
        let c = String(b)
        self.lblLikeCount.text = c

        self.delegate?.likePost!(sender as AnyObject, feedDetails: dic!, index: (sender as AnyObject).tag)
    }
    
    @IBAction func btnDisLikeButtonAction(_ sender: Any) {
        
        let myString = lblDisLikeCount.text
        let myInt = Int(myString!)
        let b = myInt! - 1
        let c = String(b)
        self.lblDisLikeCount.text = c
        
        self.delegate?.disLikePost!(sender as AnyObject, feedDetails: dic!, index: (sender as AnyObject).tag)
    }
    @IBAction func btnCommentButtonAction(_ sender: Any) {
    self.delegate?.commentPost!(sender as AnyObject, feedDetails: dic!, index: (sender as AnyObject).tag)
    }
    @IBAction func btnShareButtonAction(_ sender: Any) {
        self.delegate?.sharePost!(sender as AnyObject, feedDetails: dic!, index: (sender as AnyObject).tag)
    }
    
//    @objc optional func  likePost(_ sender: AnyObject,feedDetails:NSDictionary, index:Int)
//    @objc optional func  disLikePost(_ sender: AnyObject,feedDetails:NSDictionary, index:Int)
//    @objc optional func  sharePost(_ sender: AnyObject,feedDetails:NSDictionary, index:Int)
    
}
