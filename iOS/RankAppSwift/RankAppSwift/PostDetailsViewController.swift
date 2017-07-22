//
//  PostDetailsViewController.swift
//  RankAppSwift
//
//  Created by mohammad shiblee on 07/07/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit

class PostDetailsViewController: UIViewController {

    @IBAction func backBtn(_ sender: Any) {
        let previousViewController = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationViewController
        self.navigationController?.pushViewController(previousViewController, animated: true)
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
