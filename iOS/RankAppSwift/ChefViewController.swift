//
//  ChefViewController.swift
//  RankAppSwift
//
//  Created by mohammad shiblee on 05/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit

class ChefViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var mcCollectionView: UICollectionView!
    @IBOutlet weak var fcCollectionView: UICollectionView!
    @IBOutlet weak var cpCollectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var countryBtnOutlet: UIButton!
    @IBOutlet weak var worldBtnOutlet: UIButton!
    @IBOutlet weak var cityBtnOutlet: UIButton!
    
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var storyBoard :UIStoryboard?
    
    var images=["img1.png","img2.png","img3.png","img4.png","img5.png","img6.png","img7.png","img8.png","img9.png"]

    
    override func viewDidLayoutSubviews()
    {
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 730)
    }

     var fImages=["fchef1402x.png","fchef2402x.png","fchef3402x.png","woman2.png","woman1.png","woman2.png","woman2.png","woman1.png","woman2.png","woman1.png"]
     var fChefNames=["Rose","Siri","Katy","Rose","Siri","Katy","Rose","Siri","Katy","Rose"]
    
     var mImages=["chef1402x.png","chef2402x.png","chef3402x.png","1097d04c-e464-4348-b2ab-57070d675a6f.png","d0d6996c-060c-442d-80b9-44acf3bed6d0.png","1097d04c-e464-4348-b2ab-57070d675a6f.png","1097d04c-e464-4348-b2ab-57070d675a6f.png","d0d6996c-060c-442d-80b9-44acf3bed6d0.png","1097d04c-e464-4348-b2ab-57070d675a6f.png","d0d6996c-060c-442d-80b9-44acf3bed6d0.png"]
     var mChefNames=["David","Albert","Shaan","David","Albert","Shaan","David","Albert","Shaan","David"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        // Do any additional setup after loading the view, typically from a nib.
        let layout1: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout1.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout1.itemSize = CGSize(width: screenWidth/3, height: screenWidth/4)
        layout1.minimumInteritemSpacing = 1
        layout1.minimumLineSpacing = 1
        layout1.scrollDirection = .horizontal
       // mcCollectionView!.collectionViewLayout = layout1
        
        // Do any additional setup after loading the view, typically from a nib.
        let layout2: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout2.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout2.itemSize = CGSize(width: screenWidth/3, height: screenWidth/4)
        layout2.minimumInteritemSpacing = 1
        layout2.minimumLineSpacing = 1
        layout2.scrollDirection = .horizontal
       // fcCollectionView!.collectionViewLayout = layout2
        
        let layout3: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout3.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout3.itemSize = CGSize(width: screenWidth/3, height: screenWidth/4)
        layout3.minimumInteritemSpacing = 1
        layout3.minimumLineSpacing = 1
        layout3.scrollDirection = .horizontal
       // cpCollectionView!.collectionViewLayout = layout3
        
        // world button color
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.worldBtnOutlet.frame
        rectShape.position = self.worldBtnOutlet.center
        rectShape.path = UIBezierPath(roundedRect: self.worldBtnOutlet.bounds, byRoundingCorners: [.bottomLeft, .topLeft], cornerRadii: CGSize(width: 40, height: 40)).cgPath
        
        self.worldBtnOutlet.layer.backgroundColor = UIColor.orange.cgColor
        //Here I'm masking the textView's layer with rectShape layer
        self.worldBtnOutlet.layer.mask = rectShape
        
        
    }
    
    
    @IBAction func clickCountryBtn(_ sender: UIButton)
    {
         countryBtnOutlet.backgroundColor = UIColor.orange
    }
    
    @IBAction func clickCityBtn(_ sender: UIButton)
    {
//        let rectShape = CAShapeLayer()
//        rectShape.bounds = self.cityBtnOutlet.frame
//        rectShape.position = self.cityBtnOutlet.center
//        rectShape.path = UIBezierPath(roundedRect: self.cityBtnOutlet.bounds, byRoundingCorners: [.bottomRight, .topRight], cornerRadii: CGSize(width: 40, height: 40)).cgPath
//        
//        self.cityBtnOutlet.layer.backgroundColor = UIColor.orange.cgColor
//        //Here I'm masking the textView's layer with rectShape layer
//        self.cityBtnOutlet.layer.mask = rectShape
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
        
        //return images.count
        return mImages.count
        return images.count
    }
    
    
   /*
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell 
     {
 
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ChefPostCollectionViewCell
        cell.chefPostImageView.image=UIImage(named: images[indexPath.row])
        
        return cell
    }
 */
  
  //  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
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
//        
//        let cellID = "Cell"
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
//        
//        return cell
    
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
        {
            
            if collectionView == mcCollectionView
            {
                  let cell=mcCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MaleChefCollectionViewCell
//                  cell.imgMale.image=UIImage(named: mImages[indexPath.row])
            
            return cell
                
            }
            
            if collectionView == fcCollectionView
            {
                let cell=fcCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FemaleChefCollectionViewCell
//                cell.imgFemailView.image=UIImage(named: fImages[indexPath.row])

            return cell
            
            }
            
            else
            {
                let cell=cpCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ChefPostCollectionViewCell
//                cell.chefPostImageView.image=UIImage(named: images[indexPath.row])
                
                return cell
                
            }
        }


}
