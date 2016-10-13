

//
//  AppDelegate.swift
//  Hiton
//
//  Created by yao on 18/03/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit



let kQBApplicationID:UInt = 31327
let kQBAuthKey = "Y6rUTKq8zFCwmbP"
let kQBAuthSecret = "pjN3YTpMZFdP9-B"
let kQBAccountKey = "KwStNU55sN1HYrAA67jq"

let kQBRingThickness: CGFloat = 1.0
let kQBAnswerTimeInterval: NSTimeInterval = 60.0
let kQBRTCDisconnectTimeInterval: NSTimeInterval = 30.0
let kQBDialingTimeInterval: NSTimeInterval = 5.0

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let userInfo = UserClass.sharedInstance
    
    let bluetooth = HitonBluetoothClass.sharedInstance
    
    var API = DataClass.sharedInstance
    
    var socket = HitonSocketClass.sharedInstance


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        UIApplication.sharedApplication().idleTimerDisabled = true
        
        bluetooth.checkingBluetooth()
        userInfo.checkID()
        
        QBSettings.setApplicationID(kQBApplicationID)
        QBSettings.setAuthKey(kQBAuthKey)
        QBSettings.setAuthSecret(kQBAuthSecret)
        QBSettings.setAccountKey(kQBAccountKey)
        
        QBSettings.setLogLevel(QBLogLevel.Nothing)
        QBSettings.setAutoReconnectEnabled(true)
        //QuickbloxWebRTC preferences
        QBRTCConfig.setAnswerTimeInterval(kQBAnswerTimeInterval)
        QBRTCConfig.setDisconnectTimeInterval(kQBRTCDisconnectTimeInterval)
        QBRTCConfig.setDialingTimeInterval(kQBDialingTimeInterval)
        QBRTCConfig.initialize()

        return true
    }

    func applicationWillResignActive(apPlication: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        API.connectionStart_LeaveLobby(userInfo.IDN!) { (isNull, dic) in
            
        }
        if socket.isConnect == true {
            socket.disconectFromServer()
        }
    }


}

