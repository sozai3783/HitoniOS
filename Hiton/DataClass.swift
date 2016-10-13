//
//  DataClass.swift
//  Hiton
//
//  Created by yao on 13/04/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class DataClass: NSObject {
    
    class var sharedInstance: DataClass {
        struct Singleton {
            static var onceToken : dispatch_once_t = 0
            static var staticInstance: DataClass? = nil
        }
        dispatch_once(&Singleton.onceToken) {
            Singleton.staticInstance = DataClass()
        }
        return Singleton.staticInstance!
    }
    
    
    var registerAtGuest: String?
    var connectToLobby: String?
    var leaveLobby: String?
    var lobbyRefresh: String?
    var lobbyCheckStatus: String?
    var lobbyInvitePlayer: String?
    var roomAccept: String?
    var roomDecline: String?

    var getName: String?
    
    var getQBIDN: String?
    
    var login: String?
    var updateProfileURL: String?
    var changePassword: String?
    var Token: String?
    
    var playerDetails: String?
    var playerCheckStatus: String?
    
    ///Handle20160825
    
    override init() {
        //registerAtGuest = "http://hiton.apsystem.solutions/handle/Player_RegisterAsGuest.ashx"
        registerAtGuest = "http://hiton.apsystem.solutions/Handle20160825/Player_RegisterAsGuest20160609.ashx"
        connectToLobby = "http://hiton.apsystem.solutions/Handle20160825/Player_JoinLobby.ashx"
        lobbyRefresh = "http://hiton.apsystem.solutions/handle/Player_RefreshLobby.ashx"
        lobbyCheckStatus = "http://hiton.apsystem.solutions/Handle20160825/Player_CheckStatus2.ashx"
        lobbyInvitePlayer = "http://hiton.apsystem.solutions/Handle20160825/Player_InviteOtherPlayer.ashx"
        roomAccept = "http://hiton.apsystem.solutions/Handle20160825/Player_SayYes2Request.ashx"
        roomDecline = "http://hiton.apsystem.solutions/Handle20160825/Player_SayNo2Request.ashx"
        getQBIDN = "http://hiton.apsystem.solutions/Handle20160825/Get_Player1_QB_ID.ashx"
        getName = "http://hiton.apsystem.solutions/Handle20160825/Get_Player_Name.ashx"
        leaveLobby = "http://hiton.apsystem.solutions/Handle20160825/Player_LeaveLobby.ashx"
        login = "http://hiton.apsystem.solutions/Handle20160825/Player_Login.ashx"
        updateProfileURL = "http://hiton.apsystem.solutions/Handle20160825/Player_UpdateProfile.ashx"
        changePassword = "http://hiton.apsystem.solutions/Handle20160825/Player_ChangePassword.ashx"
        playerDetails = "http://hiton.apsystem.solutions/Handle20160825/Player_Details.ashx"
        playerCheckStatus = "http://hiton.apsystem.solutions/Handle20160825/Player_CheckStatus.ashx"
        super.init()
    }
    
    func getPlayerDetails(IDN: Int, callback: (NSDictionary) -> Void){
        let urlString = "\(playerDetails!)?IDN=\(IDN)"
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            dispatch_async(dispatch_get_main_queue(), {
                do {
                    let dic:NSDictionary!
                    try dic = NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                    callback(dic)
                    
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            })
        }).resume()
    }
    
    func PlayerCheckStatus(IDN: Int, callback: (NSDictionary) -> Void){
        let urlString = "\(playerCheckStatus!)?PlayerIDN=\(IDN)"
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            dispatch_async(dispatch_get_main_queue(), {
                do {
                    let dic:NSDictionary!
                    try dic = NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                    callback(dic)
                    
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            })
        }).resume()
    }
    
    func login(Email: String, Password: String, callback: (NSDictionary) -> Void){
        let urlString = "\(login!)?Email=\(Email)&Password=\(Password)&Token=123"
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            dispatch_async(dispatch_get_main_queue(), {
                do {
                    let dic:NSDictionary!
                    try dic = NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                    callback(dic)
                    
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            })
        }).resume()
    }
    
    func updateProfile(IDN: Int, Name: String, Country: String, Gender: String, callback: (NSDictionary) -> Void){
        let urlString = "\(updateProfileURL!)?IDN=\(IDN)&Name=\(Name)&Country=\(Country)&Gender=\(Gender)"
        print(urlString)
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            dispatch_async(dispatch_get_main_queue(), {
                do {
                    let dic:NSDictionary!
                    try dic = NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                    callback(dic)
                    
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            })
        }).resume()
    }

    
    func connectionStart_GameLobby(IDN: Int, GameMode: Int, callback: (NSDictionary) -> Void){
        let urlString = "\(connectToLobby!)?PlayerIDN=\(IDN)&GameMode=\(GameMode)"
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            dispatch_async(dispatch_get_main_queue(), {
                do {
                    let dic:NSDictionary!
                    try dic = NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                    callback(dic)
                    
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            })
        }).resume()
    }
    
    func connectionStart_LeaveLobby(IDN: Int, callback: (Bool, NSDictionary) -> Void){
        let urlString = "\(leaveLobby!)?PlayerIDN=\(IDN)"
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
        let session = NSURLSession.sharedSession()
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            dispatch_async(dispatch_get_main_queue(), {
                do {
                    let dic:NSDictionary!
                    try dic = NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                    callback(true, dic)
                    
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                    callback(false, NSDictionary())
                }
            })
        }).resume()
    }
    
    func connectionStart_GetName(IDN: Int, IDN2: Int, callback: (NSDictionary) -> Void){
        let urlString = "\(getName!)?Player1IDN=\(IDN)&Player2IDN=\(IDN2)"
        print(urlString)
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            dispatch_async(dispatch_get_main_queue(), {
                do {
                    //print("str = \(NSString(data: data!, encoding: NSUTF8StringEncoding))")
                    let dic:NSDictionary!
                    try dic = NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                    callback(dic)
                    
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                    self.connectionStart_GetName(IDN, IDN2: IDN2, callback: { (dic) in
                        
                    })
                }
            })
        }).resume()
    }

    
    func connectionStart_RefreshLobby(IDN: Int, callback: (Bool, NSDictionary) -> Void){
        let urlString = "\(lobbyRefresh!)?PlayerIDN=\(IDN)"
        print(urlString)
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            dispatch_async(dispatch_get_main_queue(), {
                //callback(data!)
                do {
                    let dic:NSDictionary!
                    try dic = NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                    callback(true, dic)
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                    callback(false, NSDictionary())
                }
            })
        }).resume()
    }
    
    func connectionStart_LobbyCheckStatus(IDN: Int, callback: (NSDictionary) -> Void){
        let urlString = "\(lobbyCheckStatus!)?PlayerIDN=\(IDN)"
        //print(urlString)
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            dispatch_async(dispatch_get_main_queue(), {
                do {
                    let dic:NSDictionary!
                    try dic = NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                    callback(dic)
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            })
        }).resume()   
    }
    
    func connectionStart_InvitePlayer(IDN: Int, IDN2: Int, callback: (NSDictionary) -> Void){
        let urlString = "\(lobbyInvitePlayer!)?PlayerIDN=\(IDN)&OtherPlayerIDN=\(IDN2)"
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            dispatch_async(dispatch_get_main_queue(), {
                do {
                    let dic:NSDictionary!
                    try dic = NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                    callback(dic)
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            })
        }).resume()
    }
    
    func connectionStart_GetP1QBID(IDN: Int, callback: (NSDictionary) -> Void){
        let urlString = "\(getQBIDN!)?GameIDN=\(IDN)"
        print(urlString)
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            dispatch_async(dispatch_get_main_queue(), {
                do {
                    let dic:NSDictionary!
                    try dic = NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                    callback(dic)
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            })
        }).resume()
    }

    func connectionStart_P2Accept(IDN: Int, callback: (NSDictionary) -> Void){
        let urlString = "\(roomAccept!)?PlayerIDN=\(IDN)"
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            dispatch_async(dispatch_get_main_queue(), {
                do {
                    let dic:NSDictionary!
                    try dic = NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                    callback(dic)
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            })
        }).resume()
    }
    
    func connectionStart_P2decline(IDN: Int, callback: (NSDictionary) -> Void){
        let urlString = "\(roomDecline!)?PlayerIDN=\(IDN)"
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            dispatch_async(dispatch_get_main_queue(), {
                do {
                    let dic:NSDictionary!
                    try dic = NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                    callback(dic)
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            })
        }).resume()
    }
    
}
