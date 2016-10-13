//
//  Game01_ViewController.swift
//  Hiton
//
//  Created by yao on 21/04/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit
import MediaPlayer

class P2P01ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , QBRTCClientDelegate {
    
    var videoViews: NSMutableDictionary?
    var camereCapture = QBRTCCameraCapture()
    var session: QBRTCSession?
    var videoView = UIView()
    
    var qbUser: QBUUser?
    
    var socket = HitonSocketClass.sharedInstance
    
    var otherPlayerIDN = 0
    var otherPlayerQuickBloxIDN = 0

    
    var roundScore = 701
    var playerCount = 2
    
    var isMe = 0
    
    var P1_Name: String!
    var P2_Name: String!
    
    
    @IBOutlet var BGView: UIView!
    @IBOutlet var BG_ImageView: UIImageView!
    var preRoundScore = 0
    //var roundScore = 0
    var roundScore1 = 0
    var roundScore2 = 0
    var roundScore3 = 0
    var roundScore4 = 0
    
    //var playerCount = 0
    var selectScore = 0
    
    var nowPlayer = 1
    
    var round = 1
    var maxRound = 15
    var dartsHit = 1
    
    var dartIsThree = false
    
    var isNext = false
    var isNextFinish = true
    var isBust = false
    var isWinner = false
    var isShowVideo = false
    
    var RoundScoreArray = NSMutableArray()
    
    
    @IBOutlet var PlayerScore: UIImageView!
    @IBOutlet var Player1_Name: UILabel!
    @IBOutlet var Player2Score: UIImageView!
    @IBOutlet var Player2_Name: UILabel!
    
    
    @IBOutlet var P1_BG: UIImageView!
    @IBOutlet var P2_BG: UIImageView!
    
    
    @IBOutlet var View_WebCam: UIView!
    
    //var OnePlayerView: ScoreBar_1Player?
    //var TwoPlayerView: ScoreBar_2Player?
    //var ThreePlayerView: ScoreBar_3Player?
    //var FourPlayerView: ScoreBar_4Player?
    
    @IBOutlet var ButtonOption: UIButton!
    
    @IBOutlet var View_PlayerChange: UIView!
    
    @IBOutlet var GameTitle: UIImageView!
    @IBOutlet var Avatar: UIImageView!
    
    
    @IBOutlet var BigScore: UIImageView!
    //@IBOutlet var PlayerScore: UIImageView!
    @IBOutlet var ImageView_Dart1: UIImageView!
    @IBOutlet var ImageView_Dart2: UIImageView!
    @IBOutlet var ImageView_Dart3: UIImageView!
    
    @IBOutlet var ImageView_PPD: UIImageView!
    @IBOutlet var ImageView_Round: UIImageView!
    @IBOutlet var TableView_Round: UITableView!
    
    @IBOutlet var ScoreBar: UIView!
    var isNewRound = true
    var ThisRoundScoreArray = NSMutableArray()
    
    var P1 = PlayerClass()
    var P2 = PlayerClass()
    var P3 = PlayerClass()
    var P4 = PlayerClass()
    
    var removeDart: RemoveDart!
    var showRound: ShowRound!
    var throwDart: ThrowDarts!
    var Winner: WinnerView!
    
    
    var bluetooth = HitonBluetoothClass.sharedInstance
    var logic = GameClass()
    
    var audio = AudioClass()
    var video = VideoClass()
    
    
    var nextPlayerTap: UITapGestureRecognizer!
    
    var BGPlayerLayer: AVPlayer!
    var PlayerLayer: AVPlayerLayer!
    
    var RoundTimer: NSTimer!
    
    
    var option: OptionView!
    var opponentLeaveGame: OpponentLeaveGame!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBG()
        setupPop()
        //audio.StartGamePlay()
        
        
        bluetooth.hit = {
            (str) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                if self.nowPlayer == self.isMe {
                    if self.nowPlayer == self.isMe {
                        
                        self.LogicRun(str)
                        self.socket.sendData(self.otherPlayerIDN, str: str)
                    }
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
        
        TableView_Round.registerNib(UINib(nibName: "RoundTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "cell")
        TableView_Round.delegate = self
        TableView_Round.dataSource = self
        
        setup()
        
        if isMe == 1 {
            login()
        }
    }
    
    func setupPop(){
        opponentLeaveGame = NSBundle.mainBundle().loadNibNamed("OpponentLeaveGame", owner: self, options: nil).last as? OpponentLeaveGame
        opponentLeaveGame?.frame = self.view.bounds
        opponentLeaveGame.PlayerName = P2_Name
        opponentLeaveGame.setMessage()
        opponentLeaveGame.OK = {
            Void in
            self.socket.disconectFromServer()
            self.navigationController?.pushViewController((self.storyboard?.instantiateViewControllerWithIdentifier("Menu"))!, animated: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        RoundTimer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector: #selector(Game01_ViewController.RoundAnimation), userInfo: nil, repeats: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        let userInfo = ["hangup" : "hang up"]
        session?.hangUp(userInfo)
    }
    
    func setup(){
        setupScore()
        setupPlayer()
        setupView()
        setupOption()
        
        View_PlayerChange.alpha = 0
        View_PlayerChange.hidden = false
        
        //nextPlayerTap = UITapGestureRecognizer(target: self, action: #selector(Game01_ViewController.NextPlayer))
    }
    
    func setupScore(){
        /*switch selectScore {
        case 0:
            roundScore = 301
            P1.Score = 301
            P2.Score = 301
            break
        case 1:
            roundScore = 501
            P1.Score = 501
            P2.Score = 501
            break
        case 2:
            roundScore = 701
            P1.Score = 701
            P2.Score = 701
            break
        case 3:
            roundScore = 901
            P1.Score = 901
            P2.Score = 901
            break
        case 4:
            roundScore = 1101
            P1.Score = 1101
            P2.Score = 1101
            break
        case 5:
            roundScore = 1501
            P1.Score = 1501
            P2.Score = 1501
            break
        default:
            break
         }*/
        roundScore = 701
        P1.Score = 701
        P2.Score = 701
    }
    
    func setupOption(){
        option = NSBundle.mainBundle().loadNibNamed("OptionView", owner: self, options: nil).last as? OptionView
        option!.frame = self.view.bounds
        option.frame.origin.x = self.view.bounds.size.width
        self.view.addSubview(option!)
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
        
        BG_ImageView.image = img
    }
    
    func __playerItemDidPlayToEndTimeNotification(){
        BGPlayerLayer.seekToTime(kCMTimeZero)
    }
    
    func setupPlayer(){
        
        
        BigScore.drawMiddleScore(1, _score: P1.Score)
        Player1_Name.text = P1_Name
        Player2_Name.text = P2_Name
        
        
        P1_BG.image = UIImage(named: nowPlayer == 1 ? "Game01_2_1" : "Game01_2_1_Gray")
        P2_BG.image = UIImage(named: nowPlayer == 2 ? "Game01_2_2" : "Game01_2_2_Gray")
        
        PlayerScore.drawPlayerScore(1, _score: P1.Score)
        Player2Score.drawPlayerScoreGray(P2.Score)
        
        
        /*let btn = UIButton(frame: CGRectMake(200,0, 50,50))
        btn.setTitle("Bull", forState: .Normal)
        btn.addTarget(self, action: #selector(bull), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
        
        
        
        let btn1 = UIButton(frame: CGRectMake(250,0, 50,50))
        btn1.setTitle("T20", forState: .Normal)
        btn1.addTarget(self, action: #selector(t20), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn1)
        
        let btn2 = UIButton(frame: CGRectMake(300,0, 50,50))
        btn2.setTitle("random", forState: .Normal)
        btn2.addTarget(self, action: #selector(randon), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn2)
        
        
        let btn3 = UIButton(frame: CGRectMake(350,0, 50,50))
        btn3.setTitle("next", forState: .Normal)
        btn3.addTarget(self, action: #selector(next), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn3)*/
    }
    
    func bull (){
        self.LogicRun("29")
        self.socket.sendData(self.otherPlayerIDN, str: "29")
    }
    
    
    func t20 (){
        self.LogicRun("1f")
        self.socket.sendData(self.otherPlayerIDN, str: "1f")
    }
    
    func next (){
        self.LogicRun("70")
        self.socket.sendData(self.otherPlayerIDN, str: "70")
    }
    func randon(){
        var smallSingle = ["50", "56", "55", "51", "0a", "52", "05", "04", "09", "57", "08", "02", "58", "03", "53", "07", "54", "59", "06", "01"]
        let tempasd = smallSingle[Int(arc4random_uniform(10)+1)]
        self.LogicRun(tempasd)
        self.socket.sendData(self.otherPlayerIDN, str: tempasd)
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
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return maxRound
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! RoundTableViewCell
        cell.Round.drawRound(indexPath.row + 1)
        
        if indexPath.row + 1 < round{
            cell.RoundSelected.hidden = true
            switch nowPlayer {
            case 1:
                if P1.RoundTotalScoreArray.count != 0 {
                    cell.RoundScore.drawRoundScore(P1.RoundTotalScoreArray.objectAtIndex(indexPath.row) as! Int)
                }else{
                    cell.RoundScore.drawRoundScore(0)
                }
                break
            case 2:
                if P2.RoundTotalScoreArray.count != 0 {
                    cell.RoundScore.drawRoundScore(P2.RoundTotalScoreArray.objectAtIndex(indexPath.row) as! Int)
                }else{
                    cell.RoundScore.drawRoundScore(0)
                }
                break
            case 3:
                if P3.RoundTotalScoreArray.count != 0 {
                    cell.RoundScore.drawRoundScore(P3.RoundTotalScoreArray.objectAtIndex(indexPath.row) as! Int)
                }else{
                    cell.RoundScore.drawRoundScore(0)
                }
                break
            case 4:
                if P4.RoundTotalScoreArray.count != 0 {
                    cell.RoundScore.drawRoundScore(P4.RoundTotalScoreArray.objectAtIndex(indexPath.row) as! Int)
                }else{
                    cell.RoundScore.drawRoundScore(0)
                }
                break
            default:
                break
            }
            cell.RoundScore.hidden = false
        }else if round == indexPath.row + 1 {
            cell.RoundSelected.hidden = false
            var total = 0
            if ThisRoundScoreArray.count == 1 {
                total = ThisRoundScoreArray.objectAtIndex(0) as! Int
            }else if ThisRoundScoreArray.count == 2 {
                let a = ThisRoundScoreArray.objectAtIndex(0) as! Int
                let b = ThisRoundScoreArray.objectAtIndex(1) as! Int
                total = a + b
            }else if ThisRoundScoreArray.count == 3 {
                let a = ThisRoundScoreArray.objectAtIndex(0) as! Int
                let b = ThisRoundScoreArray.objectAtIndex(1) as! Int
                let c = ThisRoundScoreArray.objectAtIndex(2) as! Int
                total = a + b + c
            }
            
            cell.RoundScore.drawRoundScore(total)
            if isNewRound == true {
                cell.startAnimation(nowPlayer)
                
                self.isNewRound = false
            }
            cell.RoundScore.hidden = false
            
        }else{
            cell.RoundScore.hidden = true
            cell.RoundSelected.hidden = true
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.frame.size.width / 5
        
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
    
    func drawScore(_round: Int, _nPlayer: Int,_dart: Int, _SDTBM: String, _originalScore: Int){
        BigScore.drawMiddleScore(nowPlayer, _score: roundScore)
            if nowPlayer == 1 {
                PlayerScore.drawPlayerScore(1, _score: roundScore)
            }else{
                Player2Score.drawPlayerScore(2, _score: roundScore)
            }
            self.drawDartScore(self.dartsHit, _SDTBM: _SDTBM, _originalScore: _originalScore)
            if _SDTBM == "D-Bull" || _SDTBM == "S-Bull"{
                self.drawList(50)
            }else if _SDTBM == "Triple"{
                self.drawList(_originalScore * 3)
            }else if _SDTBM == "Double"{
                self.drawList(_originalScore * 2)
            }else if _SDTBM == "Miss"{
                self.drawList(0)
            }else{
                self.drawList(_originalScore)
            }

    }
    
    func drawList(_score: Int){
        ThisRoundScoreArray.addObject(_score)
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
    
    
    func maxRound1(){
        self.StopAnimation()
        if P1.Score < P2.Score {
            Winner.PlayerName.text = "Player 1"
        }else{
            Winner.PlayerName.text = "Player 2"
        }
        self.isWinner = true
        self.view.addSubview(self.Winner)
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(self.goMenu), userInfo: nil, repeats: false)
    }
    
    func NextPlayer(){
        if round == 15 && nowPlayer == playerCount {
            maxRound1()
        }else{
            isNextFinish = false
            if isBust == false{
                if dartsHit <= 3{
                    if dartsHit == 1 {
                        self.calScore("123")
                        self.calScore("123")
                        self.calScore("123")
                    }else if dartsHit == 2{
                        self.calScore("123")
                        self.calScore("123")
                    }else if dartsHit == 3{
                        self.calScore("123")
                    }
                    if isShowVideo == true {
                        video.VideoEnd = {
                            Void in
                            if self.dartIsThree == false {
                                self.nextPlayerAction()
                            }
                        }
                    }else{
                        self.nextPlayerAction()
                    }
                    
                }else{
                    
                    nextPlayerAction()
                }
            }else{
                
                nextPlayerAction()
            }
        }
        
    }
    
    func nextPlayerAction(){
        isShowVideo = false
        dartIsThree = false
        StopAnimation()
        video.stopVideo()
        //self.view.removeGestureRecognizer(nextPlayerTap)
        dartsHit = 1
        if isBust == true{}
        else {
            savePlayerScore(roundScore)
        }
        isBust = false
        isNext = false
        
            saveRoundScore()
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
            ChangeBG()
        //refreshList()
    }
    
    
    func LogicRun(str: String){
        if isWinner == false{
            if str == "70" {
                if isNextFinish == true{
                    if dartsHit <= 4 {
                        dartIsThree = false
                    }
                    NextPlayer()
                }else{
                    self.StopAnimation()
                }
            }else{
                if isNext == false{
                    
                    self.StopAnimation()
                    
                    if self.dartsHit >= 1 && self.dartsHit <= 3 {
                        self.dartIsThree = true
                        calScore(str)
                        
                    }else{
                    }
                }
            }
        }
    }
    
    func calScore(str: String){
        logic.Game_01_Logic(roundScore, hitScore: str, _p: nowPlayer == 1 ? P1 : P2) { (_score, _originalScore, _SDTBM, _status, _video) in
            //_status : 1 = Calculate / 2 = Bust
            switch _status {
            case 1:
                switch self.dartsHit {
                case 1:
                    if self.nowPlayer == 1 {
                        self.P1.ScoreArray.addObject(self.roundScore)
                    }else if self.nowPlayer == 2 {
                        self.P2.ScoreArray.addObject(self.roundScore)
                    }else if self.nowPlayer == 3 {
                        self.P3.ScoreArray.addObject(self.roundScore)
                    }else {
                        self.P4.ScoreArray.addObject(self.roundScore)
                    }
                    self.roundScore1 = self.roundScore
                    self.roundScore2 = _score
                    break
                case 2:
                    self.roundScore3 = _score
                    break
                case 3:
                    self.roundScore4 = _score
                    break
                case 4:
                    break
                default:
                    break
                }
                print("\(self.roundScore1) \(self.roundScore2) \(self.roundScore3)")
                self.dartsHit += 1
                if self.dartsHit == 4 {
                    if self.round == 15 && self.nowPlayer == self.playerCount {
                        self.maxRound1()
                    }else{
                        self.isNext = true
                        //self.view.addGestureRecognizer(self.nextPlayerTap)
                        self.showVideo(_video)
                        self.savePlayerScore(_score)
                        self.showChangePlayer()
                    }
                }else{
                    self.roundScore = _score
                }
                
                break
            case 2:
                self.video.PlayBust(self.view)
                self.isNext = true
                self.isBust = true
                self.ChangePlayer()
                self.roundScore = self.getPlayerScore()
                break
            case 3:
                self.drawDartScore(self.dartsHit, _SDTBM: _SDTBM, _originalScore: _originalScore)
                self.roundScore = 0
                self.isWinner = true
                self.view.addSubview(self.Winner)
                NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(self.goMenu), userInfo: nil, repeats: false)
                self.socket.GameEnd()
                break
            default:
                break
            }
            self.drawScore(self.round, _nPlayer: self.nowPlayer, _dart: self.dartsHit, _SDTBM: _SDTBM, _originalScore: _originalScore)
        }
        
    }
    
    
    func playerChangeColor(_player: Int){
        P1_BG.image = UIImage(named: _player == 1 ? "Game01_2_1" : "Game01_2_1_Gray")
        P2_BG.image = UIImage(named: _player == 2 ? "Game01_2_2" : "Game01_2_2_Gray")
        switch _player {
        case 1:
            PlayerScore.drawPlayerScore(1, _score: roundScore)
            Player2Score.drawPlayerScoreGray(P2.Score)
            break
        case 2:
            PlayerScore.drawPlayerScoreGray(P1.Score)
            Player2Score.drawPlayerScore(2, _score: roundScore)
            break
        default:
            break
        }
    }
    
    func resetDartScore(){
        ImageView_Dart1.resetDartScore(nowPlayer)
        ImageView_Dart2.resetDartScore(nowPlayer)
        ImageView_Dart3.resetDartScore(nowPlayer)
        ImageView_Dart1.dartTurnCircle(nowPlayer)
        
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
    
    func showVideo(_video: String){
        video.VideoStart = {
            Void in
            
            self.isShowVideo = true
        }
        if _video == "HatTrick" {
            video.PlayHatTrick(self.view)
        }else if _video == "ThreeInABed" {
            video.PlayThreeInABed(self.view)
        }else if _video == "LowTon" {
            video.PlayLowTon(self.view)
        }else if _video == "HighTon" {
            video.PlayHighTon(self.view)
        }else if _video == "Ton80" {
            video.PlayTon80(self.view)
        }else if _video == "BucketOfNail" {
            video.PlayBucketOfNail(self.view)
        }else if _video == "FishAndChip" {
            video.PlayFishAndChip(self.view)
        }
        
    }
    
    func savePlayerScore(_score: Int){
        roundScore = _score
        switch nowPlayer {
        case 1:
            P1.Score = _score
            break
        case 2:
            P2.Score = _score
            break
        case 3:
            P3.Score = _score
            break
        case 4:
            P4.Score = _score
            break
        default:
            break
        }
    }
    
    func ChangePlayer(){
        if View_PlayerChange.alpha == 0 {
            UIView.animateWithDuration(0.3) {
                self.View_PlayerChange.alpha = 1
            }
        }
    }
    
    func ChangPlayerPressed( isBust: Bool){
        isNewRound = true
        BigScore.drawMiddleScore(nowPlayer, _score: getPlayerScore())
        UIView.animateWithDuration(0.3, animations: {
            self.View_PlayerChange.alpha = 0
        }) { (bool) in
            self.resetDartScore()
            self.refreshList()
            
        }
    }
    
    func saveRoundScore(){
        var total = 0
        if isBust == false {
            if ThisRoundScoreArray.count == 3 {
                let a = ThisRoundScoreArray[0].integerValue
                let b = ThisRoundScoreArray[1].integerValue
                let c = ThisRoundScoreArray[2].integerValue
                total = a + b + c
            }else if ThisRoundScoreArray.count == 2 {
                let a = ThisRoundScoreArray[0].integerValue
                let b = ThisRoundScoreArray[1].integerValue
                total = a + b
            }else if ThisRoundScoreArray.count == 1 {
                total = ThisRoundScoreArray[0].integerValue
            }
            
        }else{
            total = 0
        }
        switch nowPlayer {
        case 1:
            P1.RoundTotalScoreArray.addObject(total)
            break
        case 2:
            P2.RoundTotalScoreArray.addObject(total)
            break
        case 3:
            P3.RoundTotalScoreArray.addObject(total)
            break
        case 4:
            P4.RoundTotalScoreArray.addObject(total)
            break
        default:
            break
        }
        RoundScoreArray.addObject(total)
        ThisRoundScoreArray = NSMutableArray()
        TableView_Round.reloadData()
        
    }
    
    func showChangePlayer(){
        self.ChangePlayer()
    }
    
    func PlayerCalculateScore(){
        switch nowPlayer {
        case 1:
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        default:
            break
        }
    }
    
    
    func getPlayerScore() -> Int{
        var tempScore = 0
        switch nowPlayer {
        case 1:
            tempScore = P1.Score
            break
        case 2:
            tempScore = P2.Score
            break
        case 3:
            tempScore = P3.Score
            break
        case 4:
            tempScore = P4.Score
            break
        default:
            break
        }
        return tempScore
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
