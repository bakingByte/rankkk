//
//  WebServices.swift
//  MyTrip
//
//  Created by Santosh Maurya on 03/05/17.
//  Copyright © 2017 Santosh Maurya. All rights reserved.
//

import Foundation
import SystemConfiguration

class WebServices: NSObject,URLSessionDelegate {
    
    var requestDic : NSMutableDictionary = [:]
    
    func getServerDataWith(dict_Parameters: NSDictionary, withPostType postType:String, completionHandler: @escaping (NSDictionary?, AnyObject?, NSError?) -> ()) -> (){
        
        // Check network/internet available
        let status = isInternetAvailable()
        print(status)
        if !(status) {
            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
//            AppDelegate.hidePrgressHUD()
//            appDelegate.custumIndicatorHide()
            
            let responseCode :AnyObject    =  0 as AnyObject
            
            completionHandler([:] , responseCode , nil)
            
            return
            
        }
        
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
                let status = isInternetAvailable()
                print(status)
                if !(status) {
                    let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
        //            AppDelegate.hidePrgressHUD()
        //            appDelegate.custumIndicatorHide()
        
                    let responseCode :AnyObject    =  0 as AnyObject
        
                    completionHandler([:] , responseCode , nil)
        
                    return
        
                }
        
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
    
    // MARK : image uploading
    
    func postToServerWithData(dict_Parameters: NSDictionary, withPostType postType:String, andImages imageArray:NSMutableArray , completionHandler: @escaping (NSDictionary?, AnyObject?, NSError?) -> ()) -> () {
        
        
        
        // AppDelegate.showPrgressHUD()
        
        // Check network/internet available
        let status = isInternetAvailable()
        print(status)
        if !(status) {
            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
//            appDelegate.custumIndicatorHide()
//            AppDelegate.hidePrgressHUD()
            
            let responseCode :AnyObject    =  0 as AnyObject
            
            completionHandler([:] , responseCode , nil)
            
            return
            
        }
        
        let appendString = kSERVER_URL + postType
        let requestURL = NSURL(string:appendString)
        requestDic.addEntries(from: dict_Parameters as! [AnyHashable : Any])
//        requestDic .addEntries(from: ["version" : appDelegate.version  ])
        
        // Create Session
        let defaultSessionConfig  = URLSessionConfiguration.default
        let defaultSession        = URLSession(configuration: defaultSessionConfig, delegate
            : self, delegateQueue: OperationQueue.main)
        
        // Create Request and set Parameters
        let request               = NSMutableURLRequest(url: requestURL! as URL, cachePolicy
            : NSURLRequest.CachePolicy.reloadIgnoringCacheData,timeoutInterval: 60)
        let theJSONData = try! JSONSerialization.data(
            withJSONObject: requestDic,
            options: JSONSerialization.WritingOptions(rawValue: 0))
        let theJSONText = NSString(data: theJSONData,
                                   encoding: String.Encoding.utf8.rawValue)
        print("JSON string = \(theJSONText!)")
        
        request.httpMethod        = "POST"
//        request.setValue(authorization, forHTTPHeaderField: "authorization")
//        request.setValue(appDelegate.device_info, forHTTPHeaderField: "device_info")
        
        //  request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //////////////////////////////////////////////////////////////////
        
        let boundary = "---------------------------acebdf13572468"
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        // request.setValue(authorization, forHTTPHeaderField: "authorization")
        
        let body = NSMutableData();
        
        // data
        body.append(NSString(format: "\r\n").data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format: "--%@\r\n",boundary).data(using: String.Encoding.utf8.rawValue)!)
        
        body.append(NSString(format: "Content-Disposition: form-data; name=\"data\"\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format: "%@",theJSONText!).data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format: "\r\n").data(using: String.Encoding.utf8.rawValue)!)
        
        
        
        // code to compress image
        let newSize: CGSize = CGSize(width: 500, height: 500)
        UIGraphicsBeginImageContext(newSize)
        
        let itemCounts = imageArray.count
        
        for i in 0..<itemCounts
        {
            let image : UIImage = imageArray.object(at: i) as! UIImage
            UIGraphicsBeginImageContext(newSize)
            // image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
            image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
            let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            UIGraphicsPopContext()
            
            let imageData = UIImageJPEGRepresentation(newImage, 1)
            
            if(imageData==nil)  { return; }
            let date = NSDate().timeIntervalSince1970
            // for Image
            let filename = "default_hair\(date).jpg";
            let mimetype = "image/jpeg";
            // let imagePathKey = "profile_img" // image
            let imagePathKey = dict_Parameters["imagePathKey"] as? String ?? "image"
            
            body.append(NSString(format: "--%@\r\n",boundary).data(using: String.Encoding.utf8.rawValue)!)
            
            body.append(NSString(format: "Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",imagePathKey,filename).data(using: String.Encoding.utf8.rawValue)!)
            body.append(NSString(format: "Content-Type: %@\r\n\r\n",mimetype).data(using: String.Encoding.utf8.rawValue)!)
            
            body.append(imageData!)
            body.append(NSString(format: "\r\n").data(using: String.Encoding.utf8.rawValue)!)
            //body.append(NSString(format: "\r\n--%@--\r\n",boundary).data(using: String.Encoding.utf8.rawValue)!)
            
            //  request.httpBody = body as Data
        }
        
        //         body.append(NSString(format: "<@INCLUDE %@*@>",image_path).data(using: String.Encoding.utf8.rawValue)!)
        //         body.append(NSString(format: "\r\n").data(using: String.Encoding.utf8.rawValue)!)
        //        body.append(NSString(format: "--%@--\r\n",boundary).data(using: String.Encoding.utf8.rawValue)!)
        //
        body.append(NSString(format: "\r\n--%@--\r\n",boundary).data(using: String.Encoding.utf8.rawValue)!)
        
        if itemCounts == 0{
            body.append(NSString(format: "\r\n").data(using: String.Encoding.utf8.rawValue)!)
            body.append(NSString(format: "\r\n--%@--\r\n",boundary).data(using: String.Encoding.utf8.rawValue)!)        }
        
        request.httpBody = body as Data
        
        /////////////////////////////////////////////////////////////////////////////
        
        
        
        // Create DataTask
        let dataTask              = defaultSession.dataTask(with: request as URLRequest, completionHandler: {
            (data: Data?, response: URLResponse?, error: Error?) in
            if let responseError = error
            {
                // Handle parsing error
                //                stopProgressIndicator()
//                AppDelegate.hidePrgressHUD()
//                appDelegate.custumIndicatorHide()
                let responseCode :AnyObject    =  0 as AnyObject
                
                completionHandler([:], responseCode , nil)
                
                print("Response error: \(responseError)")
            }
            else
            {
                do {
                    // Handle Successful Response
                    
                    if let str = String(data: data!, encoding: String.Encoding.utf8) {
                        print(str)
                        //                        AppDelegate.hidePrgressHUD()
                        
                    }
                    
                    let dictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    
                    print(dictionary)
                    
                    // print(dictionary) //**** This is Giving the total response in the code
                    
                    
                    
                    let responseCode :AnyObject    = dictionary["code"]! as AnyObject
                    
                    
                    if (responseCode.intValue  == 200){
                        // let userInfo: AnyObject       = dictionary["result"]!
                        
                        print(dictionary)
                        let userInfo: NSDictionary       = dictionary
                        
                        print(userInfo)
                        
                        completionHandler(userInfo, responseCode , nil)
                    }
//                    else if(responseCode.intValue == 203 ){
//                        completionHandler(dictionary , responseCode , nil)
//                        self.goToLoginPage()
//                        
//                    }else if(responseCode.intValue == 500 ){
//                        completionHandler(dictionary , responseCode , nil)
//                        self.goToLoginPage()
//                        let message = dictionary["result"] as? String ?? ""
//                        self.updateVersionPopup(message: message)
//                        
//                        
//                    }
//                    else if(responseCode.intValue  == 100){
//                        // let userInfo: AnyObject       = dictionary["result"]!
//                        
//                        print(dictionary)
//                        let userInfo: NSDictionary       = dictionary
//                        
//                        print(userInfo)
//                        
//                        completionHandler(userInfo, responseCode , nil)
//                    }
                    
                    
                }
                catch let jsonError as NSError
                {
                    
                    // Handle parsing error
                    print("JSON error: \(jsonError.localizedDescription)")
                    AppDelegate.hidePrgressHUD()
//                    appDelegate.custumIndicatorHide()
                }
            }
        })
        dataTask.resume()
        
    }
    
//    // MARK : image uploading
//    
//    func postToServerWithData1(dict_Parameters: NSDictionary, withPostType postType:String, andImages imageArray:NSMutableArray , completionHandler: @escaping (NSDictionary?, AnyObject?, NSError?) -> ()) -> () {
//        // Check network/internet available
//        let status = isInternetAvailable()
//        print(status)
//        if !(status) {
//            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
//            alert.show()
//            AppDelegate.hidePrgressHUD()
////            appDelegate.custumIndicatorHide()
//            
//            let responseCode :AnyObject    =  0 as AnyObject
//            
//            completionHandler([:] , responseCode , nil)
//            
//            return
//            
//        }
//        
//        // AppDelegate.showPrgressHUD()
//        let appendString = kSERVER_URL + postType
//        let requestURL = NSURL(string:appendString)
//        requestDic.addEntries(from: dict_Parameters as! [AnyHashable : Any])
////        requestDic .addEntries(from: ["version" : appDelegate.version  ])
//        // Create Session
//        let defaultSessionConfig  = URLSessionConfiguration.default
//        let defaultSession        = URLSession(configuration: defaultSessionConfig, delegate
//            : self, delegateQueue: OperationQueue.main)
//        
//        // Create Request and set Parameters
//        let request               = NSMutableURLRequest(url: requestURL! as URL, cachePolicy
//            : NSURLRequest.CachePolicy.reloadIgnoringCacheData,timeoutInterval: 60)
//        let theJSONData = try! JSONSerialization.data(
//            withJSONObject: requestDic,
//            options: JSONSerialization.WritingOptions(rawValue: 0))
//        let theJSONText = NSString(data: theJSONData,
//                                   encoding: String.Encoding.utf8.rawValue)
//        print("JSON string = \(theJSONText!)")
//        
//        request.httpMethod        = "POST"
//        
//        
//        //  request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        //////////////////////////////////////////////////////////////////
//        
//        let boundary = "---------------------------acebdf13572468"
////        request.setValue(authorization, forHTTPHeaderField: "authorization")
////        request.setValue(appDelegate.device_info, forHTTPHeaderField: "device_info")
//        
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        let body = NSMutableData();
//        
//        // data
//        body.append(NSString(format: "\r\n").data(using: String.Encoding.utf8.rawValue)!)
//        body.append(NSString(format: "--%@\r\n",boundary).data(using: String.Encoding.utf8.rawValue)!)
//        
//        body.append(NSString(format: "Content-Disposition: form-data; name=\"data\"\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
//        body.append(NSString(format: "%@",theJSONText!).data(using: String.Encoding.utf8.rawValue)!)
//        body.append(NSString(format: "\r\n").data(using: String.Encoding.utf8.rawValue)!)
//        
//        
//        
//        // code to compress image
//        let newSize: CGSize = CGSize(width: 500, height: 500)
//        UIGraphicsBeginImageContext(newSize)
//        
//        let itemCounts = imageArray.count
//        
//        for i in 0..<itemCounts
//        {
//            let image : UIImage = imageArray.object(at: i) as! UIImage
//            UIGraphicsBeginImageContext(newSize)
//            // image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
//            image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
//            let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//            UIGraphicsEndImageContext()
//            UIGraphicsPopContext()
//            
//            let imageData = UIImageJPEGRepresentation(newImage, 1)
//            
//            if(imageData==nil)  { return; }
//            let date = NSDate().timeIntervalSince1970
//            // for Image
//            let filename = "default_hair\(date).jpg";
//            let mimetype = "image/jpeg";
//            // let imagePathKey = "profile_img" // image
//            let imagePathKey = dict_Parameters["imagePathKey"] as? String ?? "image"
//            
//            body.append(NSString(format: "--%@\r\n",boundary).data(using: String.Encoding.utf8.rawValue)!)
//            
//            body.append(NSString(format: "Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",imagePathKey,filename).data(using: String.Encoding.utf8.rawValue)!)
//            body.append(NSString(format: "Content-Type: %@\r\n\r\n",mimetype).data(using: String.Encoding.utf8.rawValue)!)
//            
//            body.append(imageData!)
//            body.append(NSString(format: "\r\n").data(using: String.Encoding.utf8.rawValue)!)
//            //body.append(NSString(format: "\r\n--%@--\r\n",boundary).data(using: String.Encoding.utf8.rawValue)!)
//            
//            //  request.httpBody = body as Data
//        }
//        
//        //         body.append(NSString(format: "<@INCLUDE %@*@>",image_path).data(using: String.Encoding.utf8.rawValue)!)
//        //         body.append(NSString(format: "\r\n").data(using: String.Encoding.utf8.rawValue)!)
//        //        body.append(NSString(format: "--%@--\r\n",boundary).data(using: String.Encoding.utf8.rawValue)!)
//        //
//        body.append(NSString(format: "\r\n--%@--\r\n",boundary).data(using: String.Encoding.utf8.rawValue)!)
//        
//        if itemCounts == 0{
//            body.append(NSString(format: "\r\n").data(using: String.Encoding.utf8.rawValue)!)
//            body.append(NSString(format: "\r\n--%@--\r\n",boundary).data(using: String.Encoding.utf8.rawValue)!)        }
//        
//        request.httpBody = body as Data
//        
//        /////////////////////////////////////////////////////////////////////////////
//        
//        
//        
//        // Create DataTask
//        let dataTask              = defaultSession.dataTask(with: request as URLRequest, completionHandler: {
//            (data: Data?, response: URLResponse?, error: Error?) in
//            if let responseError = error
//            {
//                print(responseError)
//                // Handle parsing error
//                //                stopProgressIndicator()
//                completionHandler([:], 10 as AnyObject? , nil)
//                
//                AppDelegate.hidePrgressHUD()
////                appDelegate.custumIndicatorHide()
//                
//                print("Response error: \(responseError)")
//            }
//            else
//            {
//                do {
//                    // Handle Successful Response
//                    
//                    if let str = String(data: data!, encoding: String.Encoding.utf8) {
//                        print(str)
//                        //                        AppDelegate.hidePrgressHUD()
//                        
//                    }
//                    
//                    let dictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
//                    
//                    print(dictionary)
//                    
//                    // print(dictionary) //**** This is Giving the total response in the code
//                    
//                    
//                    
//                    let responseCode :AnyObject    = dictionary["code"]! as AnyObject
//                    
//                    
//                    if (responseCode.intValue  == 200){
//                        // let userInfo: AnyObject       = dictionary["result"]!
//                        
//                        print(dictionary)
//                        let userInfo: NSDictionary       = dictionary
//                        
//                        print(userInfo)
//                        
//                        completionHandler(userInfo, responseCode , nil)
//                    } else if(responseCode.intValue == 203 ){
//                        
////                        self.goToLoginPage()
//                        
//                    }else if(responseCode.intValue == 500 ){
//                        completionHandler(dictionary , responseCode , nil)
////                        self.goToLoginPage()
//                        let message = dictionary["result"] as? String ?? ""
////                        self.updateVersionPopup(message: message)
//                        
//                    }
//                    else if (responseCode.intValue  == 100){
//                        // let userInfo: AnyObject       = dictionary["result"]!
//                        
//                        print(dictionary)
//                        let userInfo: NSDictionary       = dictionary
//                        
//                        print(userInfo)
//                        
//                        completionHandler(userInfo, responseCode , nil)
//                    }
//                }
//                catch let jsonError as NSError
//                {
//                    
//                    // Handle parsing error
//                    print("JSON error: \(jsonError.localizedDescription)")
//                    AppDelegate.hidePrgressHUD()
////                    appDelegate.custumIndicatorHide()
//                }
//            }
//        })
//        dataTask.resume()
//    }
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }


}
