//
//  LocationViewController.swift
//  RankAppSwift
//
//  Created by mohammad shiblee on 01/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var communitiesCollectionView: UICollectionView!
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
     var storyBoard :UIStoryboard?
    
    var images=["1.png","2.png","3.png","4.png","5.png","6.png","7.png","8.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
       
        self.communitiesCollectionView.delegate=self
        self.communitiesCollectionView.dataSource=self
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
       
            // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 1, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/2-1, height: screenWidth/2-1)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        communitiesCollectionView!.collectionViewLayout = layout
        
        
        
        //Action
        
    }
    func tapDetected() {
        print("Single Tap on imageview")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CustomCollectionViewCell
        cell.collectionImgView.image=UIImage(named: images[indexPath.row])

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChefViewController") as! ChefViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }
    
}
