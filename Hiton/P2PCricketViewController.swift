




//
//  P2PCricketViewController.swift
//  Hiton
//
//  Created by yao on 30/08/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class P2PCricketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, QBRTCClientDelegate {

    @IBOutlet var BGView: UIView!
    @IBOutlet var BG_ImageView: UIImageView!
    @IBOutlet var ButtonOption: UIButton!
    
    @IBOutlet var ContentView: UIView!
    
    @IBOutlet var View_PlayerChange: UIView!
    
    @IBOutlet var GameTitle: UIImageView!
    @IBOutlet var Avatar: UIImageView!
    
    @IBOutlet var View_WebCam: UIView!
    
    @IBOutlet var ImageView_20: UIImageView!
    @IBOutlet var ImageView_19: UIImageView!
    @IBOutlet var ImageView_18: UIImageView!
    @IBOutlet var ImageView_17: UIImageView!
    @IBOutlet var ImageView_16: UIImageView!
    @IBOutlet var ImageView_15: UIImageView!
    @IBOutlet var ImageView_Bull: UIImageView!
    //@IBOutlet var BigScore: UIImageView!
    //@IBOutlet var PlayerScore: UIImageView!
    @IBOutlet var ImageView_Dart1: UIImageView!
    @IBOutlet var ImageView_Dart2: UIImageView!
    @IBOutlet var ImageView_Dart3: UIImageView!
    
    @IBOutlet var ImageView_PPD: UIImageView!
    @IBOutlet var ImageView_Round: UIImageView!
    @IBOutlet var TableView_Round: UITableView!
    
    @IBOutlet var ScoreBar: UIView!
    
    @IBOutlet var CR_Line1: UIView!
    @IBOutlet var Line1_Images: [UIImageView]!
    @IBOutlet var P1_Cover: UIImageView!
    
    
    @IBOutlet var CR_Line2: UIView!
    @IBOutlet var Line2_Images: [UIImageView]!
    @IBOutlet var P2_Cover: UIImageView!
    
    
    @IBOutlet var CR_Line3: UIView!
    @IBOutlet var Line3_Images: [UIImageView]!
    @IBOutlet var P3_Cover: UIImageView!
    
    
    @IBOutlet var CR_Line4: UIView!
    @IBOutlet var Line4_Images: [UIImageView]!
    @IBOutlet var P4_Cover: UIImageView!
    
    
    var ThisRoundCRArray = NSMutableArray()
    var CRArry = NSMutableArray()
    
    
    var RoundCRCountArray = NSMutableArray()
    var RoundCRBoolArray = NSMutableArray()
    
    
    var OnePlayerView: ScoreBar_1Player?
    var TwoPlayerView: ScoreBar_2Player?
    var ThreePlayerView: ScoreBar_3Player?
    var FourPlayerView: ScoreBar_4Player?
    
    var P1 = PlayerClass()
    var P2 = PlayerClass()
    var P3 = PlayerClass()
    var P4 = PlayerClass()
    
    var removeDart: RemoveDart!
    var showRound: ShowRound!
    var throwDart: ThrowDarts!
    var Winner: WinnerView!
    var CricketEffectView: CricketEffect!
    
    var option: OptionView!
    var gameSetting: GameSetting!
    
    var bluetooth = HitonBluetoothClass.sharedInstance
    var socket = HitonSocketClass.sharedInstance

    var logic = GameClass()
    
    var audio = AudioClass()
    var video = VideoClass()
    
    var preRoundScore = 0
    var roundScore = 0
    var roundScore1 = 0
    var roundScore2 = 0
    var roundScore3 = 0
    var roundScore4 = 0
    
    var playerCount = 2
    var selectScore = 0
    
    var nowPlayer = 1
    
    var round = 1
    var maxRound = 15
    var dartsHit = 1
    
    var Bool_20_Close = false
    var Bool_19_Close = false
    var Bool_18_Close = false
    var Bool_17_Close = false
    var Bool_16_Close = false
    var Bool_15_Close = false
    var Bool_Bull_Close = false
    
    var dartIsThree = false
    
    var directNextBool = false
    var isNext = false
    var isNextFinish = true
    var isBust = false
    var isWinner = false
    var isShowVideo = false
    var isNewRound = true
    
    var twentyClose = false
    var nineteenClose = false
    var eighteenClose = false
    var seventeenClose = false
    var sixteenClose = false
    var fifteenClose = false
    var bullClose = false
    
    var RoundScoreArray = NSMutableArray()
    
    var BGPlayerLayer: AVPlayer!
    var PlayerLayer: AVPlayerLayer!
    
    var RoundTimer: NSTimer!
    var nextPlayerTap: UITapGestureRecognizer!
    
    //var playerCount = 2
    
    var isMe = 0
    
    var opponentLeaveGame: OpponentLeaveGame!
    
    var otherPlayerIDN = 0
    var otherPlayerQuickBloxIDN = 0
    
    var videoViews: NSMutableDictionary?
    var camereCapture = QBRTCCameraCapture()
    var session: QBRTCSession?
    var videoView = UIView()
    
    var qbUser: QBUUser?
    
    
    var P1_Name: String!
    var P2_Name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBG()
        
        View_WebCam.backgroundColor = UIColor.clearColor()
        
        TableView_Round.registerNib(UINib(nibName: "CricketRoundTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "cell")
        TableView_Round.delegate = self
        TableView_Round.dataSource = self
        
        setup()
        
        bluetooth.hit = {
            (str) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                if self.nowPlayer == self.isMe {
                    self.LogicRun(str)
                    self.socket.sendData(self.otherPlayerIDN, str: str)
                }
            })
        }
        
        socket.notify = {
            (str) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                let tempCode = Int(str)
                if tempCode == 210 {
                    self.view.addSubview(self.opponentLeaveGame)
                }else{
                    let tempStr = str.lowercaseString
                    print(tempStr)
                    if self.nowPlayer != self.isMe {
                        self.LogicRun(tempStr)
                    }
                }
            })
        }
        
        
        QBRTCClient.initializeRTC()
        QBRTCClient.instance().addDelegate(self)
        //QBChat.instance().addDelegate(self)
        print(qbUser)
        print(otherPlayerQuickBloxIDN)
        print(isMe)
        
        if isMe == 1 {
            login()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        RoundTimer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector: #selector(Game01_ViewController.RoundAnimation), userInfo: nil, repeats: false)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func setup(){
        setupScore()
        setupPlayer()
        setupView()
        setupOption()
        refreshList()
        
        View_PlayerChange.alpha = 0
        View_PlayerChange.hidden = false
        nextPlayerTap = UITapGestureRecognizer(target: self, action: #selector(P2PCricketViewController.nextTap))
        
    }
    
    func setupScore(){
        switch playerCount {
        case 1:
            CR_Line1.hidden = true
            CR_Line3.hidden = true
            CR_Line4.hidden = true
            break
        case 2:
            
            CR_Line1.hidden = true
            CR_Line4.hidden = true
            break
        case 3:
            CR_Line4.hidden = true
            break
        case 4:
            break
        default:
            break
        }
    }
    
    func setupOption(){
        gameSetting = NSBundle.mainBundle().loadNibNamed("GameSetting", owner: self, options: nil).last as? GameSetting
        gameSetting!.frame = self.view.bounds
        gameSetting.setup(playerCount, _p1: P1, _p2: P2, _p3: P3, _p4: P4)
        gameSetting.back = {
            Void in
        }
        
        option = NSBundle.mainBundle().loadNibNamed("OptionView", owner: self, options: nil).last as? OptionView
        option!.frame = self.view.bounds
        option.frame.origin.x = self.view.bounds.size.width
        self.view.addSubview(option!)
        option.gameSetting = {
            Void in
            self.view.addSubview(self.gameSetting)
        }
        option.rethrowDart = {
            Void in
            //self.rethrowDart()
        }
        option.returnToGame = {
            Void in
            UIView.animateWithDuration(0.3, animations: {
                self.option.frame.origin.x = self.view.bounds.size.width
                }, completion: { (bool) in
                    
            })
        }
        option.Exit = {
            Void in
            self.navigationController?.pushViewController((self.storyboard?.instantiateViewControllerWithIdentifier("Menu"))!, animated: false)
        }
    }
    
    func setupView(){
        removeDart = NSBundle.mainBundle().loadNibNamed("RemoveDart", owner: self, options: nil).last as? RemoveDart
        removeDart!.frame = self.view.bounds
        removeDart.setup()
        
        showRound = NSBundle.mainBundle().loadNibNamed("ShowRound", owner: self, options: nil).last as? ShowRound
        showRound!.frame = self.view.bounds
        showRound.setup()
        
        throwDart = NSBundle.mainBundle().loadNibNamed("ThrowDarts", owner: self, options: nil).last as? ThrowDarts
        throwDart!.frame = self.view.bounds
        throwDart.setup()
        throwDart.AnimationEnd = {
            Void in
            self.isNextFinish = true
        }
        Winner = NSBundle.mainBundle().loadNibNamed("WinnerView", owner: self, options: nil).last as? WinnerView
        Winner!.frame = self.view.bounds
        
        CricketEffectView = NSBundle.mainBundle().loadNibNamed("CricketEffect", owner: self, options: nil).last as? CricketEffect
        CricketEffectView!.frame = self.view.bounds
        CricketEffectView.AnimationEnd = {
            Void in
            if self.directNextBool == true {
                self.NextPlayerAction()
            }else{
                if self.round == 15 && self.nowPlayer == self.playerCount {
                    self.EndGame()
                }else{
                    if self.isNext == true {
                        self.view.addGestureRecognizer(self.nextPlayerTap)
                        self.ChangePlayer()
                    }
                    
                }
            }
        }
    }
    
    
    func setupBG(){
        var img: UIImage!
        switch nowPlayer {
        case 1:
            img = UIImage(named: "P1_BG1")
            break
        case 2:
            img = UIImage(named: "P2_BG1")
            break
        case 3:
            img = UIImage(named: "P3_BG1")
            break
        case 4:
            img = UIImage(named: "P4_BG1")
            break
            
        default:
            break
        }
        BG_ImageView.image = img
        ChangeCover()
    }
    
    func ChangeBG(){
        var img: UIImage!
        switch nowPlayer {
        case 1:
            img = UIImage(named: "P1_BG1")
            break
        case 2:
            img = UIImage(named: "P2_BG1")
            break
        case 3:
            img = UIImage(named: "P3_BG1")
            break
        case 4:
            img = UIImage(named: "P4_BG1")
            break
        default:
            break
        }
        ChangeCover()
        BG_ImageView.image = img
    }
    
    func ChangeCover(){
        switch playerCount {
        case 1:
            P2_Cover.image = UIImage(named: "P1_Cricket_Cover")
            P2_Cover.hidden = false
            break
        case 2:
            switch nowPlayer {
            case 1:
                P2_Cover.image = UIImage(named: "P1_Cricket_Cover")
                P2_Cover.hidden = false
                P3_Cover.hidden = true
                break
            case 2:
                P3_Cover.image = UIImage(named: "P2_Cricket_Cover")
                P2_Cover.hidden = true
                P3_Cover.hidden = false
                break
            default:
                break
            }
            break
        case 3:
            switch nowPlayer {
            case 1:
                P1_Cover.image = UIImage(named: "P1_Cricket_Cover")
                P1_Cover.hidden = false
                P2_Cover.hidden = true
                P3_Cover.hidden = true
                break
            case 2:
                P2_Cover.image = UIImage(named: "P2_Cricket_Cover")
                P1_Cover.hidden = true
                P2_Cover.hidden = false
                P3_Cover.hidden = true
                break
            case 3:
                P3_Cover.image = UIImage(named: "P3_Cricket_Cover")
                P1_Cover.hidden = true
                P2_Cover.hidden = true
                P3_Cover.hidden = false
                break
            default:
                break
            }
            break
        case 4:
            switch nowPlayer {
            case 1:
                P1_Cover.image = UIImage(named: "P1_Cricket_Cover")
                P1_Cover.hidden = false
                P2_Cover.hidden = true
                P3_Cover.hidden = true
                P4_Cover.hidden = true
                break
            case 2:
                P2_Cover.image = UIImage(named: "P2_Cricket_Cover")
                P1_Cover.hidden = true
                P2_Cover.hidden = false
                P3_Cover.hidden = true
                P4_Cover.hidden = true
                break
            case 3:
                P3_Cover.image = UIImage(named: "P3_Cricket_Cover")
                P1_Cover.hidden = true
                P2_Cover.hidden = true
                P3_Cover.hidden = false
                P4_Cover.hidden = true
                break
            case 4:
                P4_Cover.image = UIImage(named: "P4_Cricket_Cover")
                P1_Cover.hidden = true
                P2_Cover.hidden = true
                P3_Cover.hidden = true
                P4_Cover.hidden = false
                break
            default:
                break
            }
            break
        default:
            break
        }
    }
    
    func __playerItemDidPlayToEndTimeNotification(){
        BGPlayerLayer.seekToTime(kCMTimeZero)
    }
    
    func setupPlayer(){
        TwoPlayerView = NSBundle.mainBundle().loadNibNamed("ScoreBar_2Player", owner: self, options: nil).last as? ScoreBar_2Player
        TwoPlayerView?.frame = ScoreBar.bounds
        TwoPlayerView!.setup(P1.Score)
        TwoPlayerView?.Player1_Name.text = P1_Name
        TwoPlayerView?.Player2_Name.text = P2_Name
        ScoreBar.addSubview(TwoPlayerView!)
        
        let sbtn = UIButton(frame: CGRectMake(100,0, 50,50))
        sbtn.setTitle("SBull", forState: .Normal)
        sbtn.addTarget(self, action: #selector(SBull), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(sbtn)
        
        let dbtn = UIButton(frame: CGRectMake(150,0, 50,50))
        dbtn.setTitle("DBull", forState: .Normal)
        dbtn.addTarget(self, action: #selector(DBull), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(dbtn)
        
        let btn = UIButton(frame: CGRectMake(200,0, 50,50))
        btn.setTitle("T20", forState: .Normal)
        btn.addTarget(self, action: #selector(T20), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
        
        let btn1 = UIButton(frame: CGRectMake(250,0, 50,50))
        btn1.setTitle("T19", forState: .Normal)
        btn1.addTarget(self, action: #selector(T19), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn1)
        
        let btn2 = UIButton(frame: CGRectMake(300,0, 50,50))
        btn2.setTitle("T18", forState: .Normal)
        btn2.addTarget(self, action: #selector(T18), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn2)
        
        let btn3 = UIButton(frame: CGRectMake(350,0, 50,50))
        btn3.setTitle("T17", forState: .Normal)
        btn3.addTarget(self, action: #selector(T17), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn3)
        
        let btn4 = UIButton(frame: CGRectMake(400,0, 50,50))
        btn4.setTitle("T16", forState: .Normal)
        btn4.addTarget(self, action: #selector(T16), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn4)
        
        let btn5 = UIButton(frame: CGRectMake(450,0, 50,50))
        btn5.setTitle("T15", forState: .Normal)
        btn5.addTarget(self, action: #selector(T15), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn5)
        
        
        let btn6 = UIButton(frame: CGRectMake(500,0, 50,50))
        btn6.setTitle("Random", forState: .Normal)
        btn6.addTarget(self, action: #selector(randon), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn6)
        
        let btn7 = UIButton(frame: CGRectMake(150, 50, 50,50))
        btn7.setTitle("Next", forState: .Normal)
        btn7.addTarget(self, action: #selector(Next), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn7)
        
        let btn8 = UIButton(frame: CGRectMake(200, 50, 50,50))
        btn8.setTitle("Miss", forState: .Normal)
        btn8.addTarget(self, action: #selector(Miss), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn8)
        
    }
    
    func SBull(){
        self.LogicRun("32")
        socket.sendData(otherPlayerIDN, str: "32")
     }
     
     func DBull(){
        self.LogicRun("29")
        socket.sendData(otherPlayerIDN, str: "29")
     }
     
     func T20(){
        self.LogicRun("1f")
        socket.sendData(otherPlayerIDN, str: "1f")
     }
     
     func T19(){
        self.LogicRun("24")
        socket.sendData(otherPlayerIDN, str: "24")
     }
     
     func T18(){
        self.LogicRun("3b")
        socket.sendData(otherPlayerIDN, str: "3b")
     }
     
     func T17(){
        self.LogicRun("36")
        socket.sendData(otherPlayerIDN, str: "36")
     }
     
     func T16(){
        self.LogicRun("25")
        socket.sendData(otherPlayerIDN, str: "25")
     }
     
     func T15(){
        self.LogicRun("35")
        socket.sendData(otherPlayerIDN, str: "35")
     }
     
     func randon(){
     var smallSingle = ["35", "25", "36", "3b", "24", "1f", "3f", "1b", "40", "45", "1a", "15", "49", "11", "4a", "4f", "10", "0b", "53", "07", "54", "59", "06", "01", "5d", "5d", "5d", "5d", "5d", "5d", "5d", "5d", "5d"]
     let tempasd = smallSingle[Int(arc4random_uniform(30)+1)]
        self.LogicRun(tempasd)
        socket.sendData(otherPlayerIDN, str: tempasd)
     }
     
     func Next(){
            self.LogicRun("70")
            socket.sendData(otherPlayerIDN, str: "70")
     }
     
     func Miss(){
        self.LogicRun("5d")
        socket.sendData(otherPlayerIDN, str: "5d")
     }
    
    @IBAction func OptionPressed(sender: AnyObject) {
        UIView.animateWithDuration(0.3, animations: {
            self.option.frame.origin.x = 0
            }, completion: { (bool) in
                
        })
    }
    
    
    func RemoveDartAnimation(isNewRound: Bool){
        self.view.addSubview(removeDart)
        removeDart.show()
        removeDart.AnimationEnd = {
            Void in
            if isNewRound == true {
                self.view.addSubview(self.showRound)
                self.showRound.show(self.round)
                self.showRound.AnimationEnd = {
                    Void in
                    self.view.addSubview(self.throwDart)
                    self.throwDart.show(self.nowPlayer)
                }
            }else {
                self.view.addSubview(self.throwDart)
                self.throwDart.show(self.nowPlayer)
            }
        }
        
    }
    
    func RoundAnimation(){
        self.view.addSubview(showRound)
        showRound.show(round)
        showRound.AnimationEnd = {
            Void in
            self.view.addSubview(self.throwDart)
            self.throwDart.show(self.nowPlayer)
        }
    }
    
    func StopAnimation(){
        isNextFinish = true
        if RoundTimer != nil {
            RoundTimer.invalidate()
        }
        throwDart.stopAnimation()
        removeDart.stopAnimation()
        showRound.stopAnimation()
    }
    
    func drawList(_score: Int){
        ThisRoundCRArray.addObject(_score)
        TableView_Round.reloadData()
    }
    
    func refreshList(){
        ImageView_Round.drawRound(1, _now: round, _max: 15)
        TableView_Round.reloadData()
        let index = NSIndexPath(forRow: round - 1, inSection: 0)
        TableView_Round.scrollToRowAtIndexPath(index, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    func goMenu(){
        self.navigationController?.pushViewController((self.storyboard?.instantiateViewControllerWithIdentifier("Menu"))!, animated: false)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return maxRound
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! CricketRoundTableViewCell
        cell.Round.drawRound(indexPath.row + 1)
        
        if indexPath.row + 1 < round{
            cell.RoundSelected.hidden = true
            switch nowPlayer {
            case 1:
                cell.CR_Images[0].image = UIImage(named: "P1_Cricket_\(P1.CRAllRoundLicense.objectAtIndex(indexPath.row).objectAtIndex(0))")
                cell.CR_Images[1].image = UIImage(named: "P1_Cricket_\(P1.CRAllRoundLicense.objectAtIndex(indexPath.row).objectAtIndex(1))")
                cell.CR_Images[2].image = UIImage(named: "P1_Cricket_\(P1.CRAllRoundLicense.objectAtIndex(indexPath.row).objectAtIndex(2))")
                break
            case 2:
                cell.CR_Images[0].image = UIImage(named: "P2_Cricket_\(P2.CRAllRoundLicense.objectAtIndex(indexPath.row).objectAtIndex(0))")
                cell.CR_Images[1].image = UIImage(named: "P2_Cricket_\(P2.CRAllRoundLicense.objectAtIndex(indexPath.row).objectAtIndex(1))")
                cell.CR_Images[2].image = UIImage(named: "P2_Cricket_\(P2.CRAllRoundLicense.objectAtIndex(indexPath.row).objectAtIndex(2))")
                break
            case 3:
                cell.CR_Images[0].image = UIImage(named: "P3_Cricket_\(P3.CRAllRoundLicense.objectAtIndex(indexPath.row).objectAtIndex(0))")
                cell.CR_Images[1].image = UIImage(named: "P3_Cricket_\(P3.CRAllRoundLicense.objectAtIndex(indexPath.row).objectAtIndex(1))")
                cell.CR_Images[2].image = UIImage(named: "P3_Cricket_\(P3.CRAllRoundLicense.objectAtIndex(indexPath.row).objectAtIndex(2))")
                break
            case 4:
                cell.CR_Images[0].image = UIImage(named: "P4_Cricket_\(P4.CRAllRoundLicense.objectAtIndex(indexPath.row).objectAtIndex(0))")
                cell.CR_Images[1].image = UIImage(named: "P4_Cricket_\(P4.CRAllRoundLicense.objectAtIndex(indexPath.row).objectAtIndex(1))")
                cell.CR_Images[2].image = UIImage(named: "P4_Cricket_\(P4.CRAllRoundLicense.objectAtIndex(indexPath.row).objectAtIndex(2))")
                break
            default:
                break
            }
        }else if round == indexPath.row + 1 {
            cell.RoundSelected.hidden = false
            if ThisRoundCRArray.count == 1 {
                tableDrawLicense(0, cell: cell)
            }else if ThisRoundCRArray.count == 2 {
                tableDrawLicense(1, cell: cell)
            }else if ThisRoundCRArray.count == 3 {
                tableDrawLicense(2, cell: cell)
            }else{
                tableRemoveLicense(cell)
            }
            
            if isNewRound == true {
                cell.startAnimation(nowPlayer)
                self.isNewRound = false
            }
        }else{
            cell.RoundSelected.hidden = true
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.frame.size.width / 5
        
    }
    
    func tableRemoveLicense(cell: CricketRoundTableViewCell){
        cell.CR_Images[0].image = UIImage(named: "")
        cell.CR_Images[1].image = UIImage(named: "")
        cell.CR_Images[2].image = UIImage(named: "")
    }
    
    func tableDrawLicense(index: Int, cell: CricketRoundTableViewCell){
        switch nowPlayer {
        case 1:
            cell.CR_Images[index].image = UIImage(named: ThisRoundCRArray[index] as! NSObject == 1 ? "P1_Cricket_1" : ThisRoundCRArray[index] as! NSObject == 2 ? "P1_Cricket_2" : ThisRoundCRArray[index] as! NSObject == 3 ? "P1_Cricket_3" : "P1_Cricket_0" )
            break
        case 2:
            cell.CR_Images[index].image = UIImage(named: ThisRoundCRArray[index] as! NSObject == 1 ? "P2_Cricket_1" : ThisRoundCRArray[index] as! NSObject == 2 ? "P2_Cricket_2" : ThisRoundCRArray[index] as! NSObject == 3 ? "P2_Cricket_3" : "P2_Cricket_0" )
            break
        case 3:
            cell.CR_Images[index].image = UIImage(named: ThisRoundCRArray[index] as! NSObject == 1 ? "P3_Cricket_1" : ThisRoundCRArray[index] as! NSObject == 2 ? "P3_Cricket_2" : ThisRoundCRArray[index] as! NSObject == 3 ? "P3_Cricket_3" : "P3_Cricket_0" )
            break
        case 4:
            cell.CR_Images[index].image = UIImage(named: ThisRoundCRArray[index] as! NSObject == 1 ? "P4_Cricket_1" : ThisRoundCRArray[index] as! NSObject == 2 ? "P4_Cricket_2" : ThisRoundCRArray[index] as! NSObject == 3 ? "P4_Cricket_3" : "P4_Cricket_0" )
            break
        default:
            break
        }
    }
    
    
    func LogicRun(_str: String){
        if isWinner == false {
            if _str == "70" {
                if dartsHit == 4 {
                    NextPlayerAction()
                }else{
                    for i in dartsHit...3 {
                        directNextBool = i == 3 ? true : false
                        self.CalculateMiss(0, _SDTB: "Miss")
                    }
                }
            }else{
                if isNext == false{
                    self.StopAnimation()
                    
                    if dartsHit >= 1 && dartsHit <= 3 {
                        //self.dartIsThree = true
                        //logic.Cricket_Logic(_str) { (_originalScore, _SDTBM, _status, _video) in
                        logic.Logic_Cricket(_str) { (_originalScore, _SDTBM, _status, _video, _sound) in
                            //print("\(_originalScore), \(_SDTBM), \(_status), \(_video), \(_sound)---")
                            //TIPS: _status : 1-Calculate 2-0 3-Win 4-Bust 5-Miss
                            //print("Video = \(_video)")
                            self.directNextBool = false
                            switch _status {
                            case 1:
                                self.CalculateScore(_originalScore, _SDTB: _SDTBM, _video: _video, _sound: _sound)
                                break
                            case 2:
                                self.CalculateMiss(_originalScore, _SDTB: _SDTBM)
                                break
                            case 3:
                                self.CalculateMiss(_originalScore, _SDTB: _SDTBM)
                                break
                            case 4:
                                break
                            case 5:
                                break
                            default:
                                break
                            }
                        }
                        
                    }else{
                        
                    }
                }
            }
        }
    }
    
    
    func showVideo(_videoStr: String){
        print(_videoStr)
        if _videoStr == "HatTrick" {
            video.PlayHatTrick(self.view)
        }else if _videoStr == "WhiteHorse"{
            video.PlayWhiteHorse(self.view)
        }else if _videoStr == "Ton80" {
            video.PlayTon80(self.view)
        }else if _videoStr == "ThreeInABed"{
            video.PlayThreeInABed(self.view)
        }else{
            
        }
    }
    
    func CheckLicenseCount(_video: String){
        let temp1 = ThisRoundCRArray.objectAtIndex(0).integerValue
        let temp2 = ThisRoundCRArray.objectAtIndex(1).integerValue
        let temp3 = ThisRoundCRArray.objectAtIndex(2).integerValue
        
        
        print(RoundCRBoolArray)
        let tempBool1 = RoundCRBoolArray.objectAtIndex(0).boolValue
        let tempBool2 = RoundCRBoolArray.objectAtIndex(1).boolValue
        let tempBool3 = RoundCRBoolArray.objectAtIndex(2).boolValue
        
        let tempCount = temp1 + temp2 + temp3
        
        var tempBool:Bool!
        if tempBool1 == false && tempBool2 == false && tempBool3 == false{
            tempBool = true
        }else{
            tempBool = false
        }
        
        if tempCount >= 5{
            print("show effect")
            //NextPlayerAction()
            //aaaddd
            
            self.isNext = true
            self.view.addSubview(CricketEffectView)
            CricketEffectView.drawImg(nowPlayer, _array: ThisRoundCRArray)
        }else{
            print("no show effect")
            if directNextBool == true {
                NextPlayerAction()
            }else{
                if self.round == 15 && self.nowPlayer == self.playerCount {
                    self.EndGame()
                    print("max round")
                }else{
                    self.isNext = true
                    self.view.addGestureRecognizer(self.nextPlayerTap)
                    self.showVideo(_video)
                    self.ChangePlayer()
                    
                }
            }
        }
    }
    
    func CalculateMiss(_score: Int, _SDTB: String){
        
        var tempPlayer: PlayerClass!
        var tempValue: Int!
        switch nowPlayer {
        case 1:
            tempPlayer = P1
            break
        case 2:
            tempPlayer = P2
            break
        case 3:
            tempPlayer = P3
            break
        case 4:
            tempPlayer = P4
            break
        default:
            break
        }
        dartsHit += 1
        self.drawDartScore(dartsHit, _SDTBM: _SDTB, _originalScore: _score)
        
        drawList(0)
        refreshList()
        RoundCRBoolArray.addObject(false)
        
        if self.dartsHit == 4 {
            if round == maxRound && nowPlayer == playerCount {
                isWinner = true
                if P1.Score > P2.Score {
                    Winner.PlayerName.text = P1_Name
                }else{
                    Winner.PlayerName.text = P2_Name
                }
                self.view.addSubview(Winner)
                NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(self.goMenu), userInfo: nil, repeats: false)
            }else{
                CheckLicenseCount("")
            }
            
        }else{
            //self.roundScore = _score
        }
    }
    
    func CalculateScore(_score: Int, _SDTB: String, _video: String, _sound: String){
        var tempVideo = _video
        var tempPlayer: PlayerClass!
        var tempValue: Int!
        switch nowPlayer {
        case 1:
            tempPlayer = P1
            break
        case 2:
            tempPlayer = P2
            break
        case 3:
            tempPlayer = P3
            break
        case 4:
            tempPlayer = P4
            break
        default:
            break
        }
        
        var tempBool = false
        if _SDTB != "Miss" {
            tempBool = CheckIsClose(_score)
        }
        
        if tempBool == true {
            logic.Cricket_Sound("Miss", _originalScore: 0)
            tempVideo = ""
        }else {
            logic.Cricket_Sound(_sound, _originalScore: _score)
        }
        
        switch _score {
        case 50:
            tempValue = 6
            Bool_Bull_Close = tempBool
            break
        case 25:
            tempValue = 6
            Bool_Bull_Close = tempBool
            break
        case 20:
            tempValue = 0
            Bool_20_Close = tempBool
            break
        case 19:
            tempValue = 1
            Bool_19_Close = tempBool
            break
        case 18:
            tempValue = 2
            Bool_18_Close = tempBool
            break
        case 17:
            tempValue = 3
            Bool_17_Close = tempBool
            break
        case 16:
            tempValue = 4
            Bool_16_Close = tempBool
            break
        case 15:
            tempValue = 5
            Bool_15_Close = tempBool
            break
        default:
            break
        }
        
        CheckingLicense(_score, _Player: tempPlayer, _SDTB: _SDTB, value: tempValue, _video: tempVideo)
    }
    
    func CheckIsClose(_score: Int) -> Bool {
        var tempBool = false
        switch playerCount {
        case 1:
            break
        case 2:
            if getPlayerLicense(P1, _score: _score) == true && getPlayerLicense(P2, _score: _score) == true{
                tempBool = true
            }
            break
        case 3:
            if getPlayerLicense(P1, _score: _score) == true && getPlayerLicense(P2, _score: _score) == true && getPlayerLicense(P3, _score: _score) == true{
                tempBool = true
            }
            break
        case 4:
            if getPlayerLicense(P1, _score: _score) == true && getPlayerLicense(P2, _score: _score) == true && getPlayerLicense(P3, _score: _score) == true && getPlayerLicense(P4, _score: _score) == true{
                tempBool = true
            }
            break
        default:
            break
        }
        
        return tempBool
    }
    
    func getPlayerLicense(_player: PlayerClass, _score: Int) -> Bool{
        var tempBool: Bool!
        switch _score {
        case 50:
            tempBool = _player.bullLicense
            break
        case 25:
            tempBool = _player.bullLicense
            break
        case 20:
            tempBool = _player.twentyLicense
            break
        case 19:
            tempBool = _player.nineteenLicense
            break
        case 18:
            tempBool = _player.eighteenLicense
            break
        case 17:
            tempBool = _player.seventeenLicense
            break
        case 16:
            tempBool = _player.sixteenLicense
            break
        case 15:
            tempBool = _player.fifteenLicense
            break
        default:
            break
        }
        return tempBool
    }
    
    func CheckingLicense(_Score: Int, _Player: PlayerClass, _SDTB: String, value: Int, _video: String){
        var tempBool: Bool!
        var tempHit: Int!
        var tempCount: Int!
        var count = _SDTB == "Triple" ? 3 : _SDTB == "Double" ? 2 : _SDTB == "D-Bull" ? 2 : _SDTB == "S-Bull" ? 1 : 1
        
        
        dartsHit += 1
        switch value {
        case 0:
            tempBool = _Player.twentyLicense
            tempHit = _Player.twentyHit
            break
        case 1:
            tempBool = _Player.nineteenLicense
            tempHit = _Player.nineteenHit
            break
        case 2:
            tempBool = _Player.eighteenLicense
            tempHit = _Player.eighteenHit
            break
        case 3:
            tempBool = _Player.seventeenLicense
            tempHit = _Player.seventeenHit
            break
        case 4:
            tempBool = _Player.sixteenLicense
            tempHit = _Player.sixteenHit
            break
        case 5:
            tempBool = _Player.fifteenLicense
            tempHit = _Player.fifteenHit
            break
        case 6:
            tempBool = _Player.bullLicense
            tempHit = _Player.bullHit
            break
        default:
            break
        }
        let tempLine = _SDTB == "Triple" ? 3 : _SDTB == "Double" ? 2 : _SDTB == "Single" ? 1 : _SDTB == "D-Bull" ? 2 : _SDTB == "S-Bull" ? 1 : 0
        
        if tempBool == true {
            let checkLineClose = CheckIsClose(_Score)
            if checkLineClose == false {
                drawList(tempLine)
                RoundCRBoolArray.addObject(false)
                let tempScore: Int!
                if _SDTB == "D-Bull" || _SDTB == "S-Bull" {
                    tempScore = (25 * count)
                }else {
                    tempScore = (_Score * count)
                }
                
                
                
                _Player.Score = _Player.Score + tempScore
                drawPlayerScore()
            }else{
                drawList(0)
                RoundCRBoolArray.addObject(true)
            }
        }else{
            drawList(tempLine)
            RoundCRBoolArray.addObject(false)
            tempCount = tempHit + count
            if tempCount >= 3 {
                
                switch value {
                case 0:
                    _Player.twentyLicense = true
                    break
                case 1:
                    _Player.nineteenLicense = true
                    break
                case 2:
                    _Player.eighteenLicense = true
                    break
                case 3:
                    _Player.seventeenLicense = true
                    break
                case 4:
                    _Player.sixteenLicense = true
                    break
                case 5:
                    _Player.fifteenLicense = true
                    break
                case 6:
                    _Player.bullLicense = true
                    break
                default:
                    break
                }
                if _Player.twentyLicense == true && _Player.nineteenLicense == true && _Player.eighteenLicense == true && _Player.seventeenLicense == true && _Player.sixteenLicense == true && _Player.fifteenLicense == true && _Player.bullLicense == true {
                    _Player.All_License_Get = true
                }else{
                    
                }
                let checkLineClose = CheckIsClose(_Score)
                
                if checkLineClose == false {
                    drawCR(value, count: 3)
                    if tempCount > 3 {
                        count = tempCount - 3
                        
                        // _Player.Score + (_Score * count)
                        let tempScore: Int!
                        if _SDTB == "D-Bull" || _SDTB == "S-Bull" {
                            tempScore = (25 * count)
                        }else {
                            tempScore = (_Score * count)
                        }
                        
                        
                        _Player.Score = _Player.Score + tempScore
                        drawPlayerScore()
                    }
                }else {
                    drawCRClose(value)
                }
            }else{
                drawCR(value, count: tempCount)
            }
            
            switch value {
            case 0:
                _Player.twentyHit = tempCount
                break
            case 1:
                _Player.nineteenHit = tempCount
                break
            case 2:
                _Player.eighteenHit = tempCount
                break
            case 3:
                _Player.seventeenHit = tempCount
                break
            case 4:
                _Player.sixteenHit = tempCount
                break
            case 5:
                _Player.fifteenHit = tempCount
                break
            case 6:
                _Player.bullHit = tempCount
                break
            default:
                break
            }
        }
        
        
        refreshList()
        
        let tempCheckWinner = CheckWinner()
        if tempCheckWinner == false {
            self.drawDartScore(self.dartsHit, _SDTBM: _SDTB, _originalScore: _Score)
            if self.dartsHit == 4 {
                print(round)
                if round == maxRound && nowPlayer == playerCount {
                    isWinner = true
                    if P1.Score > P2.Score {
                        Winner.PlayerName.text = P1_Name
                    }else{
                        Winner.PlayerName.text = P2_Name
                    }
                    self.view.addSubview(Winner)
                    NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(self.goMenu), userInfo: nil, repeats: false)
                }else{
                    if _video == ""  {
                        CheckLicenseCount(_video)
                    }else{
                        self.view.addGestureRecognizer(self.nextPlayerTap)
                        self.showVideo(_video)
                        self.ChangePlayer()
                    }
                }
                
            }else{
                //self.roundScore = _score
            }
        }else{
            //Win
            //showVideo(_video)
            isWinner = true
            if nowPlayer == 1 {
                Winner.PlayerName.text = P1_Name
            }else{
                Winner.PlayerName.text = P2_Name
            }
            self.view.addSubview(Winner)
            NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(self.goMenu), userInfo: nil, repeats: false)
        }
        
        
        
    }
    
    func CheckWinner() -> Bool{
        var tempPlayer: PlayerClass!
        switch nowPlayer {
        case 1:
            tempPlayer = P1
            break
        case 2:
            tempPlayer = P2
            break
        case 3:
            tempPlayer = P3
            break
        case 4:
            tempPlayer = P4
            break
        default:
            break
        }
        var tempBool = false
        if tempPlayer.All_License_Get == true {
            if nowPlayer == CheckingScore() {
                tempBool = true
                print("Checking winner true")
            }
        }
        
        return tempBool
    }
    
    func CheckingScore() -> Int {
        var tempInt = 0
        switch playerCount {
        case 2:
            tempInt = P1.Score >= P2.Score ? 1 : 2
            break
        case 3:
            if P1.Score >= P2.Score && P1.Score >= P3.Score {
                tempInt = 1
            }else if P2.Score >= P1.Score && P2.Score >= P3.Score {
                tempInt = 2
            }else{
                tempInt = 3
            }
            break
        case 4:
            if P1.Score >= P2.Score && P1.Score >= P3.Score && P1.Score >= P4.Score {
                tempInt = 1
            }else if P2.Score >= P1.Score && P2.Score >= P3.Score && P2.Score >= P4.Score {
                tempInt = 2
            }else if P3.Score >= P1.Score && P3.Score >= P2.Score && P3.Score >= P4.Score {
                tempInt = 3
            }else{
                tempInt = 4
            }
            break
        default:
            break
        }
        return tempInt
    }
    
    
    func drawPlayerScore(){
        
        switch playerCount {
        case 1:
            OnePlayerView?.ImageView_Score.drawPlayerScore(nowPlayer, _score: P1.Score)
            break
        case 2:
            switch nowPlayer {
            case 1:
                TwoPlayerView?.PlayerScore.drawPlayerScore(nowPlayer, _score: P1.Score)
                break
            case 2:
                TwoPlayerView?.Player2Score.drawPlayerScore(nowPlayer, _score: P2.Score)
                break
            default:
                break
            }
            break
        case 3:
            switch nowPlayer {
            case 1:
                ThreePlayerView?.PlayerScore.drawPlayerScore(nowPlayer, _score: P1.Score)
                break
            case 2:
                ThreePlayerView?.Player2Score.drawPlayerScore(nowPlayer, _score: P2.Score)
                break
            case 3:
                ThreePlayerView?.Player3Score.drawPlayerScore(nowPlayer, _score: P3.Score)
                break
            default:
                break
            }
            break
        case 4:
            switch nowPlayer {
            case 1:
                FourPlayerView?.PlayerScore.drawPlayerScore(nowPlayer, _score: P1.Score)
                break
            case 2:
                FourPlayerView?.Player2Score.drawPlayerScore(nowPlayer, _score: P2.Score)
                break
            case 3:
                FourPlayerView?.Player3Score.drawPlayerScore(nowPlayer, _score: P3.Score)
                break
            case 4:
                FourPlayerView?.Player4Score.drawPlayerScore(nowPlayer, _score: P4.Score)
                break
            default:
                break
            }
            break
        default:
            break
        }
    }
    
    func drawCR(index: Int, count: Int){
        switch playerCount {
        case 1:
            Line2_Images[index].image = UIImage(named: count == 1 ? "P1_Cricket_1" : count == 2 ? "P1_Cricket_2" : count == 3 ? "P1_Cricket_3" : "")
            break
        case 2:
            switch nowPlayer {
            case 1:
                Line2_Images[index].image = UIImage(named: count == 1 ? "P1_Cricket_1" : count == 2 ? "P1_Cricket_2" : count == 3 ? "P1_Cricket_3" : "")
                break
            case 2:
                Line3_Images[index].image = UIImage(named: count == 1 ? "P2_Cricket_1" : count == 2 ? "P2_Cricket_2" : count == 3 ? "P2_Cricket_3" : "")
                break
            default:
                break
            }
            break
        case 3:
            switch nowPlayer {
            case 1:
                Line1_Images[index].image = UIImage(named: count == 1 ? "P1_Cricket_1" : count == 2 ? "P1_Cricket_2" : count == 3 ? "P1_Cricket_3" : "")
                break
            case 2:
                Line2_Images[index].image = UIImage(named: count == 1 ? "P2_Cricket_1" : count == 2 ? "P2_Cricket_2" : count == 3 ? "P2_Cricket_3" : "")
                break
            case 3:
                Line3_Images[index].image = UIImage(named: count == 1 ? "P3_Cricket_1" : count == 2 ? "P3_Cricket_2" : count == 3 ? "P3_Cricket_3" : "")
                break
            default:
                break
            }
            break
        case 4:
            switch nowPlayer {
            case 1:
                Line1_Images[index].image = UIImage(named: count == 1 ? "P1_Cricket_1" : count == 2 ? "P1_Cricket_2" : count == 3 ? "P1_Cricket_3" : "")
                break
            case 2:
                Line2_Images[index].image = UIImage(named: count == 1 ? "P2_Cricket_1" : count == 2 ? "P2_Cricket_2" : count == 3 ? "P2_Cricket_3" : "")
                break
            case 3:
                Line3_Images[index].image = UIImage(named: count == 1 ? "P3_Cricket_1" : count == 2 ? "P3_Cricket_2" : count == 3 ? "P3_Cricket_3" : "")
                break
            case 4:
                Line4_Images[index].image = UIImage(named: count == 1 ? "P4_Cricket_1" : count == 2 ? "P4_Cricket_2" : count == 3 ? "P4_Cricket_3" : "")
                break
            default:
                break
            }
            
        default:
            break
        }
    }
    
    func drawCRClose(index: Int){
        switch index {
        case 0:
            ImageView_20.image = UIImage(named: "CR_Close_20")
            break
        case 1:
            ImageView_19.image = UIImage(named: "CR_Close_19")
            break
        case 2:
            ImageView_18.image = UIImage(named: "CR_Close_18")
            break
        case 3:
            ImageView_17.image = UIImage(named: "CR_Close_17")
            break
        case 4:
            ImageView_16.image = UIImage(named: "CR_Close_16")
            break
        case 5:
            ImageView_15.image = UIImage(named: "CR_Close_16")
            break
        case 6:
            ImageView_Bull.image = UIImage(named: "CR_Close_Bull")
            break
        default:
            break
        }
        switch playerCount {
        case 1:
            break
        case 2:
            Line2_Images[index].image = UIImage(named: "CR_Close_License")
            Line3_Images[index].image = UIImage(named: "CR_Close_License")
            let tempWidth = Line2_Images[index].bounds.size.width + ImageView_20.bounds.size.width + Line3_Images[index].bounds.size.width + 30
            let tempHeight = Line2_Images[index].bounds.size.height / 5
            let tempX = ImageView_20.center.x - (tempWidth / 2)
            let tempY = index == 0 ? ImageView_20.center.y + 5 : index == 1 ? ImageView_19.center.y + 5 : index == 2 ? ImageView_18.center.y + 5: index == 3 ? ImageView_17.center.y + 5 : index == 4 ? ImageView_16.center.y + 5 : index == 5 ? ImageView_15.center.y + 5 : ImageView_Bull.center.y + 5
            
            
            let CloseLine = UIImageView(image: UIImage(named: "CR_Close_Line"))
            CloseLine.frame.origin.x = tempX
            CloseLine.center.y = tempY
            CloseLine.frame.size.width = tempWidth
            CloseLine.frame.size.height = tempHeight
            ContentView.addSubview(CloseLine)
            break
        case 3:
            Line1_Images[index].image = UIImage(named: "CR_Close_License")
            Line2_Images[index].image = UIImage(named: "CR_Close_License")
            Line3_Images[index].image = UIImage(named: "CR_Close_License")
            let tempWidth = (Line2_Images[index].bounds.size.width * 3) + ImageView_20.bounds.size.width * 2.5
            let tempHeight = Line2_Images[index].bounds.size.height / 5
            let tempX = ImageView_20.center.x - (tempWidth / 2) - (ImageView_20.bounds.size.width / 2) - 5
            let tempY = index == 0 ? ImageView_20.center.y + 5 : index == 1 ? ImageView_19.center.y + 5 : index == 2 ? ImageView_18.center.y + 5: index == 3 ? ImageView_17.center.y + 5 : index == 4 ? ImageView_16.center.y + 5 : index == 5 ? ImageView_15.center.y + 5 : ImageView_Bull.center.y + 5
            
            
            let CloseLine = UIImageView(image: UIImage(named: "CR_Close_Line"))
            CloseLine.frame.origin.x = tempX
            CloseLine.center.y = tempY
            CloseLine.frame.size.width = tempWidth
            CloseLine.frame.size.height = tempHeight
            ContentView.addSubview(CloseLine)
            
            break
        case 4:
            Line1_Images[index].image = UIImage(named: "CR_Close_License")
            Line2_Images[index].image = UIImage(named: "CR_Close_License")
            Line3_Images[index].image = UIImage(named: "CR_Close_License")
            Line4_Images[index].image = UIImage(named: "CR_Close_License")
            let tempWidth = (Line1_Images[index].bounds.size.width * 4) + ImageView_20.bounds.size.width * 2.5
            let tempHeight = Line2_Images[index].bounds.size.height / 5
            let tempX = ImageView_20.center.x - (tempWidth / 2)
            let tempY = index == 0 ? ImageView_20.center.y + 5 : index == 1 ? ImageView_19.center.y + 5 : index == 2 ? ImageView_18.center.y + 5: index == 3 ? ImageView_17.center.y + 5 : index == 4 ? ImageView_16.center.y + 5 : index == 5 ? ImageView_15.center.y + 5 : ImageView_Bull.center.y + 5
            
            
            let CloseLine = UIImageView(image: UIImage(named: "CR_Close_Line"))
            CloseLine.frame.origin.x = tempX
            CloseLine.center.y = tempY
            CloseLine.frame.size.width = tempWidth
            CloseLine.frame.size.height = tempHeight
            ContentView.addSubview(CloseLine)
            
        default:
            break
        }
    }
    
    func drawDartScore(_dartsHit: Int, _SDTBM: String, _originalScore: Int){
        switch  _dartsHit-1{
        case 1:
            ImageView_Dart1.drawDartScore(_SDTBM, _score: _originalScore)
            ImageView_Dart2.dartTurnCircle(1)
            break
        case 2:
            ImageView_Dart2.drawDartScore(_SDTBM, _score: _originalScore)
            ImageView_Dart3.dartTurnCircle(1)
            break
        case 3:
            ImageView_Dart3.drawDartScore(_SDTBM, _score: _originalScore)
            break
        default:
            break
        }
    }
    
    func EndGame(){
        var tempInt = 1
        switch playerCount {
        case 2:
            tempInt = P1.Score > P2.Score ? 1 : 2
            break
        case 3:
            if P1.Score > P2.Score && P1.Score > P3.Score {
                tempInt = 1
            }else if P2.Score > P1.Score && P2.Score > P3.Score {
                tempInt = 2
            }else{
                tempInt = 3
            }
            break
        case 4:
            if P1.Score > P2.Score && P1.Score > P3.Score && P1.Score > P4.Score {
                tempInt = 1
            }else if P2.Score > P1.Score && P2.Score > P3.Score && P2.Score > P4.Score {
                tempInt = 2
            }else if P3.Score > P1.Score && P3.Score > P2.Score && P3.Score > P4.Score {
                tempInt = 3
            }else{
                tempInt = 4
            }
            break
        default:
            break
        }
        
        isWinner = true
        Winner.PlayerName.text = "Player \(tempInt)"
        self.view.addSubview(Winner)
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(self.goMenu), userInfo: nil, repeats: false)
    }
    
    
    //Next action
    func SaveLicenseAndReloadTableView(){
        switch nowPlayer {
        case 1:
            P1.CRAllRoundLicense.addObject(ThisRoundCRArray)
            break
        case 2:
            P2.CRAllRoundLicense.addObject(ThisRoundCRArray)
            break
        case 3:
            P3.CRAllRoundLicense.addObject(ThisRoundCRArray)
            break
        case 4:
            P4.CRAllRoundLicense.addObject(ThisRoundCRArray)
            break
        default:
            break
        }
        ThisRoundCRArray = NSMutableArray()
        TableView_Round.reloadData()
    }
    
    func ChangePlayer(){
        if View_PlayerChange.alpha == 0 {
            UIView.animateWithDuration(0.3) {
                self.View_PlayerChange.alpha = 1
            }
        }
    }
    
    func nextTap(){
        if nowPlayer == isMe {
            socket.sendData(otherPlayerIDN, str: "70")
            LogicRun("70")
        }
    }
    
    func NextPlayerAction(){
        isShowVideo = false
        dartIsThree = false
        StopAnimation()
        video.stopVideo()
        self.view.removeGestureRecognizer(nextPlayerTap)
        CricketEffectView.removeFromSuperview()
        dartsHit = 1
        if isBust == true{}
        else {
            //savePlayerScore(roundScore)
        }
        isBust = false
        isNext = false
        SaveLicenseAndReloadTableView()
        RoundCRBoolArray = NSMutableArray()
        
        switch playerCount {
        case 1:
            //saveRoundScore()
            nowPlayer = 1
            round += 1
            RemoveDartAnimation(true)
            self.ChangPlayerPressed(isBust)
            break
        case 2:
            //saveRoundScore()
            if nowPlayer == 2 {
                nowPlayer = 1
                roundScore = P1.Score
                round += 1
                RemoveDartAnimation(true)
            }else {
                nowPlayer = 2
                roundScore = P2.Score
                RemoveDartAnimation(false)
            }
            self.ChangPlayerPressed(isBust)
            self.playerChangeColor(nowPlayer)
            break
        case 3:
            //saveRoundScore()
            if nowPlayer == 1 {
                nowPlayer = 2
                roundScore = P2.Score
                RemoveDartAnimation(false)
            }else if nowPlayer == 2 {
                nowPlayer = 3
                roundScore = P3.Score
                RemoveDartAnimation(false)
            }else {
                nowPlayer = 1
                roundScore = P1.Score
                round += 1
                RemoveDartAnimation(true)
            }
            self.ChangPlayerPressed(isBust)
            self.playerChangeColor(nowPlayer)
            break
        case 4:
            //saveRoundScore()
            if nowPlayer == 1 {
                nowPlayer = 2
                roundScore = P2.Score
                RemoveDartAnimation(false)
            }else if nowPlayer == 2 {
                nowPlayer = 3
                roundScore = P3.Score
                RemoveDartAnimation(false)
            }else if nowPlayer == 3 {
                nowPlayer = 4
                roundScore = P4.Score
                RemoveDartAnimation(false)
            }else{
                nowPlayer = 1
                round += 1
                roundScore = P1.Score
                RemoveDartAnimation(true)
            }
            self.ChangPlayerPressed(isBust)
            self.playerChangeColor(nowPlayer)
            break
        default:
            break
        }
        ChangeBG()
    }
    
    
    func ChangPlayerPressed(isBust: Bool){
        isNewRound = true
        //BigScore.drawMiddleScore(nowPlayer, _score: getPlayerScore())
        UIView.animateWithDuration(0.3, animations: {
            self.View_PlayerChange.alpha = 0
        }) { (bool) in
            self.resetDartScore()
            self.refreshList()
            
        }
    }
    
    func resetDartScore(){
        ImageView_Dart1.resetDartScore(nowPlayer)
        ImageView_Dart2.resetDartScore(nowPlayer)
        ImageView_Dart3.resetDartScore(nowPlayer)
        ImageView_Dart1.dartTurnCircle(nowPlayer)
        
    }
    
    func playerChangeColor(_player: Int){
        switch playerCount {
        case 1:
            
            break
        case 2:
            TwoPlayerView?.P1_BG.image = UIImage(named: _player == 1 ? "Game01_2_1" : "Game01_2_1_Gray")
            TwoPlayerView?.P2_BG.image = UIImage(named: _player == 2 ? "Game01_2_2" : "Game01_2_2_Gray")
            TwoPlayerView?.line.constant = _player == 1 ? 50 : -50
            TwoPlayerView?.P1LeftConstraint.constant = _player == 1 ? 0 : 40
            TwoPlayerView?.P2RightConstraint.constant = _player == 2 ? 0 : 40
            switch _player {
            case 1:
                TwoPlayerView?.PlayerScore.drawPlayerScore(1, _score: roundScore)
                TwoPlayerView?.Player2Score.drawPlayerScoreGray(P2.Score)
                break
            case 2:
                TwoPlayerView?.PlayerScore.drawPlayerScoreGray(P1.Score)
                TwoPlayerView?.Player2Score.drawPlayerScore(2, _score: roundScore)
                break
            default:
                break
            }
            break
        case 3:
            ThreePlayerView?.P1_BG.image = UIImage(named: _player == 1 ? "Game01_4_1" : "Game01_4_Gray")
            ThreePlayerView?.P2_BG.image = UIImage(named: _player == 2 ? "Game01_4_2" : "Game01_4_Gray")
            ThreePlayerView?.P3_BG.image = UIImage(named: _player == 3 ? "Game01_4_3" : "Game01_4_Gray")
            ThreePlayerView?.line.constant = _player == 1 ? 40 : _player == 2 ? -40 : 0
            ThreePlayerView?.line2.constant = _player == 3 ? 40 : _player == 2 ? -40 : 0
            ThreePlayerView?.P1Right.constant = _player == 2 ? 0 : 20
            ThreePlayerView?.P2Right.constant = _player == 2 ? 0 : 20
            
            switch _player {
            case 1:
                ThreePlayerView?.PlayerScore.drawPlayerScore(1, _score: P1.Score)
                ThreePlayerView?.Player2Score.drawPlayerScoreGray(P2.Score)
                ThreePlayerView?.Player3Score.drawPlayerScoreGray(P3.Score)
                break
            case 2:
                ThreePlayerView?.PlayerScore.drawPlayerScoreGray(P1.Score)
                ThreePlayerView?.Player2Score.drawPlayerScore(2, _score: P2.Score)
                ThreePlayerView?.Player3Score.drawPlayerScoreGray(P3.Score)
                break
            case 3:
                ThreePlayerView?.PlayerScore.drawPlayerScoreGray(P1.Score)
                ThreePlayerView?.Player2Score.drawPlayerScoreGray(P2.Score)
                ThreePlayerView?.Player3Score.drawPlayerScore(3, _score: P3.Score)
                break
            default:
                break
            }
            break
        case 4:
            FourPlayerView?.P1_BG.image = UIImage(named: _player == 1 ? "Game01_4_1" : "Game01_4_Gray")
            FourPlayerView?.P2_BG.image = UIImage(named: _player == 2 ? "Game01_4_2" : "Game01_4_Gray")
            FourPlayerView?.P3_BG.image = UIImage(named: _player == 3 ? "Game01_4_3" : "Game01_4_Gray")
            FourPlayerView?.P4_BG.image = UIImage(named: _player == 4 ? "Game01_4_4" : "Game01_4_Gray")
            
            FourPlayerView?.line.constant = _player == 1 ? 30 : _player == 2 ? -30 : 0
            FourPlayerView?.line1.constant = _player == 2 ? -30 : _player == 3 ? 30 : 0
            FourPlayerView?.line2.constant = _player == 3 ? -30 : _player == 4 ? 30 : 0
            
            switch _player {
            case 1:
                FourPlayerView?.PlayerScore.drawPlayerScore(1, _score: P1.Score)
                FourPlayerView?.Player2Score.drawPlayerScoreGray(P2.Score)
                FourPlayerView?.Player3Score.drawPlayerScoreGray(P3.Score)
                FourPlayerView?.Player4Score.drawPlayerScoreGray(P4.Score)
                break
            case 2:
                FourPlayerView?.PlayerScore.drawPlayerScoreGray(P1.Score)
                FourPlayerView?.Player2Score.drawPlayerScore(2, _score: P2.Score)
                FourPlayerView?.Player3Score.drawPlayerScoreGray(P3.Score)
                FourPlayerView?.Player4Score.drawPlayerScoreGray(P4.Score)
                break
            case 3:
                FourPlayerView?.PlayerScore.drawPlayerScoreGray(P1.Score)
                FourPlayerView?.Player2Score.drawPlayerScoreGray(P2.Score)
                FourPlayerView?.Player3Score.drawPlayerScore(3, _score: P3.Score)
                FourPlayerView?.Player4Score.drawPlayerScoreGray(P4.Score)
                break
            case 4:
                FourPlayerView?.PlayerScore.drawPlayerScoreGray(P1.Score)
                FourPlayerView?.Player2Score.drawPlayerScoreGray(P2.Score)
                FourPlayerView?.Player3Score.drawPlayerScoreGray(P3.Score)
                FourPlayerView?.Player4Score.drawPlayerScore(4, _score: P4.Score)
                break
            default:
                break
            }
            break
        default:
            break
        }
    }
    
    //------------------------quickblox -------
    
    func login(){
        QBChat.instance().connectWithUser(qbUser!) { (error: NSError?) -> Void in
            if error == nil {
                //if self.isMe == 1 {
                self.startCall()
                //}
            }else{
                print(error)
            }
        }
        
    }
    
    func startCall(){
        let opponentsIDs = [otherPlayerQuickBloxIDN]//[11286132]
        session = QBRTCClient.instance().createNewSessionWithOpponents(opponentsIDs, withConferenceType: .Video)
        
        let userInfo = ["startCall" : "userInfo"]
        
        let videoFormat = QBRTCVideoFormat.defaultFormat()
        videoFormat.width = 640
        videoFormat.height = 480
        // videoFormat.pixelFormat = QBRTCPixelFormat.FormatARGB
        
        let position = AVCaptureDevicePosition.Front
        let preferredCameraPostion = position
        
        camereCapture = QBRTCCameraCapture(videoFormat: videoFormat, position: preferredCameraPostion)
        camereCapture.previewLayer.frame = CGRectMake(0, 0, 640, 480)
        camereCapture.startSession()
        
        
        
        QBRTCConfig.mediaStreamConfiguration().audioCodec = QBRTCAudioCodec.CodecISAC
        QBRTCSoundRouter.instance().deinitialize()
        self.session?.startCall(userInfo)
    }
    
    func acceptCall(){
        let userInfo = ["acceptCall" : "userInfo"]
        let videoFormat = QBRTCVideoFormat.defaultFormat()
        videoFormat.width = 640
        videoFormat.height = 480
        //videoFormat.pixelFormat = QBRTCPixelFormat.FormatARGB
        //AVCaptureSessionPresetLow
        
        
        
        let position = AVCaptureDevicePosition.Front
        let preferredCameraPostion = position
        
        camereCapture = QBRTCCameraCapture(videoFormat: videoFormat, position: preferredCameraPostion)
        camereCapture.previewLayer.frame = (View_WebCam.bounds)
        camereCapture.startSession()
        
        QBRTCConfig.mediaStreamConfiguration().audioCodec = QBRTCAudioCodec.CodecISAC
        QBRTCSoundRouter.instance().deinitialize()
        
        self.session?.acceptCall(userInfo)
        
    }
    
    func setVideoView2(v: UIView){
        if View_WebCam != v {
            //videoView.removeFromSuperview()
            videoView = v
            videoView.frame = (View_WebCam.bounds)
            videoView.backgroundColor = UIColor.clearColor()
            View_WebCam.addSubview(videoView)
        }
    }
    
    
    
    func videoViewWithOpponentID(opponrntID: NSNumber) -> UIView{
        if (videoViews == nil){
            videoViews = NSMutableDictionary()
        }
        
        var result = UIView()
        
        var remoteVideoView = QBRTCRemoteVideoView()
        let remoteVideoTrak = session?.remoteVideoTrackWithUserID(opponrntID)
        remoteVideoView = QBRTCRemoteVideoView(frame: (View_WebCam.bounds))
        videoViews![opponrntID] = remoteVideoView
        result = remoteVideoView
        remoteVideoView.setVideoTrack(remoteVideoTrak)
        
        return result
    }
    
    
    func didReceiveNewSession(session: QBRTCSession!, userInfo: [NSObject : AnyObject]!) {
        print("didReceiveNewSession")
        self.session = session
        acceptCall()
    }
    
    func session(session: QBRTCSession!, acceptedByUser userID: NSNumber!, userInfo: [NSObject : AnyObject]!) {
        print("accept user")
        session.localMediaStream.audioTrack.enabled = false
    }
    
    
    func session(session: QBRTCSession!, connectedToUser userID: NSNumber!) {
        print("connectedToUser")
        session.localMediaStream.audioTrack.enabled = false
    }
    
    func session(session: QBRTCSession!, initializedLocalMediaStream mediaStream: QBRTCMediaStream!) {
        print("initializedLocalMediaStream")
        mediaStream.audioTrack.enabled = false
        session.localMediaStream.audioTrack.enabled = false
        mediaStream.videoTrack.videoCapture = camereCapture
    }
    
    func session(session: QBRTCSession!, startedConnectingToUser userID: NSNumber!) {
        print("startedConnectingToUser")
        session.localMediaStream.audioTrack.enabled = false
    }
    
    
    func session(session: QBRTCSession!, receivedRemoteVideoTrack videoTrack: QBRTCVideoTrack!, fromUser userID: NSNumber!) {
        print("receivedRemoteVideoTrack")
        session.localMediaStream.audioTrack.enabled = false
        let opponentVideoView = videoViewWithOpponentID(userID)
        setVideoView2(opponentVideoView)
    }
    
    func session(session: QBRTCSession!, connectionFailedForUser userID: NSNumber!) {
        print("connectionFailedForUser")
    }
    
    func session(session: QBRTCSession!, updatedStatsReport report: QBRTCStatsReport!, forUserID userID: NSNumber!) {
        print("updatedStatsReport")
    }
    
    func sessionDidClose(session: QBRTCSession!) {
        self.session = nil
    }


}
