

//
//  GameLobbyViewController.swift
//  Hiton
//
//  Created by yao on 04/05/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class GameLobbyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var API = DataClass.sharedInstance
    var userInfo = UserClass.sharedInstance
    
    @IBOutlet var ImageView_Title: UIImageView!
   // var userInfo = NSUserDefaults.standardUserDefaults()
    @IBOutlet var GameList: UITableView!
    var dataArray = NSMutableArray()
    
    var GameMode = 0
    var selectPlayer = -1
    
    var refreshTimer: NSTimer!
    var checkStatusTimer: NSTimer!
    
    var otherPlayerIDN: Int!
    @IBOutlet var Button_Challenge: UIButton!
    
    var PopInvitePlayer: Pop_InvitePlayer!
    var PopPlayerPlaying: Pop_PlayerPlaying!
    
    //var autoRefreshTimer: NSTimer!
    
    var socket = HitonSocketClass.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if GameMode == 0 {
            ImageView_Title.image = UIImage(named: "Lobby_Title")
        }else{
            ImageView_Title.image = UIImage(named: "Lobby_Title_1")
        }
        
        print(GameMode)
        socket.setID()
        socket.startConnectToServer(GameMode)
        socket.notify = {
           (_str) -> Void in
            let tempArray = _str.componentsSeparatedByString(":")
            let tempCode = (tempArray[0] as NSString).integerValue
            print("----\(tempCode)----")
            switch tempCode {
            case 202:
                self.checkStatus()
                break
            case 203:
                dispatch_async(dispatch_get_main_queue(), {
                    self.performSegueWithIdentifier("goToRoom", sender: 1)
                });

                break
            default:
                break
            }
        }
        
        GameList.registerNib(UINib(nibName: "GameListTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "cell")
        GameList.delegate = self
        GameList.dataSource = self
       
        popViewSetup()
    }
    
    func popViewSetup(){
        PopInvitePlayer = NSBundle.mainBundle().loadNibNamed("Pop_InvitePlayer", owner: self, options: nil).last as? Pop_InvitePlayer
        PopInvitePlayer?.frame = self.view.bounds
        
        PopInvitePlayer.Yes = {
            Void in
            if self.selectPlayer != -1 {
                let tempIDN = self.dataArray.objectAtIndex(self.selectPlayer).valueForKey("PlayerIDN")!.integerValue
                self.sendRequest(tempIDN)
            }
        }
        PopInvitePlayer.No = {
            Void in
            self.Button_Challenge.enabled = true
            self.autoRefresh()
        }
        
        PopPlayerPlaying = NSBundle.mainBundle().loadNibNamed("Pop_PlayerPlaying", owner: self, options: nil).last as? Pop_PlayerPlaying
        PopPlayerPlaying?.frame = self.view.bounds
    }
    
    override func viewWillAppear(animated: Bool) {
        
        connectToGameLobby()
        Button_Challenge.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        if refreshTimer != nil {
            refreshTimer.invalidate()
            refreshTimer = nil
        }
        /*if checkStatusTimer != nil {
            checkStatusTimer.invalidate()
        }*/
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goToRoom" {
            let nextScene =  segue.destinationViewController as! GameRoomViewController
            if sender?.integerValue == 1 {
                nextScene.Player = 1
                nextScene.otherPlayerIDN = (dataArray.objectAtIndex(selectPlayer).valueForKey("PlayerIDN")?.integerValue)!
            }else if sender?.integerValue == 2 {
                nextScene.Player = 2
                nextScene.otherPlayerIDN = otherPlayerIDN
            }
            nextScene.GameMode = GameMode
        }
    }
 
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! GameListTableViewCell
        cell.PlayerName.text = "\(dataArray.objectAtIndex(indexPath.row).valueForKey("Name")!)"
        cell.Rank.text = "PPD: \(dataArray.objectAtIndex(indexPath.row).valueForKey("PPD")!)"
        cell.Country.text = "\(dataArray.objectAtIndex(indexPath.row).valueForKey("Country")!)"
        if indexPath.row == selectPlayer {
            cell.BG.image = UIImage(named: "Lobby_List_BG_Select")
        }else{
            cell.BG.image = UIImage(named: "Lobby_List_BG")
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectPlayer = indexPath.row
        GameList.reloadData()
    }
    
    @IBAction func refreshPressed(sender: AnyObject) {
        if refreshTimer != nil {
            refreshTimer.invalidate()
        }
        autoRefresh()
    }
    
    func autoRefresh(){
        API.connectionStart_RefreshLobby(userInfo.IDN!) { (isNotNull, dic) in
            let tempCode = dic.valueForKey("ResponeCode")!.integerValue
            if tempCode == 201 {
                if let tempData = dic.valueForKey("Detail") {
                    //self.refreshTimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector:#selector(GameLobbyViewController.autoRefresh), userInfo: nil, repeats: false)
                    self.selectPlayer = -1
                    self.dataArray = NSMutableArray()
                    if tempData.count != 0 {
                        self.dataArray = tempData as! NSMutableArray
                    }
                    self.GameList.reloadData()
                }else {
                }
            }
        }
    }
    
    
    func connectToGameLobby(){
        API.connectionStart_GameLobby(userInfo.IDN!, GameMode: GameMode) { (dic) in
            let tempCode = dic.valueForKey("ResponeCode")!.integerValue
            if tempCode == 200 {
                self.autoRefresh()
                self.refreshTimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(GameLobbyViewController.autoRefresh), userInfo: nil, repeats: true)
                //NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: #selector(GameLobbyViewController.checkStatus), userInfo: nil, repeats: false)
            }
        }

    }
    
    func checkStatus(){
        API.connectionStart_LobbyCheckStatus(userInfo.IDN!) { (dic) in
            let tempCode = dic.valueForKey("ResponeCode")!.integerValue
            if tempCode == 201 {
                //self.dataArray = NSMutableArray()
                //let tempArray = dic.valueForKey("Detail")
                //self.dataArray = tempArray as! NSMutableArray
                //self.GameList.reloadData()
                //NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(GameLobbyViewController.checkStatus), userInfo: nil, repeats: false)
            }else if tempCode == 202 {
                /*if self.checkStatusTimer != nil {
                    self.checkStatusTimer.invalidate()
                }*/
                let tempData = dic.valueForKey("Detail")
                let tempArray = tempData as! NSMutableArray
                self.otherPlayerIDN = tempArray.objectAtIndex(0).valueForKey("PlayerIDN") as! Int
                self.performSegueWithIdentifier("goToRoom", sender: 2)
            }
        }
    }
    
    func sendRequest(selectIDN: Int){
        /*API.connectionStart_InvitePlayer(userInfo.IDN!, IDN2: (dataArray.objectAtIndex(selectIDN).valueForKey("PlayerIDN")?.integerValue)!) { (dic) in
            print(dic)
            let tempCode = dic.valueForKey("ResponeCode")!.integerValue
            if tempCode == 207 {
                self.performSegueWithIdentifier("goToRoom", sender: 1)
            }else if tempCode == 206{
                self.view.addSubview(self.PopPlayerPlaying)
            }
        }*/
        socket.InvitePlayer(selectIDN)
    }
    
    @IBAction func BackPressed(sender: AnyObject) {
        /*API.connectionStart_LeaveLobby(userInfo.IDN!) { (isNotNull, dic) in
            if isNotNull {
                let tempCode = dic.valueForKey("ResponeCode")!.integerValue
                if tempCode == 200 {
                    self.navigationController?.popViewControllerAnimated(false)
                }else if tempCode == 501{
                    self.navigationController?.popViewControllerAnimated(false)
                }
            }else{
                
            }
        }*/
        socket.LeaveLobby()
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    @IBAction func ChallengePressed(sender: AnyObject) {
        Button_Challenge.enabled = false
        if refreshTimer != nil {
            refreshTimer.invalidate()
            refreshTimer = nil
        }
        if selectPlayer != -1 {
            //sendRequest(selectPlayer)
            self.view.addSubview(PopInvitePlayer!)
        }
        
    }
   
}
