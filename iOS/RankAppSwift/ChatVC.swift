//
//  ChatVC.swift
//  RankAppSwift
//
//  Created by ABCD on 05/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit

class ChatVC: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var titleArray = NSArray()
    var imagesarray = NSArray()
    
    
    @IBOutlet weak var chat_tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
         titleArray = ["Rank Team","Nitin Peter","Nitin Peter","Nitin Peter","Nitin Peter","Nitin Peter","Nitin Peter"]
        imagesarray = ["Amit.png","Sacin.png","Salman.png","images.jpeg","image3x.png","man.jpeg","man.jpeg"]
        
        self.chat_tableview.delegate  = self
        self.chat_tableview.dataSource = self
        
    
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dotClicked(_ sender: Any) {
        let popvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopView") as! PopOverViewController
        
        self.addChildViewController(popvc)
        
        popvc.view.frame = self.view.frame
        
        self.view.addSubview(popvc.view)
        
        popvc.didMove(toParentViewController: self)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "Cell"
        let cell = chat_tableview.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ChatTVCell
        cell.chatperson_image.image = UIImage(named: (imagesarray.object(at: indexPath.row) as? String)!)
        cell.charperson_name.text = titleArray.object(at: indexPath.row) as? String
        
        return cell
    }

}
