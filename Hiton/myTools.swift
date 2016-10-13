
//
//  myTools.swift
//  eCarPooler-Swift
//
//  Created by yao on 17/12/2015.
//  Copyright © 2015 apsystem. All rights reserved.
//

import UIKit

class myTools: NSObject {
    
    /*func connectToURL(stringURL: String, view: AnyObject?) -> NSURLConnection{
        let charSet = NSCharacterSet.URLPathAllowedCharacterSet()
        let str = stringURL.stringByAddingPercentEncodingWithAllowedCharacters(charSet)!
        let url = NSURL(string: str)
        let theRequest = NSMutableURLRequest(URL: url!)
        let connection = NSURLConnection(request: theRequest, delegate: view, startImmediately: true)
        connection?.start()
        return connection!
    }*/
    
    class func ConnectionStart(urlString: String, requestController view: AnyObject) -> NSURLConnection {
        let charSet = NSCharacterSet.URLPathAllowedCharacterSet()
        let str = urlString.stringByAddingPercentEncodingWithAllowedCharacters(charSet)!
        let url: NSURL = NSURL(string: str)!
        let theRequest: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        let theConnection: NSURLConnection = NSURLConnection(request: theRequest, delegate: view, startImmediately: true)!
        theConnection.start()
        return theConnection
    }
    
    
    class func isNotNull(txt: UITextField) -> Bool {
        return !(txt.text?.isEmpty)!
    }
    
    class func isValidateEmail(email: String) -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluateWithObject(email)
    }
    
    
}
