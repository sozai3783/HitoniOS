//
//  UserClass.swift
//  Hiton
//
//  Created by yao on 13/04/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class UserClass: NSObject {
    
    class var sharedInstance: UserClass {
        struct Singleton {
            static var onceToken : dispatch_once_t = 0
            static var staticInstance: UserClass? = nil
        }
        dispatch_once(&Singleton.onceToken) {
            Singleton.staticInstance = UserClass()
        }
        return Singleton.staticInstance!
    }
    
    var API = DataClass()
    private var userInfo = NSUserDefaults.standardUserDefaults()
    var networkTimer: NSTimer?
    
    var Identity: String?
    
    var IDN: Int?
    var QBAccount: Int?
    var Rank: Int?
    
    var Avatar: UIImage?
    
    var Email: String?
    var Name: String?
    var Gender: String?
    var Country: String?
    var PPD: Double!
    var MPR: Double!
    
    override init() {
        super.init()
        //checkID()
        //userInfo.setObject("Guest", forKey: "Identity")
    }
    
    func Save(){
        userInfo.setObject(Name, forKey: "Name")
        userInfo.setObject(Email, forKey: "Email")
        userInfo.setObject(QBAccount, forKey: "QBAccount")
        userInfo.setObject(Gender, forKey: "Gender")
        userInfo.setObject(Country, forKey: "Country")
        userInfo.setObject(PPD, forKey: "PPD")
        userInfo.setObject(MPR, forKey: "MPR")
        userInfo.setObject(Rank, forKey: "Rank")
        userInfo.setObject(Identity, forKey: "Identity")
        userInfo.synchronize()
    }

    func checkID(){
        let tempIDN = userInfo.objectForKey("IDN")
        //userInfo.setObject("Guest", forKey: "Identity")
        //userInfo.synchronize()
        if tempIDN == nil {
            let dataFormat = NSDateFormatter()
            dataFormat.dateFormat = "yyMMddHHmmss"
            let nowDate = dataFormat.stringFromDate(NSDate())
            
            userInfo.setObject(0, forKey: "IDN")
            userInfo.setObject(nowDate, forKey: "Name")
            //userInfo.setObject("", forKey: "Password")
            userInfo.setObject("", forKey: "QBAccount")
            userInfo.setObject("", forKey: "Email")
            userInfo.setObject("", forKey: "Gender")
            userInfo.setObject("", forKey: "Country")
            userInfo.setObject(0.00, forKey: "PPD")
            userInfo.setObject(0.00, forKey: "MPR")
            userInfo.setObject("Guest", forKey: "Identity")
            
            
            userInfo.synchronize()
            checkNetWork()
        }else{
            if let str = userInfo.objectForKey("IDN"){
                if str as! NSObject == 0{
                    checkNetWork()
                }else{
                    //register ed
                    IDN = (userInfo.objectForKey("IDN")?.integerValue)!
                    Identity = userInfo.objectForKey("Identity") as? String
                    Name = userInfo.objectForKey("Name") as? String
                    Country = userInfo.objectForKey("Country") as? String
                    Gender = userInfo.objectForKey("Gender") as? String
                    PPD = userInfo.objectForKey("PPD")?.doubleValue
                    MPR = userInfo.objectForKey("MPR")?.doubleValue
                    print(IDN!)
                    print(Name!)
                    print(Identity!)
                }
            }
        }
    }
    
    func checkNetWork(){
        print("check network")
        let tempChecking = Reachability.reachabilityForInternetConnection()
        tempChecking.startNotifier()
        let status = tempChecking.currentReachabilityStatus()
        print(status)
        switch status {
        case .NotReachable:
            networkTimer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(UserClass.checkNetWork), userInfo: nil, repeats: false)
            break
        case .ReachableViaWiFi:
            networkTimer?.invalidate()
            registerAsGuest()
            break
        case .ReachableViaWWAN:
            networkTimer?.invalidate()
            registerAsGuest()
            break
        }
        
    }

    func registerAsGuest(){
        let urlString = "\(API.registerAtGuest!)?Name=\(userInfo.objectForKey("Name")!)"
        print(urlString)
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            dispatch_async(dispatch_get_main_queue(), {
                do {
                    let dic:NSDictionary!
                    try dic = NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                    self.analyticalData(dic)
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            })
        }).resume()
    }
    
    func analyticalData(dic: NSDictionary){
        let tempCode = dic.valueForKey("ResponeCode")!.integerValue
        if tempCode == 252 {
            let tempData = dic.valueForKey("Detail")
            let tempArray = tempData as! NSMutableArray
            let tempIDN = tempArray.objectAtIndex(0).valueForKey("IDN")?.integerValue
            let tempName = tempArray.objectAtIndex(0).valueForKey("Name") as? String
            let tempCountry = tempArray.objectAtIndex(0).valueForKey("Country") as? String
            let tempGender = tempArray.objectAtIndex(0).valueForKey("Gender") as? String
            userInfo.setObject(tempIDN, forKey: "IDN")
            userInfo.setObject("Guest", forKey: "Identity")
            userInfo.synchronize()
            IDN = tempIDN
            Name = tempName
            Country = tempCountry
            Gender = tempGender
            PPD = userInfo.objectForKey("PPD")?.doubleValue
            MPR = userInfo.objectForKey("MPR")?.doubleValue
            print(IDN)
            Identity = "Guest"

        }
    }
    
}
