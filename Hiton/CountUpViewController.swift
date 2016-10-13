//
//  CountUpViewController.swift
//  Hiton
//
//  Created by yao on 25/07/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class CountUpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var BGView: UIView!
    @IBOutlet var BG_ImageView: UIImageView!
    var preRoundScore = 0
    var roundScore = 0
    var roundScore1 = 0
    var roundScore2 = 0
    var roundScore3 = 0
    var roundScore4 = 0
    
    var playerCount = 0
    var selectScore = 0
    
    var nowPlayer = 1
    
    var round = 1
    let maxRound = 8
    var dartsHit = 1
    
    var dartIsThree = false
    
    var isNext = false
    var isNextFinish = true
    var isBust = false
    var isWinner = false
    var isShowVideo = false
    
    var RoundScoreArray = NSMutableArray()
    
    var OnePlayerView: ScoreBar_1Player?
    var TwoPlayerView: ScoreBar_2Player?
    var ThreePlayerView: ScoreBar_3Player?
    var FourPlayerView: ScoreBar_4Player?
    
    @IBOutlet var ButtonOption: UIButton!
    
    @IBOutlet var View_PlayerChange: UIView!
    
    @IBOutlet var GameTitle: UIImageView!
    @IBOutlet var Avatar: UIImageView!
    
    
    @IBOutlet var BigScore: UIImageView!
    @IBOutlet var PlayerScore: UIImageView!
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
    var gameSetting: GameSetting!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBG()
        
        bluetooth.hit = {
            (str) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                print(str)
                self.LogicRun(str)
            })
        }
        
        TableView_Round.registerNib(UINib(nibName: "RoundTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "cell")
        TableView_Round.delegate = self
        TableView_Round.dataSource = self
        
        setup()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(animated: Bool) {
        RoundTimer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector: #selector(Game01_ViewController.RoundAnimation), userInfo: nil, repeats: false)
    }
    
    
    func setup(){
        setupScore()
        setupPlayer()
        setupView()
        setupOption()
        refreshList()
        
        View_PlayerChange.alpha = 0
        View_PlayerChange.hidden = false
        
        nextPlayerTap = UITapGestureRecognizer(target: self, action: #selector(Game01_ViewController.NextPlayer))
    }
    
    func setupScore(){
        roundScore = 0
        P1.Score = 0
        P2.Score = 0
        P3.Score = 0
        P4.Score = 0
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
            self.rethrowDart()
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
        /*var filePath: String?
         switch nowPlayer{
         case 1:
         filePath = NSBundle.mainBundle().pathForResource("BG_P1", ofType: "mp4")
         break
         case 2:
         filePath = NSBundle.mainBundle().pathForResource("BG_P2", ofType: "mp4")
         break
         case 3:
         filePath = NSBundle.mainBundle().pathForResource("BG_P3", ofType: "mp4")
         break
         case 4:
         filePath = NSBundle.mainBundle().pathForResource("BG_P4", ofType: "mp4")
         break
         default:
         break
         }
         let tempURL = NSURL(fileURLWithPath: filePath!)
         let tempPlayerItem = AVPlayerItem(URL: tempURL)
         BGPlayerLayer = AVPlayer(playerItem: tempPlayerItem)
         BGPlayerLayer.actionAtItemEnd = AVPlayerActionAtItemEnd.None
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(Game01_ViewController.__playerItemDidPlayToEndTimeNotification), name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
         PlayerLayer = AVPlayerLayer(player: BGPlayerLayer)
         PlayerLayer.frame = self.view.bounds
         PlayerLayer.player?.play()
         BGView.layer.addSublayer(PlayerLayer)*/
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
        /*var filePath: String?
         switch nowPlayer{
         case 1:
         filePath = NSBundle.mainBundle().pathForResource("BG_P1", ofType: "mp4")
         break
         case 2:
         filePath = NSBundle.mainBundle().pathForResource("BG_P2", ofType: "mp4")
         break
         case 3:
         filePath = NSBundle.mainBundle().pathForResource("BG_P3", ofType: "mp4")
         break
         case 4:
         filePath = NSBundle.mainBundle().pathForResource("BG_P4", ofType: "mp4")
         break
         default:
         break
         }
         let tempURL = NSURL(fileURLWithPath: filePath!)
         let tempPlayerItem = AVPlayerItem(URL: tempURL)
         BGPlayerLayer = AVPlayer(playerItem: tempPlayerItem)
         BGPlayerLayer.actionAtItemEnd = AVPlayerActionAtItemEnd.None
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(Game01_ViewController.__playerItemDidPlayToEndTimeNotification), name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
         PlayerLayer = AVPlayerLayer(player: BGPlayerLayer)
         PlayerLayer.frame = self.view.bounds
         PlayerLayer.player?.play()
         //PlayerLayer.removeFromSuperlayer()
         BGView.layer.addSublayer(PlayerLayer)*/
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
        switch playerCount {
        case 1:
            BigScore.drawMiddleScore(1, _score: P1.Score)
            OnePlayerView = NSBundle.mainBundle().loadNibNamed("ScoreBar_1Player", owner: self, options: nil).last as? ScoreBar_1Player
            OnePlayerView?.frame = ScoreBar.bounds
            OnePlayerView!.setup(P1.Score)
            ScoreBar.addSubview(OnePlayerView!)
            break
        case 2:
            BigScore.drawMiddleScore(1, _score: P1.Score)
            TwoPlayerView = NSBundle.mainBundle().loadNibNamed("ScoreBar_2Player", owner: self, options: nil).last as? ScoreBar_2Player
            TwoPlayerView?.frame = ScoreBar.bounds
            TwoPlayerView!.setup(P1.Score)
            ScoreBar.addSubview(TwoPlayerView!)
            break
        case 3:
            BigScore.drawMiddleScore(1, _score: P1.Score)
            ThreePlayerView = NSBundle.mainBundle().loadNibNamed("ScoreBar_3Player", owner: self, options: nil).last as? ScoreBar_3Player
            ThreePlayerView?.frame = ScoreBar.bounds
            ThreePlayerView!.setup(P1.Score)
            ScoreBar.addSubview(ThreePlayerView!)
            break
        case 4:
            BigScore.drawMiddleScore(1, _score: P1.Score)
            FourPlayerView = NSBundle.mainBundle().loadNibNamed("ScoreBar_4Player", owner: self, options: nil).last as? ScoreBar_4Player
            FourPlayerView?.frame = ScoreBar.bounds
            FourPlayerView!.setup(P1.Score)
            ScoreBar.addSubview(FourPlayerView!)
            break
        default:
            break
        }
        
        let btn = UIButton(frame: CGRectMake(200,0, 50,50))
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
        self.view.addSubview(btn3)
    }
    
    func bull (){
        self.LogicRun("29")
    }
    
    
    func t20 (){
        self.LogicRun("1f")
    }
    
    func next (){
        self.LogicRun("70")
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
    
    func rethrowDart(){
        UIView.animateWithDuration(0.3, animations: {
            self.option.frame.origin.x = self.view.bounds.size.width
            }, completion: { (bool) in
                
        })
        if round == 1 && nowPlayer == 1 && dartsHit == 1 {
            
        }else{
            switch dartsHit {
            case 1:
                switch playerCount {
                case 1:
                    round -= 1
                    resetDartScore()
                    break
                case 2:
                    if nowPlayer == 1 {
                        round -= 1
                        nowPlayer = 2
                    }else{
                        nowPlayer = 1
                    }
                    resetDartScore()
                    break
                case 3:
                    if nowPlayer == 1 {
                        round -= 1
                        nowPlayer = 3
                    }else if nowPlayer == 2 {
                        nowPlayer = 1
                    }else{
                        nowPlayer = 2
                    }
                    resetDartScore()
                    break
                case 4:
                    if nowPlayer == 1 {
                        round -= 1
                        nowPlayer = 4
                    }else if nowPlayer == 2 {
                        nowPlayer = 1
                    }else if nowPlayer == 3 {
                        nowPlayer = 2
                    }else{
                        nowPlayer = 3
                    }
                    resetDartScore()
                    break
                default:
                    break
                }
                switch nowPlayer {
                case 1:
                    roundScore = P1.ScoreArray.objectAtIndex(round-1).integerValue
                    if P1.ScoreArray.count-1 > round {
                        P1.ScoreArray.removeObjectAtIndex(round)
                        P1.RoundTotalScoreArray.removeObjectAtIndex(round)
                    }
                    P1.Score = roundScore
                    break
                case 2:
                    roundScore = P2.ScoreArray.objectAtIndex(round-1).integerValue
                    if P2.ScoreArray.count-1 > round {
                        P2.ScoreArray.removeObjectAtIndex(round)
                        P2.RoundTotalScoreArray.removeObjectAtIndex(round)
                    }
                    P2.Score = roundScore
                    break
                case 3:
                    roundScore = P3.ScoreArray.objectAtIndex(round-1).integerValue
                    if P3.ScoreArray.count-1 > round {
                        P3.ScoreArray.removeObjectAtIndex(round)
                        P3.RoundTotalScoreArray.removeObjectAtIndex(round)
                    }
                    P3.Score = roundScore
                    break
                case 4:
                    roundScore = P4.ScoreArray.objectAtIndex(round-1).integerValue
                    if P4.ScoreArray.count-1 > round {
                        P4.ScoreArray.removeObjectAtIndex(round)
                        P4.RoundTotalScoreArray.removeObjectAtIndex(round)
                    }
                    P4.Score = roundScore
                    break
                default:
                    break
                }
                break
            case 2:
                roundScore = roundScore1
                dartsHit -= 1
                ImageView_Dart1.resetDartScore(nowPlayer)
                ImageView_Dart1.dartTurnCircle(nowPlayer)
                ImageView_Dart2.resetDartScore(nowPlayer)
                break
            case 3:
                roundScore = roundScore2
                dartsHit -= 1
                ImageView_Dart2.resetDartScore(nowPlayer)
                ImageView_Dart2.dartTurnCircle(nowPlayer)
                ImageView_Dart3.resetDartScore(nowPlayer)
                //dartsHit -= 1
                break
            case 4:
                break
            default:
                break
            }
        }
        
        switch playerCount {
        case 1:
            OnePlayerView?.ImageView_Score.drawPlayerScore(nowPlayer, _score: roundScore)
            break
        case 2:
            if nowPlayer == 1 {
                //TwoPlayerView?.drawScore(nowPlayer, _score: roundScore)
                TwoPlayerView?.PlayerScore.drawPlayerScore(1, _score: roundScore)
            }else if nowPlayer == 2{
                //TwoPlayerView?.drawScore(nowPlayer, _score: roundScore)
                TwoPlayerView?.Player2Score.drawPlayerScore(2, _score: roundScore)
            }
            break
        case 3:
            if nowPlayer == 1 {
                ThreePlayerView?.PlayerScore.drawPlayerScore(1, _score: roundScore)
            }else if nowPlayer == 2{
                ThreePlayerView?.Player2Score.drawPlayerScore(2, _score: roundScore)
            }else if nowPlayer == 3{
                ThreePlayerView?.Player3Score.drawPlayerScore(3, _score: roundScore)
            }
            
            break
        case 4:
            if nowPlayer == 1 {
                FourPlayerView?.PlayerScore.drawPlayerScore(1, _score: roundScore)
            }else if nowPlayer == 2{
                FourPlayerView?.Player2Score.drawPlayerScore(2, _score: roundScore)
            }else if nowPlayer == 3{
                FourPlayerView?.Player3Score.drawPlayerScore(3, _score: roundScore)
            }else if nowPlayer == 4{
                FourPlayerView?.Player4Score.drawPlayerScore(4, _score: roundScore)
            }
            break
        default:
            break
        }
        playerChangeColor(nowPlayer)
        BigScore.drawMiddleScore(nowPlayer, _score: roundScore)
        ChangeBG()
        refreshList()
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
    
    
    
    func randon(){
        var smallSingle = ["50", "56", "55", "51", "0a", "52", "05", "04", "09", "57", "08", "02", "58", "03", "53", "07", "54", "59", "06", "01"]
        let tempasd = smallSingle[Int(arc4random_uniform(10)+1)]
        self.LogicRun(tempasd)
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
        switch playerCount {
        case 1:
            OnePlayerView?.ImageView_Score.drawPlayerScore(1, _score: roundScore)
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
            break
        case 2:
            self.drawDartScore(self.dartsHit, _SDTBM: _SDTBM, _originalScore: _originalScore)
            if nowPlayer == 1 {
                TwoPlayerView?.PlayerScore.drawPlayerScore(1, _score: roundScore)
            }else{
                TwoPlayerView?.Player2Score.drawPlayerScore(2, _score: roundScore)
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
            
            break
        case 3:
            self.drawDartScore(self.dartsHit, _SDTBM: _SDTBM, _originalScore: _originalScore)
            if nowPlayer == 1 {
                ThreePlayerView?.PlayerScore.drawPlayerScore(1, _score: roundScore)
            }else if nowPlayer == 2{
                ThreePlayerView?.Player2Score.drawPlayerScore(2, _score: roundScore)
            }else{
                ThreePlayerView?.Player3Score.drawPlayerScore(3, _score: roundScore)
            }
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
            
            break
        case 4:
            self.drawDartScore(self.dartsHit, _SDTBM: _SDTBM, _originalScore: _originalScore)
            if nowPlayer == 1 {
                FourPlayerView?.PlayerScore.drawPlayerScore(1, _score: roundScore)
            }else if nowPlayer == 2{
                FourPlayerView?.Player2Score.drawPlayerScore(2, _score: roundScore)
            }else if nowPlayer == 3{
                FourPlayerView?.Player3Score.drawPlayerScore(3, _score: roundScore)
            }else{
                FourPlayerView?.Player4Score.drawPlayerScore(4, _score: roundScore)
            }
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
            
            break
        default:
            break
        }
    }
    
    func drawList(_score: Int){
        ThisRoundScoreArray.addObject(_score)
        TableView_Round.reloadData()
    }
    
    func refreshList(){
        ImageView_Round.drawRound(1, _now: round, _max: maxRound)
        TableView_Round.reloadData()
        let index = NSIndexPath(forRow: round - 1, inSection: 0)
        TableView_Round.scrollToRowAtIndexPath(index, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    func goMenu(){
        self.navigationController?.pushViewController((self.storyboard?.instantiateViewControllerWithIdentifier("Menu"))!, animated: false)
    }
    
    
    func maxRound1(){
        self.StopAnimation()
        switch playerCount {
        case 1:
            Winner.PlayerName.text = "Player 1"
            self.isWinner = true
            self.view.addSubview(self.Winner)
            NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(self.goMenu), userInfo: nil, repeats: false)
            break
        case 2:
            if P1.Score > P2.Score {
                Winner.PlayerName.text = "Player 1"
            }else{
                Winner.PlayerName.text = "Player 2"
            }
            self.isWinner = true
            self.view.addSubview(self.Winner)
            NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(self.goMenu), userInfo: nil, repeats: false)
            break
        case 3:
            if P1.Score > P2.Score && P1.Score > P3.Score {
                Winner.PlayerName.text = "Player 1"
            }else if P2.Score > P1.Score && P2.Score > P3.Score{
                Winner.PlayerName.text = "Player 2"
            }else{
                Winner.PlayerName.text = "Player 3"
            }
            self.isWinner = true
            self.view.addSubview(self.Winner)
            NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(self.goMenu), userInfo: nil, repeats: false)
            break
        case 4:
            if P1.Score > P2.Score && P1.Score > P3.Score && P1.Score > P4.Score {
                Winner.PlayerName.text = "Player 1"
            }else if P2.Score > P1.Score && P2.Score > P3.Score && P2.Score > P4.Score{
                Winner.PlayerName.text = "Player 2"
            }else if P3.Score > P1.Score && P3.Score > P2.Score && P3.Score > P4.Score{
                Winner.PlayerName.text = "Player 3"
            }else{
                Winner.PlayerName.text = "Player 4"
            }
            self.isWinner = true
            self.view.addSubview(self.Winner)
            NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(self.goMenu), userInfo: nil, repeats: false)
            break
        default:
            break
        }
    }
    
    func NextPlayer(){
        if round == maxRound && nowPlayer == playerCount {
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
        self.view.removeGestureRecognizer(nextPlayerTap)
        dartsHit = 1
        if isBust == true{}
        else {
            savePlayerScore(roundScore)
        }
        isBust = false
        isNext = false
        
        switch playerCount {
        case 1:
            saveRoundScore()
            nowPlayer = 1
            round += 1
            RemoveDartAnimation(true)
            self.ChangPlayerPressed(isBust)
            break
        case 2:
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
            break
        case 3:
            saveRoundScore()
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
            saveRoundScore()
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
        //refreshList()
    }
    
    
    func LogicRun(str: String){
        if isWinner == false{
            if str == "70" {
                
                if isNextFinish == true{
                    if dartsHit <= 4 {
                        dartIsThree = false
                    }
                }else{
                    self.StopAnimation()
                }
                NextPlayer()
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
        
        logic.Logic_CountUp(roundScore, hitScore: str, _p: tempPlayer) { (_score, _originalScore, _SDTBM, _status, _video) in
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
                //print("\(self.roundScore1) \(self.roundScore2) \(self.roundScore3)")
                self.dartsHit += 1
                if self.dartsHit == 4 {
                    if self.round == self.maxRound && self.nowPlayer == self.playerCount {
                        self.maxRound1()
                    }else{
                        self.isNext = true
                        self.view.addGestureRecognizer(self.nextPlayerTap)
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
                NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(self.goMenu), userInfo: nil, repeats: false)
                break
            default:
                break
            }
            self.drawScore(self.round, _nPlayer: self.nowPlayer, _dart: self.dartsHit, _SDTBM: _SDTBM, _originalScore: _originalScore)
        }
        
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
            print("total = \(total)")
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

}
