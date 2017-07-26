//
//  ProfileViewController.swift
//  RankAppSwift
//
//  Created by mohammad shiblee on 01/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var followingLbl: UILabel!
    @IBOutlet weak var postlbl: UILabel!
    @IBOutlet weak var followersLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.callLoginApi()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setUpUi(dict:NSDictionary){
        
        
        self.nameLbl.text = dict.object(forKey: "name") as! String?
        self.emailLbl.text = dict.object(forKey: "email") as! String?
         if let following = dict.object(forKey: "following") as? String{
            self.followingLbl.text = following

        }
         if let followers = dict.object(forKey: "followers") as? String {
            self.followersLbl.text = followers

        }
        
         if let posts = dict.object(forKey: "posts") as? String{
            self.postlbl.text = posts

        }
        if let picUrl = dict.object(forKey: "pic"){
            let urlString = "http://api.rankkk.com/uploads/thumb/\(picUrl)"
            if let url = URL.init(string: urlString) {
                profilePic.downloadedFrom(url: url)
            }
        }
      
        

    }
    
    
    func callLoginApi(){
      
            
            AppDelegate.showPrgressHUD()
            
            let manager          = WebServices()
            manager.getTypeService(withPostType: "usersapi/1/", completionHandler: { (response, responseCode, nil) in
                print(response ?? "")
                
                if let response1 = response {
                    
                self.setUpUi(dict: response1)
                
                }
                AppDelegate.hidePrgressHUD()
                }
            )

}
    


}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
