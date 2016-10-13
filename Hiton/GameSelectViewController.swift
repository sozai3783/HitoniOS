
//
//  GameSelectViewController.swift
//  Hiton
//
//  Created by yao on 01/04/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class GameSelectViewController: UIViewController, QBChatDelegate {
    @IBOutlet var settingMarginRightConstraint: NSLayoutConstraint!
    @IBOutlet var bottomBarImageView: UIImageView!
    @IBOutlet var Button_setting: UIButton!
    @IBOutlet var Button_Profile: UIButton!
    
    @IBOutlet var View_BG: UIView!
    
    
    @IBOutlet var ImageView_Bluetooth: UIImageView!
    
    
    @IBOutlet var ImageView_LeftOption: UIImageView!
    @IBOutlet var ImageView_LeftText: UIImageView!
    
    @IBOutlet var ImageView_RightOption: UIImageView!
    @IBOutlet var ImageView_RightText: UIImageView!
    @IBOutlet var ImageView_ComingSoon: UIImageView!
    
    @IBOutlet var Button_RightOption: UIButton!
    @IBOutlet var Button_LeftOption: UIButton!
    
    @IBOutlet var ImageView_MiddleText: UIImageView!
    @IBOutlet var View_SelectMode: UIView!
    var View_vs: View_GameVS!
    var View_01: View_Game01!
    var View_cr: View_GameCR!
    var View_match: View_GameMatch!
    var View_fun: View_GameFun!
    var View_pr: View_GamePR!
    
    var background_VS: BG_VS!
    var background_01: BG_Game01!
    var background_CR: BG_CR!
    var background_Practice: BG_Practice!
    var background_Fun: BG_FunGame!
    
    var Select_VS: View_Select_VS!
    var Select_01: View_Select_01!
    var Select_CR: View_Select_CR!
    var Select_Practice: View_Select_Practice!
    var Select_Fun: View_Select_Fun!
    
    //var SelectPlayer_Game01: Game01_SelectPlayer!
    var View_SelectPlayer: SelectPlayerView!
    
    var circleTimer: NSTimer!
    
    var selectTap: UITapGestureRecognizer!
    
    var leftSwipe:UISwipeGestureRecognizer!
    var rightSwipe:UISwipeGestureRecognizer!

    let selectArray: [String] = ["Vs mode", "01 Game", "Cricket", "Practice", "Fun", "Match"]
    let middleImageArray: [String] = ["vs_middle_text", "01_middle_text", "cr_middle_text", "pr_middle_text", "fun_middle_text", "match_middle_text"]
    let optionImageArray: [String] = ["vs small", "01 small", "cr small", "practice small", "fun small", "match small"]
    let optionTextArray: [String] = ["text_vs", "text_01", "text_cricket", "text_practice", "text_fun", "text_match"]
    let bgImageArray: [String] = ["BG_VS", "BG_01", "BG_CR", "BG_Practice", "BG_Fun", ""]
    
    var GameMode = 1
    var GameMode_SubMode = 0
        
    var playerCount = 0
    
    var selectEnable: Bool!
    var isSelect: Bool!
    
    
    
    let userInfo = UserClass.sharedInstance
    let bluetooth = HitonBluetoothClass.sharedInstance
    
    var audio = AudioClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //bluetooth.startScan()
        
        //userInfo.checkID()
        
        bluetooth.connectSuccess = {
            Void in
            self.ImageView_Bluetooth.image = UIImage(named: "Menu_Bluetooth_On")
            //self.bluetooth.readUnitCode()
        }
        
        bluetooth.isReady = {
            Void in
            //self.bluetooth.readUnitCode()
        }
        
        bluetooth.connectFail = {
            Void in
            self.ImageView_Bluetooth.image = UIImage(named: "Menu_Bluetooth_Off")
        }
        
        bluetooth.disconnect = {
            Void in
            self.ImageView_Bluetooth.image = UIImage(named: "Menu_Bluetooth_Off")
        }
        
               
        settingMarginRightConstraint.constant = Button_Profile.frame.size.width/2 - 2
        self.view.layoutIfNeeded()
        
        
        selectTap = UITapGestureRecognizer(target: self, action: #selector(GameSelectViewController.selectTap(_:)))

        selectEnable = false
        isSelect = false
        setupSelectPlayerView()
        setupSwipe()
        setupView()
        setupBG()
        setupSelectView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "PlayerMatch" {
            let nextScene =  segue.destinationViewController as! PlayerMatchViewController
            nextScene.playerCount = playerCount
            nextScene.GameMode = GameMode
            nextScene.GameMode_SubMode = GameMode_SubMode

            nextScene.PressedBack = {
                Void in
                self.background_01.startAnimation()
                //self.SelectPlayer_Game01.startAnimation()
                
            }
        }else if segue.identifier == "VSMode"{
            let nextScene =  segue.destinationViewController as! GameLobbyViewController
            nextScene.GameMode = sender as! Int
        }
    }

    
    func setupView(){
        View_01 = NSBundle.mainBundle().loadNibNamed("View_Game01", owner: self, options: nil).last as? View_Game01
        View_01!.frame = CGRectMake(0, 0, View_SelectMode.frame.size.width, View_SelectMode.frame.size.height)

        View_cr = NSBundle.mainBundle().loadNibNamed("View_GameCR", owner: self, options: nil).last as? View_GameCR
        View_cr!.frame = CGRectMake(0, 0, View_SelectMode.frame.size.width, View_SelectMode.frame.size.height)
        
        View_vs = NSBundle.mainBundle().loadNibNamed("View_GameVS", owner: self, options: nil).last as? View_GameVS
        View_vs!.frame = CGRectMake(0, 0, View_SelectMode.frame.size.width, View_SelectMode.frame.size.height)
        
        View_match = NSBundle.mainBundle().loadNibNamed("View_GameMatch", owner: self, options: nil).last as? View_GameMatch
        View_match!.frame = CGRectMake(0, 0, View_SelectMode.frame.size.width, View_SelectMode.frame.size.height)
        
        View_fun = NSBundle.mainBundle().loadNibNamed("View_GameFun", owner: self, options: nil).last as? View_GameFun
        View_fun!.frame = CGRectMake(0, 0, View_SelectMode.frame.size.width, View_SelectMode.frame.size.height)
        
        View_pr = NSBundle.mainBundle().loadNibNamed("View_GamePR", owner: self, options: nil).last as? View_GamePR
        View_pr!.frame = CGRectMake(0, 0, View_SelectMode.frame.size.width, View_SelectMode.frame.size.height)
        
        changeImage()
    }
    
    func setupBG(){
        background_VS = NSBundle.mainBundle().loadNibNamed("BG_VS", owner: self, options: nil).last as? BG_VS
        background_VS!.frame = self.view.bounds
        
        background_01 = NSBundle.mainBundle().loadNibNamed("BG_Game01", owner: self, options: nil).last as? BG_Game01
        background_01!.frame = self.view.bounds
        background_01.setup()
        
        background_CR = NSBundle.mainBundle().loadNibNamed("BG_CR", owner: self, options: nil).last as? BG_CR
        background_CR!.frame = self.view.bounds
        background_CR.setup()
        
        background_Practice = NSBundle.mainBundle().loadNibNamed("BG_Practice", owner: self, options: nil).last as? BG_Practice
        background_Practice!.frame = self.view.bounds
        background_Practice.setup()
        
        background_Fun = NSBundle.mainBundle().loadNibNamed("BG_FunGame", owner: self, options: nil).last as? BG_FunGame
        background_Fun!.frame = self.view.bounds
        background_Fun.setup()
        
    }
    
    func setupSelectView(){
        Select_VS = NSBundle.mainBundle().loadNibNamed("View_Select_VS", owner: self, options: nil).last as? View_Select_VS
        Select_VS!.frame = self.view.bounds
        Select_VS.viewSetup()
        Select_VS.playerPressedBack = {
            Void in
            self.audio.BackPlay()
            self.Button_LeftOption.enabled = true
            self.Button_RightOption.enabled = true
            self.view.addGestureRecognizer(self.leftSwipe)
            self.view.addGestureRecognizer(self.rightSwipe)
            self.view.addGestureRecognizer(self.selectTap)
        }
        Select_VS.playerPressedSelect = {
            (mode) -> Void in
            self.performSegueWithIdentifier("VSMode", sender: mode)
        }
        
        Select_01 = NSBundle.mainBundle().loadNibNamed("View_Select_01", owner: self, options: nil).last as? View_Select_01
        Select_01!.frame = self.view.bounds
        Select_01.viewSetup()
        Select_01.playerPressedBack = {
            Void in
            self.audio.BackPlay()
            self.Button_LeftOption.enabled = true
            self.Button_RightOption.enabled = true
            self.view.addGestureRecognizer(self.leftSwipe)
            self.view.addGestureRecognizer(self.rightSwipe)
            self.view.addGestureRecognizer(self.selectTap)
        }
        Select_01.playerPressedSelect = {
            (tempMode) -> Void in
            self.audio.SelectPlay()
            self.GameMode_SubMode = tempMode
            //self.view.addSubview(self.SelectPlayer_Game01)
            //self.SelectPlayer_Game01.startAnimation()
            self.View_SelectPlayer.startAnimation(1)
            self.view.addSubview(self.View_SelectPlayer)
        }
        
        Select_CR = NSBundle.mainBundle().loadNibNamed("View_Select_CR", owner: self, options: nil).last as? View_Select_CR
        Select_CR!.frame = self.view.bounds
//        Select_CR.viewSetup(background_CR.ImageView_GameMode)
        Select_CR.viewSetup()
        Select_CR.playerPressedBack = {
            Void in
            self.audio.BackPlay()
            self.Button_LeftOption.enabled = true
            self.Button_RightOption.enabled = true
            
            self.view.addGestureRecognizer(self.leftSwipe)
            self.view.addGestureRecognizer(self.rightSwipe)
            self.view.addGestureRecognizer(self.selectTap)
        }
        Select_CR.playerPressedSelect = {
            (tempMode) -> Void in
            if tempMode == 1 {
                self.View_SelectPlayer.Button_1P.hidden = true
                self.View_SelectPlayer.Button_2P.hidden = true
            }else{
                self.View_SelectPlayer.Button_1P.hidden = false
                self.View_SelectPlayer.Button_2P.hidden = false
            }
            self.GameMode_SubMode = tempMode
            self.audio.SelectPlay()
            self.View_SelectPlayer.startAnimation(2)
            self.view.addSubview(self.View_SelectPlayer)
        }
        
        Select_Practice = NSBundle.mainBundle().loadNibNamed("View_Select_Practice", owner: self, options: nil).last as? View_Select_Practice
        Select_Practice!.frame = self.view.bounds
//        Select_Practice.viewSetup(background_Practice.ImageView_GameMode)
        Select_Practice.viewSetup()
        Select_Practice.playerPressedBack = {
            Void in
            self.audio.BackPlay()
            self.Button_LeftOption.enabled = true
            self.Button_RightOption.enabled = true
            
            self.view.addGestureRecognizer(self.leftSwipe)
            self.view.addGestureRecognizer(self.rightSwipe)
            self.view.addGestureRecognizer(self.selectTap)
        }
        Select_Practice.playerPressedSelect = {
            (tempMode) -> Void in
            self.GameMode_SubMode = tempMode
            self.audio.SelectPlay()
            self.View_SelectPlayer.startAnimation(3)
            self.view.addSubview(self.View_SelectPlayer)
        }

        
        Select_Fun = NSBundle.mainBundle().loadNibNamed("View_Select_Fun", owner: self, options: nil).last as? View_Select_Fun
        Select_Fun!.frame = self.view.bounds
//        Select_Fun.viewSetup(background_Fun.ImageView_GameMode)
        Select_Fun.viewSetup()
        Select_Fun.playerPressedBack = {
            Void in
            self.audio.BackPlay()
            self.Button_LeftOption.enabled = true
            self.Button_RightOption.enabled = true
            
            self.view.addGestureRecognizer(self.leftSwipe)
            self.view.addGestureRecognizer(self.rightSwipe)
            self.view.addGestureRecognizer(self.selectTap)
        }
        Select_Fun.playerPressedSelect = {
            (tempMode) -> Void in
            self.GameMode_SubMode = tempMode
            if tempMode == 1 {
                self.View_SelectPlayer.Button_1P.hidden = true
            }else{
                self.View_SelectPlayer.Button_1P.hidden = false
            }
            self.audio.SelectPlay()
            self.View_SelectPlayer.startAnimation(4)
            self.view.addSubview(self.View_SelectPlayer)
        }

    }
    
    func setupSwipe(){
        leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(GameSelectViewController.handleSwipes(_:)))
        rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(GameSelectViewController.handleSwipes(_:)))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    func setupSelectPlayerView(){
        View_SelectPlayer = NSBundle.mainBundle().loadNibNamed("SelectPlayerView", owner: self, options: nil).last as? SelectPlayerView
        View_SelectPlayer.frame = self.view.bounds
        View_SelectPlayer.setup()
        View_SelectPlayer.PressedBack = {
            Void in
            self.audio.BackPlay()
        }
        View_SelectPlayer.PressedSelect = {
            (count) -> Void in
            self.playerCount = count
            let v = UIView(frame: self.view.bounds)
            v.backgroundColor = UIColor.clearColor()
            self.view.addSubview(v)
            UIView.animateWithDuration(0.5, animations: {
                v.backgroundColor = UIColor.blackColor()
                }, completion: { (bool) in
                    self.performSegueWithIdentifier("PlayerMatch", sender: nil)
                    v.removeFromSuperview()
            })
        }
    }
    
    //Handle Function
    //--------------------------------------------------------------------------------------
    func handleSwipes(sender: UISwipeGestureRecognizer) {
        audio.SlidePlay()
        if (sender.direction == .Left) {
            if GameMode == selectArray.count - 1{
                GameMode = 0
            }else{
                GameMode += 1
            }
        }
        
        if (sender.direction == .Right) {
            if GameMode == 0{
                GameMode = selectArray.count - 1
            }else{
                
                GameMode -= 1
            }
        }
        changeImage()
    }
   
    //---------------------------------------------------------------------------
    func changeImage(){
        self.view.removeGestureRecognizer(leftSwipe)
        self.view.removeGestureRecognizer(rightSwipe)
        if circleTimer != nil{
            circleTimer.invalidate()
        }
        
        hideBG()
        UIView.animateWithDuration(0.3, animations: {
            self.ImageView_LeftOption.alpha = 0
            self.ImageView_RightOption.alpha = 0
            
            self.ImageView_LeftText.alpha = 0
            self.ImageView_RightText.alpha = 0
            
            self.View_SelectMode.alpha = 0
            self.ImageView_MiddleText.alpha = 0
            
        }) { (bool) in
            for subview in self.View_SelectMode.subviews{
                if subview is UIView{
                    subview.removeFromSuperview()
                }
            }
            self.view.removeGestureRecognizer(self.selectTap)
            switch self.GameMode{
            case 0:
                self.View_SelectMode.addSubview(self.View_vs)
                self.View_vs.startAnimation()
                break
            case 1:
                self.View_SelectMode.addSubview(self.View_01)
                self.View_01.startAnimation()
                self.View_cr.removeAnimation()
                self.View_vs.removeAnimation()
                break
            case 2:
                self.View_SelectMode.addSubview(self.View_cr)
                self.View_cr.startAnimation()
                self.View_01.removeAnimation()
                self.View_pr.removeAnimation()
                break
            case 3:
                self.View_SelectMode.addSubview(self.View_pr)
                self.View_pr.startAnimation()
                self.View_cr.removeAnimation()
                self.View_fun.removeAnimation()
                break
            case 4:
                self.View_SelectMode.addSubview(self.View_fun)
                self.View_fun.startAnimation()
                self.View_pr.removeAnimation()
                break
            case 5:
                self.View_SelectMode.addSubview(self.View_match)
                self.View_vs.removeAnimation()
                break
            default:
                break
            }
            
            for subview in self.View_SelectMode.subviews{
                if subview is UIView {
                    subview.alpha = 1
                }
            }
            
            self.ImageView_MiddleText.image = UIImage(named: self.middleImageArray[self.GameMode])
            
            if self.GameMode == 0 {
                self.ImageView_LeftOption.image = UIImage(named: self.optionImageArray[self.optionImageArray.count-1])
                self.ImageView_LeftText.image = UIImage(named: self.optionTextArray[self.optionImageArray.count-1])
            }else{
                self.ImageView_LeftOption.image = UIImage(named: self.optionImageArray[self.GameMode - 1])
                self.ImageView_LeftText.image = UIImage(named: self.optionTextArray[self.GameMode - 1])
            }
            
            if self.GameMode == self.optionImageArray.count - 1{
                self.ImageView_RightOption.image = UIImage(named: self.optionImageArray[0])
                self.ImageView_RightText.image = UIImage(named: self.optionTextArray[0])
            }else{
                self.ImageView_RightOption.image = UIImage(named: self.optionImageArray[self.GameMode + 1])
                self.ImageView_RightText.image = UIImage(named:  self.optionTextArray[self.GameMode + 1])
            }
                UIView.animateWithDuration(0.2, animations: {
                    self.ImageView_LeftOption.alpha = 1
                    self.ImageView_RightOption.alpha = 1
                    self.ImageView_LeftText.alpha = 1
                    self.ImageView_RightText.alpha = 1
                    self.View_SelectMode.alpha = 1
                    self.ImageView_MiddleText.alpha = 1
                }) { (bool) in
                    self.Button_LeftOption.enabled = true
                    self.Button_RightOption.enabled = true
                    
                    self.view.addGestureRecognizer(self.leftSwipe)
                    self.view.addGestureRecognizer(self.rightSwipe)
                    
                    if self.bgImageArray[self.GameMode] != "" {
                        self.circleTimer = NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: #selector(GameSelectViewController.showBG), userInfo: nil, repeats: false)
                    }else{
                        self.ImageView_ComingSoon.hidden = false
                    }
                }
        }
    }
    
    func showBG(){
        self.view.addGestureRecognizer(selectTap)
        selectEnable = true
        
        switch GameMode {
        case 0:
            View_BG.addSubview(background_VS)
            background_VS.startAnimation()
            break
        case 1:
            background_01.startAnimation()
            View_BG.addSubview(background_01)
            break
        case 2:
            View_BG.addSubview(background_CR)
            break
        case 3:
            View_BG.addSubview(background_Practice)
            break
        case 4:
            View_BG.addSubview(background_Fun)
            break
        default:
            break
        }
        
        UIView.animateWithDuration(0.4, animations: {
            for subview in self.View_SelectMode.subviews{
                if subview is UIView{
                    subview.alpha = 0
                }
            }
            self.ImageView_MiddleText.alpha = 0
            self.View_BG.alpha = 1
        }) { (bool) in
            for subview in self.View_SelectMode.subviews{
                if subview is UIView{
                    subview.removeFromSuperview()
                }
            }
        }
    }
    
    func hideBG(){
        selectEnable = false
        ImageView_ComingSoon.hidden = true
        self.view.removeGestureRecognizer(selectTap)
        UIView.animateWithDuration(0.2, animations: {
            self.View_BG.alpha = 0
            
        }) { (bool) in
            for subview in self.View_BG.subviews{
                if subview is UIView{
                    subview.removeFromSuperview()
                }
            }
        }
    }
    
    func selectTap(sender: UITapGestureRecognizer? = nil) {
        audio.SelectPlay()
        
        Button_LeftOption.enabled = false
        Button_RightOption.enabled = false
        
        self.view.removeGestureRecognizer(leftSwipe)
        self.view.removeGestureRecognizer(rightSwipe)
        
        self.view.removeGestureRecognizer(selectTap)
        

        switch GameMode {
        case 0:
            self.view.addSubview(Select_VS)
            Select_VS.startAnimation()
            break
        case 1:
            self.view.addSubview(Select_01)
            Select_01.startAnimation()
            break
        case 2:
            self.view.addSubview(Select_CR)
            Select_CR.startAnimation()
            break
        case 3:
            self.view.addSubview(Select_Practice)
            Select_Practice.startAnimation()
            break
        case 4:
            self.view.addSubview(Select_Fun)
            Select_Fun.startAnimation()
            break
        default:
            break
        }
    }
    
    //Button pressed
    //-------------------------------------------------
    @IBAction func LeftOptionPressed(sender: AnyObject) {
        Button_LeftOption.enabled = false
        if GameMode == 0{
            GameMode = selectArray.count - 1
        }else{
            
            GameMode -= 1
        }
        changeImage()
    }

    @IBAction func RightOptionPressed(sender: AnyObject) {
        Button_RightOption.enabled = false
        if GameMode == selectArray.count - 1{
            GameMode = 0
        }else{
            GameMode += 1
        }
        changeImage()
    }
    
    @IBAction func profilePressed(sender: AnyObject) {
        self.navigationController?.pushViewController((self.storyboard?.instantiateViewControllerWithIdentifier("profile"))!, animated: false)
    }
}
