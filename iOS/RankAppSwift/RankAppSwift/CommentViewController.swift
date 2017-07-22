//
//  CommentViewController.swift
//  RankAppSwift
//
//  Created by mohammad shiblee on 07/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var personImagesArray=["user1402x.png","user2402x.png","user3402x.png","user2402x.png","user3402x.png","user4402x.png"]
    var namesArray=["Kanha Pal","Afak Rahman Ash","Gra Ndy","Gra Ndy","KP Goutham","Arman Singh"]
    var messagesArray=["Get engineering books on rent for Gujarat only contact no 9974792746","Nice one","Fallow me","Awesome","I believe in Cloudflare","Nice Bro"]

    override func viewDidLoad() {
        super.viewDidLoad()

       // self.tabBarController?.tabBar.isHidden = true

        
        self.tableView.delegate  = self
        self.tableView.dataSource = self
        

    }

    @IBAction func onBackBtnClick(_ sender: Any) {
        
        let previousViewController = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationViewController
        self.navigationController?.pushViewController(previousViewController, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personImagesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "CommentCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CommentTVCell
        cell.personImgView.image = UIImage(named: (personImagesArray[indexPath.row]))
        cell.nameLbl.text = namesArray[indexPath.row]
        cell.messageLbl.text=messagesArray[indexPath.row]
        
        return cell
    }

  
}
