
//
//  View_Select_01.swift
//  Hiton
//
//  Created by yao on 07/04/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class View_Select_01: UIView {

    @IBOutlet var ImageView_MiddleFrame: UIImageView!
    
    //@IBOutlet var Button_SelectPlayer: UIButton!
    @IBOutlet var Button_Back: UIButton!
    
    @IBOutlet var ImageView_GamePic: UIImageView!
    
    
    @IBOutlet var ImageView_TopFrame: UIImageView!
    @IBOutlet var ImageView_SelectGame: UIImageView!
    
    @IBOutlet var ImageView_Back: UIImageView!
    
    
    var leftSwipe:UISwipeGestureRecognizer!
    var rightSwipe:UISwipeGestureRecognizer!
    
    var selectTap: UITapGestureRecognizer!
    var doubleTap: UITapGestureRecognizer!
    
    var selectMode = 1

    @IBOutlet var topFrameYConstraint: NSLayoutConstraint!
    @IBOutlet var botFrameYConstraint: NSLayoutConstraint!
    
    @IBOutlet var Button_LeftFrame: UIButton!
    @IBOutlet var Button_RightFrame: UIButton!
    @IBOutlet var leftFrameXConstraint: NSLayoutConstraint!
    @IBOutlet var rightFrameXConstraint: NSLayoutConstraint!
    @IBOutlet var ImageView_Left: UIImageView!
    @IBOutlet var ImageView_Right: UIImageView!
    var playerPressedBack: (() -> Void)?
    var playerPressedSelect: ((selectedMode: Int) -> Void)?
    
    let left01ModeArray: [String] = ["Select_01_Left_301", "Select_01_Left_501", "Select_01_Left_701", "Select_01_Left_901", "Select_01_Left_1101", "Select_01_Left_1501"]
    let right01ModeArray: [String] = ["Select_01_Right_301", "Select_01_Right_501", "Select_01_Right_701", "Select_01_Right_901", "Select_01_Right_1101","Select_01_Right_1501"]

    let gameModeArray: [String] = ["Select_01_301", "Select_01_501", "Select_01_701", "Select_01_901", "Select_01_1101","Select_01_1501"]
    
    let middleImageArray: [String] = ["GamePic_301", "GamePic_501", "GamePic_701", "GamePic_901", "GamePic_1101", "GamePic_1501"]
    
    //var ImageView_GameMode: UIImageView!
    
    var audio = AudioClass()
    
   
    func viewSetup(){
        //ImageView_GameMode = img
        //ImageView_GameMode.hidden = true
        //ImageView_GameMode.image = UIImage(named: gameModeArray[selectMode])
        ImageView_SelectGame.image = UIImage(named: gameModeArray[selectMode])
        ImageView_GamePic.image = UIImage(named: middleImageArray[selectMode])
        
        ImageView_GamePic.GamePicInit()
        
        leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(GameSelectViewController.handleSwipes(_:)))
        rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(GameSelectViewController.handleSwipes(_:)))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        self.addGestureRecognizer(leftSwipe)
        self.addGestureRecognizer(rightSwipe)
        
        selectTap = UITapGestureRecognizer(target: self, action: #selector(View_Select_01.selectTap(_:)))
        self.addGestureRecognizer(selectTap)
        
        
        ImageView_MiddleFrame.alpha = 0
        ImageView_GamePic.alpha = 0
        
        topFrameYConstraint.constant = -ImageView_TopFrame.bounds.size.height
        botFrameYConstraint.constant = -Button_Back.bounds.size.height
        
        leftFrameXConstraint.constant = -Button_LeftFrame.bounds.size.width
        rightFrameXConstraint.constant = -Button_RightFrame.bounds.size.width
        
        self.layoutIfNeeded()
        return
    }
    
    func dTap(sender: UITapGestureRecognizer? = nil){
        //do nothing...
    }
    
    func startAnimation(){
        //ImageView_GameMode.alpha = 0
        //ImageView_GameMode.hidden = false
        
        ImageView_TopFrame.alpha = 0
        ImageView_SelectGame.alpha = 0
        ImageView_SelectGame.alpha = 0
        Button_Back.alpha = 0
        
        topFrameYConstraint.constant = 0
        botFrameYConstraint.constant = 0
        
        leftFrameXConstraint.constant = 0
        rightFrameXConstraint.constant = 0
        UIView.animateWithDuration(0.2, animations: {
            self.ImageView_MiddleFrame.alpha = 1
            self.ImageView_GamePic.alpha = 1
            //self.ImageView_GameMode.alpha = 1
            
            self.ImageView_TopFrame.alpha = 1
            self.ImageView_SelectGame.alpha = 1
            self.ImageView_SelectGame.alpha = 1
            self.Button_Back.alpha = 1
            self.layoutIfNeeded()
            }) { (bool) in
                //self.ImageView_GamePic.GamePicAnimation()
        }
    }
    
    func selectTap(sender: UITapGestureRecognizer? = nil){
        if let callback = self.playerPressedSelect{
            callback(selectedMode: selectMode)
        }
    }
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        audio.SlidePlay()
        if (sender.direction == .Left) {
            if selectMode == left01ModeArray.count - 1{
                selectMode = 0
            }else{
                selectMode += 1
            }
            moveLeft()
        }
        
        if (sender.direction == .Right) {
            if selectMode == 0{
                selectMode = left01ModeArray.count - 1
            }else{
                selectMode -= 1
            }
            moveRight()
        }
    }
    
    func GameViewAnimation(){
        ImageView_GamePic.image = UIImage(named: middleImageArray[selectMode])
        UIView.animateWithDuration(0.1, animations: { 
            //self.ImageView_GameMode.alpha = 0
            self.ImageView_SelectGame.alpha = 0
            }) { (bool) in
                //self.ImageView_GameMode.image = UIImage(named: self.gameModeArray[self.selectMode])
                self.ImageView_SelectGame.image = UIImage(named: self.gameModeArray[self.selectMode])
                UIView.animateWithDuration(0.1, animations: {
                    //self.ImageView_GameMode.alpha = 1
                    self.ImageView_SelectGame.alpha = 1
                }) { (bool) in
                    
                }
        }
        ImageView_GamePic.GamePicAnimation(){
            self.Button_RightFrame.userInteractionEnabled = true
            self.Button_LeftFrame.userInteractionEnabled = true
            
            self.Button_Back.userInteractionEnabled = true
            
            self.addGestureRecognizer(self.leftSwipe)
            self.addGestureRecognizer(self.rightSwipe)
            
            self.addGestureRecognizer(self.selectTap)
        }
    }
    
    func removeSlideFunc(){
        Button_RightFrame.userInteractionEnabled = false
        Button_LeftFrame.userInteractionEnabled = false
        
        Button_Back.userInteractionEnabled = false
        
        self.removeGestureRecognizer(leftSwipe)
        self.removeGestureRecognizer(rightSwipe)
        
        self.removeGestureRecognizer(selectTap)
    }
    
    func moveLeft(){
        removeSlideFunc()
        if selectMode == 0 {
            ImageView_Left.left_SlideLeft(UIImage(named: left01ModeArray[left01ModeArray.count - 1])!)
        }else{
            ImageView_Left.left_SlideLeft(UIImage(named: left01ModeArray[selectMode - 1])!)
        }
        
        if selectMode == right01ModeArray.count - 1 {
            ImageView_Right.right_SlideLeft(UIImage(named: right01ModeArray[0])!)
        }else{
            ImageView_Right.right_SlideLeft(UIImage(named: right01ModeArray[selectMode + 1])!)
        }
        GameViewAnimation()
    }
    
    func moveRight(){
        removeSlideFunc()
        if selectMode == 0 {
            ImageView_Left.left_SlideRight(UIImage(named: left01ModeArray[left01ModeArray.count - 1])!)
        }else{
            ImageView_Left.left_SlideRight(UIImage(named: left01ModeArray[selectMode - 1])!)
        }
        
        if selectMode == right01ModeArray.count - 1 {
            ImageView_Right.right_SlideRight(UIImage(named: right01ModeArray[0])!)
        }else{
            ImageView_Right.right_SlideRight(UIImage(named: right01ModeArray[selectMode + 1])!)
        }
        GameViewAnimation()
    }
    
    
    @IBAction func leftPressed(sender: AnyObject) {
        removeSlideFunc()
        if selectMode == 0 {
            selectMode = left01ModeArray.count - 1
        }else{
            selectMode -= 1
        }
        
        if selectMode == 0 {
            ImageView_Left.left_SlideRight(UIImage(named: left01ModeArray[left01ModeArray.count - 1])!)
        }else{
            ImageView_Left.left_SlideRight(UIImage(named: left01ModeArray[selectMode - 1])!)
        }
        
        
        if selectMode == right01ModeArray.count - 1 {
            ImageView_Right.right_SlideRight(UIImage(named: right01ModeArray[0])!)
        }else{
            ImageView_Right.right_SlideRight(UIImage(named: right01ModeArray[selectMode + 1])!)
        }
        GameViewAnimation()
    }
    
    @IBAction func rightPressed(sender: AnyObject) {
        removeSlideFunc()
        if selectMode == left01ModeArray.count - 1 {
            selectMode = 0
        }else{
            selectMode += 1
        }
        
        if selectMode == 0 {
            ImageView_Left.left_SlideLeft(UIImage(named: left01ModeArray[left01ModeArray.count - 1])!)
        }else{
            ImageView_Left.left_SlideLeft(UIImage(named: left01ModeArray[selectMode - 1])!)
        }
        
        if selectMode == right01ModeArray.count - 1 {
            ImageView_Right.right_SlideLeft(UIImage(named: right01ModeArray[0])!)
        }else{
            ImageView_Right.right_SlideLeft(UIImage(named: right01ModeArray[selectMode + 1])!)
        }
        GameViewAnimation()
        
    }

    @IBAction func backPressed(sender: AnyObject) {
        topFrameYConstraint.constant = -ImageView_TopFrame.bounds.size.height
        botFrameYConstraint.constant = -Button_Back.bounds.size.height
        
        
        leftFrameXConstraint.constant = -Button_LeftFrame.bounds.size.width
        rightFrameXConstraint.constant = -Button_RightFrame.bounds.size.width
        UIView.animateWithDuration(0.2, animations: {
            self.ImageView_MiddleFrame.alpha = 0
            self.ImageView_GamePic.alpha = 0
            //self.ImageView_GameMode.alpha = 0
            
            self.ImageView_TopFrame.alpha = 0
            self.ImageView_SelectGame.alpha = 0
            self.ImageView_SelectGame.alpha = 0
            self.Button_Back.alpha = 0
            self.layoutIfNeeded()
        }) { (bool) in
            //self.ImageView_GameMode.hidden = true
            //self.ImageView_GameMode.alpha = 1
            self.removeFromSuperview()
            if let callback = self.playerPressedBack{
                callback()
            }
        }
    }
}
