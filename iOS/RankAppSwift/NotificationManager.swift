//
//  NotificationManager.swift
//  HARE
//
//  Created by Shineweb-solutions on 15/07/16.
//  Copyright © 2016 SWS. All rights reserved.
//

import UIKit

class NotificationManager: NSObject
{
    fileprivate static let _sharedInstance = NotificationManager()
    
    class func sharedInstance() -> NotificationManager
    {
        return _sharedInstance
    }
    
    func registerForNotification()
    {
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
        let pushNotificationSettings = UIUserNotificationSettings(types: notificationTypes, categories: nil)
        UIApplication.shared.registerUserNotificationSettings(pushNotificationSettings)
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func handleNotificationActionWithIdentifier(_ identifier: String, forRemoteNotification userInfo: [AnyHashable: Any], completionHandler: () -> Void)
    {
        
    }
    
    func didReceiveRemoteNotification(_ userInfo: [AnyHashable: Any], completionHandler: () -> Void)
    {
        self.showAlertForViewDetail(userInfo)
        
    }
    func didFailToRegisterForRemoteNotificationsWithError(_ error: NSError)
    {
     //  self.showErrorAlert(error)
        
    }
   
    
    //MARK:- *****Show Notification Alert Method ******
    func showAlertForViewDetail(_ userInfo: [AnyHashable: Any])
    {
        let parentViewController: UIViewController = UIApplication.shared.windows[1].rootViewController!
        
        let alert = UIAlertController(title: "Notifications", message: "message", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: {(action: UIAlertAction!) in
             /// action on button, write something
            }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive, handler: {(action: UIAlertAction!) in
            
           /// action on button , write something
            
        }))
        parentViewController.present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert(_ error: NSError)
    {
        let parentViewController: UIViewController = UIApplication.shared.windows[1].rootViewController!
        
        let alert = UIAlertController(title: "Notifications", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: {(action: UIAlertAction!) in
            /// action on button, write something
        }))
                parentViewController.present(alert, animated: true, completion: nil)
    }
    
}
    

