//
//  HitonSocketClass.swift
//  Hiton
//
//  Created by yao on 18/03/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit


class HitonSocketClass: NSObject, GCDAsyncSocketDelegate {
    
    
    var userInfo = UserClass.sharedInstance
    
    var serverReturn:((str: String) -> Void)?
    
    
    class var sharedInstance: HitonSocketClass {
        struct Singleton {
            static var onceToken : dispatch_once_t = 0
            static var staticInstance: HitonSocketClass? = nil
        }
        dispatch_once(&Singleton.onceToken) {
            Singleton.staticInstance = HitonSocketClass()
        }
        return Singleton.staticInstance!
    }
    
    
    
    var id = 0
    var otherID = 0
    var isConnect = false
    
    var socket = GCDAsyncSocket()
    var connectSuccess: (() -> Void)?
    var connectFail: (() -> Void)?
    var disconnected: (() -> Void)?
    
    var notify: ((str: String) -> Void)?
    
    var GameMode = 0
    
    override init (){
        print(userInfo.IDN)
        super.init()
    }
    
    func setID(){
        
        id = userInfo.IDN!
    }
    
    func startConnectToServer(_gameMode: Int){
        GameMode = _gameMode
        socket = GCDAsyncSocket(delegate: self, delegateQueue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
        do {
            try socket.connectToHost("103.21.182.169", onPort: 8885)
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    /*func startConnectToServer(_otherPlayerIDN: Int){
        otherID = _otherPlayerIDN
        socket = GCDAsyncSocket(delegate: self, delegateQueue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
        do {
            try socket.connectToHost("103.21.182.169", onPort: 8885)
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }*/
    
    
    
    func InvitePlayer(_P2ID: Int){
        let tempString = "\(id)|\(_P2ID)|INVITE"
        print("Invite Player = \(tempString)")
        let data = tempString.dataUsingEncoding(NSUTF8StringEncoding)
        socket.writeData(data, withTimeout: -1, tag: 0)
        socket.readDataWithTimeout(-1, tag: 1)
    }
    
    func Accept(){
        let tempString = "\(id)|YES"
        let data = tempString.dataUsingEncoding(NSUTF8StringEncoding)
        socket.writeData(data, withTimeout: -1, tag: 0)
        socket.readDataWithTimeout(-1, tag: 1)
    }
    
    func Decline(){
        let tempString = "\(id)|NO"
        let data = tempString.dataUsingEncoding(NSUTF8StringEncoding)
        socket.writeData(data, withTimeout: -1, tag: 0)
        socket.readDataWithTimeout(-1, tag: 1)
    }
    
    func LeaveLobby(){
        /*et tempString = "\(id)|LEAVE"
        let data = tempString.dataUsingEncoding(NSUTF8StringEncoding)
        socket.writeData(data, withTimeout: -1, tag: 0)
        socket.readDataWithTimeout(-1, tag: 1)*/
        self.GameEnd()
    }
    
    func GameEnd(){
        socket.disconnect()
    }
    
    func disconectFromServer(){
        let s = "\(id)|LEAVE"
        let data = s.dataUsingEncoding(NSUTF8StringEncoding)
        socket.writeData(data, withTimeout: -1, tag: 0)
        socket.disconnect()
    }

    func sendData(otherPlayerID: Int, str: String){
        let s = "\(id)|\(otherPlayerID)|\(str)"
        let data = s.dataUsingEncoding(NSUTF8StringEncoding)
        socket.writeData(data, withTimeout: -1, tag: 0)

    }
    
    func socket(sock: GCDAsyncSocket!, didConnectToHost host: String!, port: UInt16) {
        print("connect success")
        isConnect = true
        let s = "\(id)|\(GameMode)|JOIN"
        let data = s.dataUsingEncoding(NSUTF8StringEncoding)
        socket.writeData(data, withTimeout: -1, tag: 0)
        sock.readDataWithTimeout(-1, tag: 1)
        if let callback = self.connectSuccess{
            callback()
        }
    }
    
    
    func socket(sock: GCDAsyncSocket!, didReadData data: NSData!, withTag tag: Int) {
        print(String(data: data, encoding: NSUTF8StringEncoding)!)
        if let callback = self.notify{
            callback(str: String(data: data, encoding: NSUTF8StringEncoding)!.stringByReplacingOccurrencesOfString("Server Say : ", withString: ""))
        }
        sock.readDataWithTimeout(-1, tag: 1)
    }
    
    
    func socket(sock: GCDAsyncSocket!, didReadPartialDataOfLength partialLength: UInt, tag: Int) {
        print("didReadPartialDataOfLength")
    }
    
    func socketDidDisconnect(sock: GCDAsyncSocket!, withError err: NSError!) {
        print("disconnected")
        if let callback = self.disconnected{
            callback()
        }
        isConnect = false
    }

}
