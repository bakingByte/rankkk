//
//  CommentViewController.swift
//  RankAppSwift
//
//  Created by mohammad shiblee on 07/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//  c7d02fb1-70b1-481b-bccf-e627cdb2149d.png

import UIKit

class CommentViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var personImagesArray=["c7d02fb1-70b1-481b-bccf-e627cdb2149d.png","c7d02fb1-70b1-481b-bccf-e627cdb2149d.png","c7d02fb1-70b1-481b-bccf-e627cdb2149d.png","c7d02fb1-70b1-481b-bccf-e627cdb2149d.png","c7d02fb1-70b1-481b-bccf-e627cdb2149d.png","c7d02fb1-70b1-481b-bccf-e627cdb2149d.png"]
    var namesArray=["Kanha Pal","Afak Rahman Ash","Gra Ndy","Gra Ndy","KP Goutham","Arman Singh"]
    var messagesArray=["Get engineering books on rent for Gujarat only contact no 9974792746","Nice one","Fallow me","Awesome","I believe in Cloudflare","Nice Bro"]
    var dateTime=["Thu at 3:03PM", "May 20 at 8:43PM","Thu at 3:03PM","May 20 at 8:43PM","Thu at 3:03PM","May 20 at 8:43PM"]
    
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
        cell.dateTimeLbl.text=dateTime[indexPath.row]
        
        return cell
    }

  
}
