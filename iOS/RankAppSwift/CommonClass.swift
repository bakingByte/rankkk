//
//  CommonClass.swift
//  MyTrip
//
//  Created by Santosh Maurya on 07/05/17.
//  Copyright © 2017 Santosh Maurya. All rights reserved.
//

import UIKit

class CommonClass: UIViewController {
    
func showPopup(Title : String ,Message : String, Self : UIViewController)  {
    let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
    Self.present(alert, animated: true, completion: nil)
    
    }
}
