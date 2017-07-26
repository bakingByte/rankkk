//
//  ShowNotificationView.swift
//  HARE
//
//  Created by Shineweb-solutions on 12/07/16.
//  Copyright © 2016 SWS. All rights reserved.
//

import UIKit

class ShowNotificationView: NSObject
{
    var notificationView: SFSwiftNotification?


    func showNotificationAlert(_ title:String)
    {
        self.notificationView = SFSwiftNotification(frame: CGRect(x: 0, y: 0,width: (UIScreen.main.bounds.size.width), height: 65), title:title, animationType: .collision, direction: .topToBottom)
        
        self.notificationView!.animate(1)
        
    }
    func isValidEmail(_ testStr:String) -> Bool
    {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func changeImageCircular(_ imageView:UIImageView)
    {
        imageView.layer.borderWidth = 0.5
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
    }
    
    func setCornerRadiusButton(_ cornerRadius: CGFloat,borderWidth: CGFloat,button:UIButton)
    {
        button.layer.cornerRadius = cornerRadius
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = borderWidth
        button.clipsToBounds = true
    }
}
