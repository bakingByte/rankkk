//
//  BlockListViewController.swift
//  RankAppSwift
//
//  Created by Mohammad Shiblee on 24/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit

class BlockListViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var tblView: UITableView!
    
    var personImagesArray=["c7d02fb1-70b1-481b-bccf-e627cdb2149d.png","c7d02fb1-70b1-481b-bccf-e627cdb2149d.png","c7d02fb1-70b1-481b-bccf-e627cdb2149d.png","c7d02fb1-70b1-481b-bccf-e627cdb2149d.png","c7d02fb1-70b1-481b-bccf-e627cdb2149d.png","c7d02fb1-70b1-481b-bccf-e627cdb2149d.png","c7d02fb1-70b1-481b-bccf-e627cdb2149d.png","c7d02fb1-70b1-481b-bccf-e627cdb2149d.png","c7d02fb1-70b1-481b-bccf-e627cdb2149d.png","c7d02fb1-70b1-481b-bccf-e627cdb2149d.png","c7d02fb1-70b1-481b-bccf-e627cdb2149d.png","c7d02fb1-70b1-481b-bccf-e627cdb2149d.png"]
    var namesArray=["amanraj14","amanraj14","amanraj14","amanraj14","amanraj14","amanraj14","amanraj14","amanraj14","amanraj14","amanraj14","amanraj14","amanraj14"]
    var messagesArray=["Aman Rajput","Aman Rajput","Aman Rajput","Aman Rajput","Aman Rajput","Aman Rajput","Aman Rajput","Aman Rajput","Aman Rajput","Aman Rajput","Aman Rajput","Aman Rajput"]
    
    override func viewDidLayoutSubviews()
    {
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 720)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tblView.delegate  = self
        self.tblView.dataSource = self

        // Do any additional setup after loading the view.
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
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "CommentCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! BlockTableViewCell
        cell.imgView.image = UIImage(named: (personImagesArray[indexPath.row]))
        cell.lblName.text = namesArray[indexPath.row]
        cell.lblNameID.text=messagesArray[indexPath.row]
        
        return cell
    }


    

}
