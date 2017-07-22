//
//  WebServices.swift
//  MyTrip
//
//  Created by Santosh Maurya on 03/05/17.
//  Copyright © 2017 Santosh Maurya. All rights reserved.
//

import Foundation

class WebServices: NSObject,URLSessionDelegate {
    
    func getServerDataWith(dict_Parameters: NSDictionary, withPostType postType:String, completionHandler: @escaping (NSDictionary?, AnyObject?, NSError?) -> ()) -> (){
        
        // Check network/internet available
//        let status = isInternetAvailable()
//        print(status)
//        if !(status) {
//            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
//            alert.show()
////            AppDelegate.hidePrgressHUD()
////            appDelegate.custumIndicatorHide()
//            
//            let responseCode :AnyObject    =  0 as AnyObject
//            
//            completionHandler([:] , responseCode , nil)
//            
//            return
//            
//        }
        
        let appendString = kSERVER_URL+postType
        let requestURL = NSURL(string:appendString)
        
        // Create Session
        let defaultSessionConfig  = URLSessionConfiguration.default
        let defaultSession        = URLSession(configuration: defaultSessionConfig, delegate
            : self, delegateQueue: OperationQueue.main)
        
        // Create Request and set Parameters
        let request               = NSMutableURLRequest(url: requestURL! as URL, cachePolicy
            : NSURLRequest.CachePolicy.reloadIgnoringCacheData,timeoutInterval: 60)
        let theJSONData = try! JSONSerialization.data(
            withJSONObject: dict_Parameters,
            options: JSONSerialization.WritingOptions(rawValue: 0))
        let theJSONText = NSString(data: theJSONData,
                                   encoding: String.Encoding.ascii.rawValue)
        print("JSON string = \(theJSONText!)")
        
        request.httpMethod        = "POST"
        request.httpBody          = try! JSONSerialization.data(withJSONObject: dict_Parameters, options: [])
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create DataTask
        let dataTask              = defaultSession.dataTask(with: request as URLRequest, completionHandler: {
            (data: Data?, response: URLResponse?, error: Error?) in
            if let responseError = error
            {
                // Handle parsing error
                print("Response error: \(responseError)")
//                ShowNotificationView().showNotificationAlert(error!.localizedDescription)
//                AppDelegate.hidePrgressHUD()
//                appDelegate.custumIndicatorHide()
            }
            else
            {
                do {
                    // Handle Successful Response
                    if let str = String(data: data!, encoding: String.Encoding.utf8) {
                        print(str)
                    }
                    let dictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    //                    print(dictionary)
                    if let dictionary: NSDictionary = (dictionary as AnyObject) as? NSDictionary{
                        let responseCode :AnyObject    = dictionary["code"] as? NSNumber ?? 0
                        
                        completionHandler(dictionary , responseCode , nil)
                    }
                }
                catch let jsonError as NSError
                {
                    // Handle parsing error
                    print("JSON error: \(jsonError.localizedDescription)")
                    //   showNotifificationAlert("Server Side Error", bgColor: UIColor .redColor(), textColor: UIColor.whiteColor())
                }
            }
        })
        dataTask.resume()
        
    }
    
    func getTypeService(withPostType postType:String, completionHandler: @escaping (NSDictionary?, AnyObject?, NSError?) -> ()) -> (){
        
        // Check network/internet available
        //        let status = isInternetAvailable()
        //        print(status)
        //        if !(status) {
        //            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
        //            alert.show()
        ////            AppDelegate.hidePrgressHUD()
        ////            appDelegate.custumIndicatorHide()
        //
        //            let responseCode :AnyObject    =  0 as AnyObject
        //
        //            completionHandler([:] , responseCode , nil)
        //
        //            return
        //
        //        }
        
        let appendString = kSERVER_URL+postType
        let requestURL = NSURL(string:appendString)
        
        // Create Session
        let defaultSessionConfig  = URLSessionConfiguration.default
        let defaultSession        = URLSession(configuration: defaultSessionConfig, delegate
            : self, delegateQueue: OperationQueue.main)
        
        // Create Request and set Parameters
        let request               = NSMutableURLRequest(url: requestURL! as URL, cachePolicy
            : NSURLRequest.CachePolicy.reloadIgnoringCacheData,timeoutInterval: 60)

        
        request.httpMethod        = "GET"

        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create DataTask
        let dataTask              = defaultSession.dataTask(with: request as URLRequest, completionHandler: {
            (data: Data?, response: URLResponse?, error: Error?) in
            if let responseError = error
            {
                // Handle parsing error
                print("Response error: \(responseError)")
                //                ShowNotificationView().showNotificationAlert(error!.localizedDescription)
                //                AppDelegate.hidePrgressHUD()
                //                appDelegate.custumIndicatorHide()
            }
            else
            {
                do {
                    // Handle Successful Response
                    if let str = String(data: data!, encoding: String.Encoding.utf8) {
                        print(str)
                    }
                    let dictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    //                    print(dictionary)
                    if let dictionary: NSDictionary = (dictionary as AnyObject) as? NSDictionary{
                        let responseCode :AnyObject    = dictionary["code"] as? NSNumber ?? 0
                        
                        completionHandler(dictionary , responseCode , nil)
                    }
                }
                catch let jsonError as NSError
                {
                    // Handle parsing error
                    print("JSON error: \(jsonError.localizedDescription)")
                    //   showNotifificationAlert("Server Side Error", bgColor: UIColor .redColor(), textColor: UIColor.whiteColor())
                }
            }
        })
        dataTask.resume()
        
    }

}
