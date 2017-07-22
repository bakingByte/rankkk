//
//  AppDelegate.swift
//  RankAppSwift
//
//  Created by Mohammad Shiblee on 15/06/17.
//  Copyright © 2017 MegaInfomatic. All rights reserved.
//

import UIKit
import MBProgressHUD
import IQKeyboardManagerSwift
import SystemConfiguration
import MagicalRecord
import Fabric
import MapKit
import CoreLocation
import UserNotifications
import Foundation

let appDelegate  = UIApplication.shared.delegate! as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Override point for customization after application launch.
        application.statusBarStyle = UIStatusBarStyle.lightContent
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        IQKeyboardManager.sharedManager().shouldShowTextFieldPlaceholder = false
        IQKeyboardManager.sharedManager().shouldHidePreviousNext = false
        
        
        // get device id
        
//        deviceId = UIDevice.current.identifierForVendor!.uuidString
        
        // facebook configration
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url as URL!, sourceApplication: sourceApplication, annotation: annotation)
        
        //        let returnValue = UserDefaults.standard.string(forKey: "google")
        //        if (returnValue == "F") {
        //
        //            return FBSDKApplicationDelegate.sharedInstance().application(application, open: url as URL!, sourceApplication: sourceApplication, annotation: annotation)
        //        }
        //        else if (returnValue == "G"){
        //
        //            return GIDSignIn.sharedInstance().handle(url,
        //                                                     sourceApplication: sourceApplication,
        //                                                     annotation: annotation)
        //        }else{
        //
        //            return GIDSignIn.sharedInstance().handle(url,
        //                                                     sourceApplication: sourceApplication,
        //                                                     annotation: annotation)
        //        }
        
    }
    
    
    
    func applicationDidBecomeActive(application: UIApplication) {
        //App activation code
        FBSDKAppEvents.activateApp()
    }
    
    // MARK:- **Progress HUD Method **
    class func showPrgressHUD() -> MBProgressHUD
    {
        let window:UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let hud = MBProgressHUD.showAdded(to: window, animated: true)
        //hud.labelText = title
        // hud.labelFont = UIFont(name: FONT_NAME, size: 15.0)
        return hud!
    }
    class func showPrgressHUD1(button : UIButton) -> MBProgressHUD
    {
        let window:UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let hud = MBProgressHUD.showAdded(to: window, animated: true)
        
        
        hud?.xOffset =      Float(button.frame.origin.x)
        hud?.yOffset =      Float(button.frame.origin.y)
        
        //hud.labelText = title
        // hud.labelFont = UIFont(name: FONT_NAME, size: 15.0)
        return hud!
    }
    
    class func hidePrgressHUD() -> Void
    {
        let window:UIWindow = ((UIApplication.shared.delegate?.window)!)!
        MBProgressHUD.hideAllHUDs(for: window, animated: true)
    }
    // MARK: - Show/Hide HUD
    
    class func showGlobalProgressHUDWithTitle() -> MBProgressHUD {
        
        let window:UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let hud = MBProgressHUD.showAdded(to: window, animated: true)
        return hud!
    }
    
    class func dismissGlobalHUD() -> Void {
        
        let window:UIWindow = ((UIApplication.shared.delegate?.window)!)!
        MBProgressHUD.hideAllHUDs(for: window, animated: true)
    }


}

