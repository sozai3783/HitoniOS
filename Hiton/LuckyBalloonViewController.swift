//
//  LuckyBalloonViewController.swift
//  Hiton
//
//  Created by yao on 12/08/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class LuckyBalloonViewController: UIViewController {
    
    
    @IBOutlet var Boom1: UIImageView!
    @IBOutlet var Boom: UIImageView!
    var BalloonScore = 0
    
    @IBOutlet var ImageView_CantChangePlayer: UIImageView!
    @IBOutlet var Ninja: UIImageView!
    @IBOutlet var Ninga_Left: NSLayoutConstraint!
    
    var RedAnimationIsRunning = false
    
    @IBOutlet var Balloon: UIImageView!
    @IBOutlet var Balloon_Top: NSLayoutConstraint!
    @IBOutlet var Balloon_Bottom: NSLayoutConstraint!
    @IBOutlet var Line: UIImageView!
    @IBOutlet var Line_Left: NSLayoutConstraint!
    @IBOutlet var Line_Right: NSLayoutConstraint!
    
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
    let maxRound = 9
    var dartsHit = 1
    
    var dartIsThree = false
    
    var isNext = false
    var isNextFinish = true
    var isBust = false
    var isWinner = false
    var isShowVideo = false
    
    var RoundScoreArray = NSMutableArray()
    
    var OnePlayerView: ScoreBar_1Player?
    var TwoPlayerView: LuckyBalloon_2Player?
    var ThreePlayerView: LuckyBalloon_3Player?
    var FourPlayerView: LuckyBalloon_4Player?
    
    
    
    @IBOutlet var ButtonOption: UIButton!
    
    @IBOutlet var View_PlayerChange: UIView!
    
    @IBOutlet var GameTitle: UIImageView!
    @IBOutlet var Avatar: UIImageView!
    
    
    @IBOutlet var ImageView_Dart1: UIImageView!
    @IBOutlet var ImageView_Dart2: UIImageView!
    @IBOutlet var ImageView_Dart3: UIImageView!
    
    @IBOutlet var RED: UIImageView!
    
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
        RED.alpha = 0
        ImageView_CantChangePlayer.alpha = 0
        
        Boom.hidden = true
        Boom1.hidden = true
        
        if playerCount == 2 {
            BalloonScore = Int(arc4random_uniform(100) + 250)
        }else if playerCount == 3 {
            BalloonScore = Int(arc4random_uniform(100) + 350)
        }else if playerCount == 4 {
            BalloonScore = Int(arc4random_uniform(100) + 450)
        }
        
        
        setupBG()
        self.Balloon.image = UIImage(named: "Balloon011")
        
        bluetooth.hit = {
            (str) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                self.LogicRun(str)
            })
        }
        
        setup()
        Balloon_Top.constant = (self.view.frame.size.height / 2)
        
        
        let tempFrame = Balloon.frame
        //print("1 = \(Balloon.frame)")
        let tempConstant = tempFrame.size.height
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = -M_1_PI/3
        rotationAnimation.toValue = M_1_PI/3
        rotationAnimation.duration = 2
        rotationAnimation.repeatCount = 1e100
        rotationAnimation.autoreverses = true
        let tempAnchorPoint = CGPointMake(0.5, 1)
        Balloon.layer.anchorPoint = tempAnchorPoint
        Balloon.layer.addAnimation(rotationAnimation, forKey: "transform.rotation.z")
        
    
        Balloon.frame = tempFrame
        
        Balloon_Bottom.constant -= ((tempConstant/2) + 20)
        
        
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
        setupPlayer()
        setupView()
        setupOption()
        
        setupLine()
        
        View_PlayerChange.alpha = 0
        View_PlayerChange.hidden = false
        
        nextPlayerTap = UITapGestureRecognizer(target: self, action: #selector(Game01_ViewController.NextPlayer))
    }
    
    func setupLine(){
        switch playerCount {
        case 1:
            break
        case 2:
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
        switch playerCount {
        case 1:
            break
        case 2:
            TwoPlayerView?.DrawLine(nowPlayer)
            break
        case 3:
            ThreePlayerView?.DrawLine(nowPlayer)
            break
        case 4:
            FourPlayerView?.DrawLine(nowPlayer)
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
            OnePlayerView = NSBundle.mainBundle().loadNibNamed("ScoreBar_1Player", owner: self, options: nil).last as? ScoreBar_1Player
            OnePlayerView?.frame = ScoreBar.bounds
            OnePlayerView!.setup(P1.Score)
            OnePlayerView?.hiddenScore()
            ScoreBar.addSubview(OnePlayerView!)
            break
        case 2:
            TwoPlayerView = NSBundle.mainBundle().loadNibNamed("LuckyBalloon_2Player", owner: self, options: nil).last as? LuckyBalloon_2Player
            TwoPlayerView?.frame = ScoreBar.bounds
            TwoPlayerView!.setup(P1.Score)
            TwoPlayerView?.hiddenScore()
            ScoreBar.addSubview(TwoPlayerView!)
            break
        case 3:
            ThreePlayerView = NSBundle.mainBundle().loadNibNamed("LuckyBalloon_3Player", owner: self, options: nil).last as? LuckyBalloon_3Player
            ThreePlayerView?.frame = ScoreBar.bounds
            ThreePlayerView!.setup(P1.Score)
            ThreePlayerView?.hiddenScore()
            ScoreBar.addSubview(ThreePlayerView!)
            break
        case 4:
            FourPlayerView = NSBundle.mainBundle().loadNibNamed("LuckyBalloon_4Player", owner: self, options: nil).last as? LuckyBalloon_4Player
            FourPlayerView?.frame = ScoreBar.bounds
            FourPlayerView!.setup(P1.Score)
            FourPlayerView?.hiddenScore()
            ScoreBar.addSubview(FourPlayerView!)
            break
        default:
            break
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
    
    /*func drawScore(_round: Int, _nPlayer: Int,_dart: Int, _SDTBM: String, _originalScore: Int){
        switch playerCount {
        case 1:
            OnePlayerView?.ImageView_Score.drawPlayerScore(1, _score: roundScore)
            break
        case 2:
            self.drawDartScore(self.dartsHit, _SDTBM: _SDTBM, _originalScore: _originalScore)
            if nowPlayer == 1 {
                TwoPlayerView?.PlayerScore.drawPlayerScore(1, _score: roundScore)
            }else{
                TwoPlayerView?.Player2Score.drawPlayerScore(2, _score: roundScore)
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
            break
        default:
            break
        }
    }*/
    
    func goWinner(){
        Winner.PlayerName.text = "Player \(nowPlayer)"
        self.view.addSubview(Winner)
        
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(self.goMenu), userInfo: nil, repeats: false)
    }

    
    func goMenu(){
        self.navigationController?.pushViewController((self.storyboard?.instantiateViewControllerWithIdentifier("Menu"))!, animated: false)
    }
    
    func NextPlayer(){
        if round == maxRound && nowPlayer == playerCount {
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
        saveRoundScore()
        isShowVideo = false
        dartIsThree = false
        StopAnimation()
        video.stopVideo()
        self.view.removeGestureRecognizer(nextPlayerTap)
        dartsHit = 1
        if isBust == true{
            
        }
        else {
        }
        isBust = false
        isNext = false
        
        switch playerCount {
        case 1:
            nowPlayer = 1
            round += 1
            RemoveDartAnimation(true)
            self.ChangPlayerPressed(isBust)
            break
        case 2:
            //saveRoundScore()
            if nowPlayer == 2 {
                nowPlayer = 1
                //roundScore = P1.Score
                round += 1
                RemoveDartAnimation(true)
            }else {
                nowPlayer = 2
                //roundScore = P2.Score
                RemoveDartAnimation(false)
            }
            self.ChangPlayerPressed(isBust)
            self.playerChangeColor(nowPlayer)
            break
        case 3:
            //saveRoundScore()
            if nowPlayer == 1 {
                nowPlayer = 2
                //roundScore = P2.Score
                RemoveDartAnimation(false)
            }else if nowPlayer == 2 {
                nowPlayer = 3
                //roundScore = P3.Score
                RemoveDartAnimation(false)
            }else {
                nowPlayer = 1
                //roundScore = P1.Score
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
                //roundScore = P2.Score
                RemoveDartAnimation(false)
            }else if nowPlayer == 2 {
                nowPlayer = 3
                //roundScore = P3.Score
                RemoveDartAnimation(false)
            }else if nowPlayer == 3 {
                nowPlayer = 4
                //roundScore = P4.Score
                RemoveDartAnimation(false)
            }else{
                nowPlayer = 1
                round += 1
                //roundScore = P1.Score
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
    
    func CantNextPlayerShow(){
            UIView.animateWithDuration(0.3, animations: {
                self.ImageView_CantChangePlayer.alpha = 1
            }) { (true) in
                UIView.animateWithDuration(0.2, animations: {
                    self.ImageView_CantChangePlayer.alpha = 0
                    }, completion: { (true) in
                        UIView.animateWithDuration(0.3, animations: {
                            self.ImageView_CantChangePlayer.alpha = 1
                        }) { (true) in
                            UIView.animateWithDuration(0.2, animations: {
                                self.ImageView_CantChangePlayer.alpha = 0
                                }, completion: { (true) in
                                    UIView.animateWithDuration(0.3, animations: {
                                        self.ImageView_CantChangePlayer.alpha = 1
                                    }) { (true) in
                                        UIView.animateWithDuration(0.2, animations: {
                                            self.ImageView_CantChangePlayer.alpha = 0
                                            }, completion: { (true) in
                                                
                                        })
                                    }
                            })
                        }
                })
            }
        
    }
    
    func LogicRun(str: String){
        if isWinner == false{
            if str == "70" {
                if isNext == true {
                    print("Go Next")
                    NextPlayer()
                }else{
                    print("Cant Next")
                    CantNextPlayerShow()
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
    
    func drawBalloon(_score: Int, animated: Bool){
        
       
        self.Balloon_Top.constant -= CGFloat(_score)
        
        
        let tempFrame = self.Balloon.frame
        let tempConstant = tempFrame.size.height
        self.Balloon_Bottom.constant = -((tempConstant/1.9) + CGFloat(_score))
        
        UIView.animateWithDuration(0.6, animations: { 
            self.view.layoutIfNeeded()
            }) { (true) in
                
        }
        
    }
    
    func REDStartAnimation(bool: Bool){
        if bool == true {
            UIView.animateWithDuration(0.6, animations: {
                self.RED.alpha = 1
            }) { (true) in
                UIView.animateWithDuration(0.4, animations: {
                    self.RED.alpha = 0.4
                    }, completion: { (true) in
                        self.REDStartAnimation(bool)
                })
            }
        }
    }
    
    func NinjaAnimation(animationMode: Int){
        switch animationMode {
        case 1:
            Ninga_Left.constant = 15
            UIView.animateWithDuration(0.1, animations: {
                self.view.layoutIfNeeded()
                }, completion: { (true) in
                    self.Ninga_Left.constant = 10
                    UIView.animateWithDuration(0.1, animations: {
                        self.view.layoutIfNeeded()
                        }, completion: { (true) in
                            self.Ninga_Left.constant = 15
                            UIView.animateWithDuration(0.1, animations: {
                                self.view.layoutIfNeeded()
                                }, completion: { (true) in
                                    self.Ninga_Left.constant = 10
                                    UIView.animateWithDuration(0.1, animations: {
                                        self.view.layoutIfNeeded()
                                        }, completion: { (true) in
                                            self.Ninga_Left.constant = 15
                                            UIView.animateWithDuration(0.1, animations: {
                                                self.view.layoutIfNeeded()
                                                }, completion: { (true) in
                                                    self.Ninga_Left.constant = 10
                                                    UIView.animateWithDuration(0.1, animations: {
                                                        self.view.layoutIfNeeded()
                                                        }, completion: { (true) in
                                                            
                                                    })
                                            })
                                    })
                            })
                    })
            })
            break
        case 2:
            Ninga_Left.constant = 15
            UIView.animateWithDuration(0.1, animations: {
                
                self.Ninja.image = UIImage(named: "YellowDontPOP")
                self.view.layoutIfNeeded()
                }, completion: { (true) in
                    self.Ninga_Left.constant = 10
                    UIView.animateWithDuration(0.1, animations: {
                        self.Ninja.image = UIImage(named: "YellowDontPOP01")
                        self.view.layoutIfNeeded()
                        }, completion: { (true) in
                            self.Ninga_Left.constant = 15
                            UIView.animateWithDuration(0.1, animations: {
                                self.Ninja.image = UIImage(named: "YellowDontPOP")
                                self.view.layoutIfNeeded()
                                }, completion: { (true) in
                                    self.Ninga_Left.constant = 10
                                    UIView.animateWithDuration(0.1, animations: {
                                        self.Ninja.image = UIImage(named: "YellowDontPOP01")
                                        self.view.layoutIfNeeded()
                                        }, completion: { (true) in
                                            self.Ninga_Left.constant = 15
                                            UIView.animateWithDuration(0.1, animations: {
                                                self.Ninja.image = UIImage(named: "YellowDontPOP")
                                                self.view.layoutIfNeeded()
                                                }, completion: { (true) in
                                                    self.Ninga_Left.constant = 10
                                                    UIView.animateWithDuration(0.1, animations: {
                                                        self.Ninja.image = UIImage(named: "YellowDontPOP01")
                                                        self.view.layoutIfNeeded()
                                                        }, completion: { (true) in
                                                            
                                                    })
                                            })
                                    })
                            })
                    })
            })
            break
        case 3:
            Ninga_Left.constant = 15
            UIView.animateWithDuration(0.1, animations: {
                self.Ninja.image = UIImage(named: "YellowDontPOP02")
                self.view.layoutIfNeeded()
                }, completion: { (true) in
                    self.Ninga_Left.constant = 10
                    UIView.animateWithDuration(0.1, animations: {
                        self.Ninja.image = UIImage(named: "YellowDontPOP")
                        self.view.layoutIfNeeded()
                        }, completion: { (true) in
                            self.Ninga_Left.constant = 15
                            UIView.animateWithDuration(0.1, animations: {
                                self.Ninja.image = UIImage(named: "YellowDontPOP02")
                                self.view.layoutIfNeeded()
                                }, completion: { (true) in
                                    self.Ninga_Left.constant = 10
                                    UIView.animateWithDuration(0.1, animations: {
                                        self.Ninja.image = UIImage(named: "YellowDontPOP")
                                        self.view.layoutIfNeeded()
                                        }, completion: { (true) in
                                            self.Ninga_Left.constant = 15
                                            UIView.animateWithDuration(0.1, animations: {
                                                self.Ninja.image = UIImage(named: "YellowDontPOP02")
                                                self.view.layoutIfNeeded()
                                                }, completion: { (true) in
                                                    self.Ninga_Left.constant = 10
                                                    UIView.animateWithDuration(0.1, animations: {
                                                        self.Ninja.image = UIImage(named: "YellowDontPOP")
                                                        self.view.layoutIfNeeded()
                                                        }, completion: { (true) in
                                                            
                                                    })
                                            })
                                    })
                            })
                    })
            })
            break
        case 4:
            Ninga_Left.constant = 15
            UIView.animateWithDuration(0.1, animations: {
                self.Ninja.image = UIImage(named: "YellowDontPOP")
                self.view.layoutIfNeeded()
                }, completion: { (true) in
                    self.Ninga_Left.constant = 10
                    UIView.animateWithDuration(0.1, animations: {
                        self.Ninja.image = UIImage(named: "YellowDontPOP02")
                        self.view.layoutIfNeeded()
                        }, completion: { (true) in
                            self.Ninga_Left.constant = 15
                            UIView.animateWithDuration(0.1, animations: {
                                self.Ninja.image = UIImage(named: "YellowDontPOP")
                                self.view.layoutIfNeeded()
                                }, completion: { (true) in
                                    self.Ninga_Left.constant = 10
                                    UIView.animateWithDuration(0.1, animations: {
                                        self.Ninja.image = UIImage(named: "YellowDontPOP02")
                                        self.view.layoutIfNeeded()
                                        }, completion: { (true) in
                                            self.Ninga_Left.constant = 15
                                            UIView.animateWithDuration(0.1, animations: {
                                                self.Ninja.image = UIImage(named: "YellowDontPOP")
                                                self.view.layoutIfNeeded()
                                                }, completion: { (true) in
                                                    self.Ninga_Left.constant = 10
                                                    UIView.animateWithDuration(0.1, animations: {
                                                        self.Ninja.image = UIImage(named: "YellowDontPOP02")
                                                        self.view.layoutIfNeeded()
                                                        }, completion: { (true) in
                                                            
                                                    })
                                            })
                                    })
                            })
                    })
            })
            break
        default:
            break
        }
    }
    
    
    func calScore(str: String){
        logic.Logic_Balloon(str) { (_score, _originalScore, _SDTBM) in
            self.roundScore += _score
            print(self.BalloonScore)
            if self.roundScore >= self.BalloonScore {
                print("BOOM")
                self.Balloon.hidden = true
                self.audio.HeartBeatStop()
                self.audio.BalloonBoomPlay()
                self.RED.hidden = true
                
                self.Boom.hidden = false
                self.Boom1.hidden = false
                self.isWinner = true
                
                self.Boom.GamePicAnimation({ 
                    
                })
                self.Boom1.GamePicAnimation({ 
                    
                })
                
                NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(self.goWinner), userInfo: nil, repeats: false)
                
            }else{
                print(_score)
                if _score >= 1 && _score <= 25 {
                    self.drawBalloon(5, animated: true)
                }else if _score > 25 && _score <= 50{
                    self.drawBalloon(10, animated: true)
                }else if _score > 50{
                    self.drawBalloon(15, animated: true)
                }else{
                    self.drawBalloon(0, animated: true)
                }
                
                
                let tempPercentage = (CGFloat(self.roundScore) / CGFloat(self.BalloonScore)) * 100
                print(tempPercentage)
                if tempPercentage >= 0 && tempPercentage < 30 {
                    self.Balloon.image = UIImage(named: "Balloon011")
                    self.NinjaAnimation(1)
                }else if tempPercentage >= 30 && tempPercentage < 45 {
                    self.Balloon.image = UIImage(named: "Balloon07")
                    self.NinjaAnimation(1)
                }else if tempPercentage >= 45 && tempPercentage < 60 {
                    self.Balloon.image = UIImage(named: "Balloon01")
                    self.NinjaAnimation(2)
                }else if tempPercentage >= 60 && tempPercentage < 80{
                    self.Balloon.image = UIImage(named: "Balloon0")
                    self.NinjaAnimation(3)
                }else if tempPercentage >= 80 && tempPercentage < 100{
                    self.Balloon.image = UIImage(named: "Balloon1")
                    self.NinjaAnimation(4)
                    if self.RedAnimationIsRunning == false {
                        self.REDStartAnimation(true)
                        self.RedAnimationIsRunning = true
                        self.audio.HeartBeatPlay()
                    }
                }else if tempPercentage >= 100{
                    
                }
                
                self.dartsHit += 1
                if self.dartsHit == 4 {
                    self.isNext = true
                    self.view.addGestureRecognizer(self.nextPlayerTap)
                    //self.savePlayerScore(_score)
                    self.showChangePlayer()
                    
                }else{
                    
                }
                self.drawDartScore(self.dartsHit, _SDTBM: _SDTBM, _originalScore: _originalScore)
            }
        }
        
        /*var tempPlayer: PlayerClass!
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
        
        logic.Logic_HalfIf(str, _round: round, _playerScore: roundScore) { (_score, _originalScore, _SDTBM, _status, _bust, _smile) in
            
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
                    }else{
                        self.isNext = true
                        self.view.addGestureRecognizer(self.nextPlayerTap)
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
        }*/
        
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
    
    /*func savePlayerScore(_score: Int){
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
    }*/
    
    func ChangePlayer(){
        if View_PlayerChange.alpha == 0 {
            UIView.animateWithDuration(0.3) {
                self.View_PlayerChange.alpha = 1
            }
        }
    }
    
    func ChangPlayerPressed( isBust: Bool){
        isNewRound = true
        UIView.animateWithDuration(0.3, animations: {
            self.View_PlayerChange.alpha = 0
        }) { (bool) in
            self.resetDartScore()
            
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
