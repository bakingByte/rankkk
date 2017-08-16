//
//  PostDetailsViewController.swift
//  RankAppSwift
//
//  Created by mohammad shiblee on 07/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//


import UIKit

class PostDetailsViewController: UIViewController {
    
    var postDetailDict:NSDictionary?
    var postImageStr:NSString = ""
    var loginDetails: NSDictionary!
    
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var lblDisLikeCount: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgBackgroundPost: UIImageView!
    
    @IBOutlet weak var lblCommentCount: UILabel!
    
    @IBAction func backBtn(_ sender: Any) {
        let previousViewController = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationViewController
        self.navigationController?.pushViewController(previousViewController, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
//        lblLikeCount.text = postDetailDict?.value(forKey: "like") as? String ?? ""
//        lblDisLikeCount.text = postDetailDict?.value(forKey: "dislike") as? String ?? ""
//        lblTitle.text = postDetailDict?.value(forKey: "title") as? String ?? ""
//        imgBackgroundPost.image = UIImage(named: postImageStr as? String ?? "")
//        
//        lblCommentCount.text = postDetailDict?.value(forKey: "comment") as? String ?? ""
//        
//        print(postDetailDict ?? "")
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnLikeButtonAction(_ sender: Any) {
        
        let myString = postDetailDict?.value(forKey: "like") as? String ?? ""
        let myInt = Int(myString)
        let b = myInt! - 1
        let c = String(b)
        self.lblLikeCount.text = c
        
        let post_id = postDetailDict?["id"] as? Int ?? 0
        
        loginDetails = ["id": post_id]
        
        print("%@",loginDetails)
        
        let manager          = WebServices()
        manager.getServerDataWith(dict_Parameters: loginDetails, withPostType: kTRIP_LIKE_POST, completionHandler: { (response, responseCode, nil) in
            
            print(response ?? "")
            //            self.getDataOnServer()
            
        })
    }
    
    @IBAction func btnDisLikeButtonAction(_ sender: Any) {
        
        /*
         {
         "id": 1,
         "discription": "<p>Testing</p>\r\n",
         "comment": "1",
         "like": "2",
         "dislike": "2",
         "created_at": "2017-07-04 10:27:11",
         "updated_at": "2017-07-21 14:51:18",
         "deleted_at": null,
         "title": "Testing ",
         "photo": "1499164030-Screenshot_6.png",
         "user_name_id": 44
         }
         dislike
         */
        
        let myString = postDetailDict?.value(forKey: "dislike") as? String ?? ""
        let myInt = Int(myString)
        let b = myInt! - 1
        let c = String(b)
        self.lblDisLikeCount.text = c
        
        let post_id = postDetailDict?["id"] as? Int ?? 0
        
        loginDetails = ["id": post_id]
        
        print("%@",loginDetails)
        
        let manager          = WebServices()
        manager.getServerDataWith(dict_Parameters: loginDetails, withPostType: kTRIP_LIKE_POST, completionHandler: { (response, responseCode, nil) in
            
            print(response ?? "")
            //            self.getDataOnServer()
            
        })
    }
    
    @IBAction func btnCommentButtonAction(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CommentVC") as! CommentViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
//        let message = "Comment"
//        //                let messageName = message + "\"" + (self.ClientName) + "\""
//        
//        let alertController = UIAlertController(title: message as String, message: "", preferredStyle: .alert)
//        
//        let OkAction = UIAlertAction(title: "OK", style: .default, handler: {
//            (action : UIAlertAction!) -> Void in
//            
//            let textField = alertController.textFields![0] as UITextField
//            print(textField)
//            let commentText:NSString = textField.text! as NSString
//            
//            print(commentText)
//            self.CommentDataOnServer(postDetailDict:self.postDetailDict!,commentText:commentText )
//        })
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
//            (action : UIAlertAction!) -> Void in
//            
//            
//        })
//        
//        alertController.addTextField { (textField : UITextField!) -> Void in
//            textField.placeholder = ""
//            textField.textColor = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0)
//            
//        }
//        
//        alertController.addAction(OkAction)
//        alertController.addAction(cancelAction)
//        
//        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func tbnShareButtonAction(_ sender: Any) {
    }
    
    
    func CommentDataOnServer(postDetailDict :NSDictionary, commentText: NSString){
        
        let post_id = postDetailDict["id"] as? Int ?? 0
        
        loginDetails = ["user_id" :"1" ,"post_id": post_id,"comment":commentText]
        
        print("%@",loginDetails)
        
        let manager          = WebServices()
        manager.getServerDataWith(dict_Parameters: loginDetails, withPostType: kTRIP_COMMENT_POST, completionHandler: { (response, responseCode, nil) in
            
            print(response ?? "")
            
        }
        )}
    
    
    
    
    
    
    
    
}

