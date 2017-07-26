//
//  ChefViewController.swift
//  RankAppSwift
//
//  Created by mohammad shiblee on 05/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit

class ChefViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var mcCollectionView: UICollectionView!
    @IBOutlet weak var fcCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var storyBoard :UIStoryboard?
    
     var fImages=["fchef1402x.png","fchef2402x.png","fchef3402x.png","fchef1402x.png","fchef2402x.png","fchef3402x.png"]
    
    var fChefNames=["Rose","Siri","Katy","Rose","Siri","Katy"]
    var mImages=["chef1402x.png","chef2402x.png","chef3402x.png","chef1402x.png","chef2402x.png","chef3402x.png"]
    
    var mChefNames=["David","Albert","Shaan","David","Albert","Shaan"]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/4)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.scrollDirection = .horizontal
        mcCollectionView!.collectionViewLayout = layout
        
        // Do any additional setup after loading the view, typically from a nib.
        let layout1: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout1.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout1.itemSize = CGSize(width: screenWidth/3, height: screenWidth/4)
        layout1.minimumInteritemSpacing = 1
        layout1.minimumLineSpacing = 1
        layout1.scrollDirection = .horizontal
        fcCollectionView!.collectionViewLayout = layout1
        
        
        
    }
    
    //TableView Delegate Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "Cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ChefTableViewCell
        return cell
        
        
    }
    
    
    //Collection view data source methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
     /*   var cell1: MaleChefCollectionViewCell!
        var cell2: FemaleChefCollectionViewCell!
         if((indexPath.row + 2) % 2 == 0) {
           cell1=collectionView.dequeueReusableCell(withReuseIdentifier: "mCell", for: indexPath) as! MaleChefCollectionViewCell
            cell1.chefImageBtn.setImage(UIImage(named: mImages[indexPath.row], for: <#T##UIControlState#>))
            return cell1
        }
        else{
            cell2=collectionView.dequeueReusableCell(withReuseIdentifier: "fCell", for: indexPath) as! FemaleChefCollectionViewCell
        }
        return cell2*/
        let cellID = "Cell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        return cell
       
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
