//
//  SelectPlayerView.swift
//  Hiton
//
//  Created by yao on 17/06/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class SelectPlayerView: UIView {
    @IBOutlet var ImageView_BG: UIImageView!
    @IBOutlet var ImageView_Title: UIImageView!
    @IBOutlet var LogoView: UIView!
    
    @IBOutlet var Button_1P: UIButton!
    @IBOutlet var Button_2P: UIButton!
    @IBOutlet var Button_3P: UIButton!
    @IBOutlet var Button_4P: UIButton!
    
    
    @IBOutlet var RightTopConstraint: NSLayoutConstraint!
    @IBOutlet var RightBotConstraint: NSLayoutConstraint!
    
    var View_01: View_Game01!
    var View_CR: View_GameCR!
    var View_Practice: View_GamePR!
    var View_Fun: View_GameFun!
    
    
    var PressedBack: (() -> Void)?
    
    var PressedSelect: ((PlayerCount: Int) -> Void)?
    
    func setup(){
        
        
        ImageView_BG.alpha = 0
        //
        Button_1P.alpha = 0
        Button_2P.alpha = 0
        Button_3P.alpha = 0
        Button_4P.alpha = 0
        
        self.updateConstraintsIfNeeded()
        let tempTotal = RightTopConstraint.constant + RightBotConstraint.constant
        RightTopConstraint.constant = tempTotal / 2
        RightBotConstraint.constant = tempTotal / 2
        self.layoutIfNeeded()
        View_01 = NSBundle.mainBundle().loadNibNamed("View_Game01", owner: self, options: nil).last as? View_Game01
        View_01!.frame = CGRectMake(0, 0, LogoView.frame.size.width, LogoView.frame.size.height)
        
        View_CR = NSBundle.mainBundle().loadNibNamed("View_GameCR", owner: self, options: nil).last as? View_GameCR
        View_CR!.frame = CGRectMake(0, 0, LogoView.frame.size.width, LogoView.frame.size.height)
        
        View_Practice = NSBundle.mainBundle().loadNibNamed("View_GamePR", owner: self, options: nil).last as? View_GamePR
        View_Practice!.frame = CGRectMake(0, 0, LogoView.frame.size.width, LogoView.frame.size.height)
        
        View_Fun = NSBundle.mainBundle().loadNibNamed("View_GameFun", owner: self, options: nil).last as? View_GameFun
        View_Fun!.frame = CGRectMake(0, 0, LogoView.frame.size.width, LogoView.frame.size.height)
        return
    }
    
    func setLogo(tempMode: Int){
        
    }
    
    func startAnimation(tempMode: Int){
        switch tempMode {
        case 1:
            View_01.startAnimation()
            LogoView.addSubview(View_01)
            break
        case 2:
            View_CR.startAnimation()
            LogoView.addSubview(View_CR)
            break
        case 3:
            //View_Practice.startAnimation()
            LogoView.addSubview(View_Practice)
            break
        case 4:
            View_Fun.startAnimation()
            LogoView.addSubview(View_Fun)
            break
        default:
            break
        }
        
        UIView.animateWithDuration(0.4, animations: {
            self.ImageView_BG.alpha = 1
            
            self.ImageView_Title.alpha = 1
            
            self.LogoView.alpha = 1
            //
            self.Button_1P.alpha = 1
            self.Button_2P.alpha = 1
            self.Button_3P.alpha = 1
            self.Button_4P.alpha = 1
        }) { (bool) in
            
        }
    }
    
    @IBAction func BackPressed(sender: AnyObject) {
        if let callback = self.PressedBack {
            callback()
        }
        UIView.animateWithDuration(0.4, animations: {
            self.ImageView_BG.alpha = 0
            //
            
            self.View_01.alpha = 0
            
            self.Button_1P.alpha = 0
            self.Button_2P.alpha = 0
            self.Button_3P.alpha = 0
            self.Button_4P.alpha = 0
            
        }) { (bool) in
            self.ImageView_Title.alpha = 0
            self.View_01.removeFromSuperview()
            self.View_CR.removeFromSuperview()
            self.View_Fun.removeFromSuperview()
            self.View_Practice.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
    
    @IBAction func Pressed1P(sender: AnyObject) {
        if let callback = self.PressedSelect{
            callback(PlayerCount: 1)
        }
    }
    
    @IBAction func Pressed2P(sender: AnyObject) {
        if let callback = self.PressedSelect{
            callback(PlayerCount: 2)
        }
    }
    
    @IBAction func Pressed3P(sender: AnyObject) {
        if let callback = self.PressedSelect{
            callback(PlayerCount: 3)
        }
    }
    
    @IBAction func Pressed4P(sender: AnyObject) {
        if let callback = self.PressedSelect{
            callback(PlayerCount: 4)
        }
    }
}
