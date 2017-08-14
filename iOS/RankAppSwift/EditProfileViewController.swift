//
//  EditProfileViewController.swift
//  RankAppSwift
//
//  Created by mohammad shiblee on 21/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLayoutSubviews()
    {
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 730)
        
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
