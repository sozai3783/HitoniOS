//
//  ShowRound.swift
//  Hiton
//
//  Created by yao on 26/04/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class ShowRound: UIView {

    @IBOutlet var BG: UIView!
    @IBOutlet var Human: UIImageView!
    @IBOutlet var Dart: UIImageView!
    @IBOutlet var Round: UIImageView!
    
    @IBOutlet var HumanLeftConstraint: NSLayoutConstraint!
    
    @IBOutlet var DartRightConstraint: NSLayoutConstraint!
    
    
    var AnimationEnd: (() -> Void)?
    
    var audio = AudioClass.sharedInstance
    
    var timer2: NSTimer!
    var timer3: NSTimer!
    var isSkip = false
    
    func setup(){
        
        BG.alpha = 0
        Human.alpha = 0
        
        DartRightConstraint.constant = self.frame.width
        self.layoutIfNeeded()
    }
    
    func show(round: Int){
        isSkip = false
        audio.RoundPlay()
        if round == 15 {
            Round.image = UIImage(named: "ShowRound_FinalRound")
        }else{
            Round.image = UIImage(named: "ShowRound_R\(round)")
        }
        UIView.animateWithDuration(0.5, animations: {
            self.BG.alpha = 0.2
            self.Human.alpha = 1
            }) { (bool) in
                self.timer2 = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(ShowRound.show2), userInfo: nil, repeats: false)
        }
    }
    
    func show2(){
        DartRightConstraint.constant = 10
        UIView.animateWithDuration(0.2, animations: {
            self.layoutIfNeeded()
            }) { (bool) in
                self.timer3 = NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: #selector(ShowRound.show3), userInfo: nil, repeats: false)
                
        }
    }
    
    func show3(){
        DartRightConstraint.constant = -Dart.frame.size.width
        UIView.animateWithDuration(0.2, animations: {
            self.layoutIfNeeded()
        }) { (bool) in
            self.removeFromSuperview()
            self.setup()
            if self.isSkip == false {
                if let callback = self.AnimationEnd {
                    callback()
                }
            }
            
        }
    }
    
    func stopAnimation(){
        isSkip = true
        if timer2 != nil{
            timer2.invalidate()
        }
        if timer3 != nil {
            timer3.invalidate()
        }
        self.removeFromSuperview()
        self.setup()
    }

}
