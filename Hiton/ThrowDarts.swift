//
//  ThrowDarts.swift
//  Hiton
//
//  Created by yao on 26/04/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class ThrowDarts: UIView {

    @IBOutlet var BG: UIView!
    @IBOutlet var Human: UIImageView!
    @IBOutlet var PlayerName: UILabel!
    @IBOutlet var DartLeftConstraint: NSLayoutConstraint!
    
    var audio = AudioClass.sharedInstance
    
    var isSkip = false

    var timer2: NSTimer!
    var timer3: NSTimer!
    
    var PressedBack: (() -> Void)?
    var AnimationEnd: (() -> Void)?
    
    func setup(){
        Human.alpha = 0
        BG.alpha = 0.2
        
        DartLeftConstraint.constant = self.frame.size.width
        self.layoutIfNeeded()
    }
    
    func show(_player: Int){
        isSkip = false
        audio.ThrowDartPlay()
        PlayerName.text = "Player \(_player)"
        UIView.animateWithDuration(0.2, animations: {
            self.Human.alpha = 1
        }) { (bool) in
            self.timer2 = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: #selector(ThrowDarts.show2), userInfo: nil, repeats: false)
        }
    }
    
    
    func show2(){
        DartLeftConstraint.constant = 10
        UIView.animateWithDuration(0.2, animations: {
            self.layoutIfNeeded()
        }) { (bool) in
            self.timer3 = NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: #selector(ThrowDarts.show3), userInfo: nil, repeats: false)
        }
    }
    
    func show3(){
        DartLeftConstraint.constant = -self.frame.size.width
        UIView.animateWithDuration(0.2, animations: {
            self.layoutIfNeeded()
        }) { (bool) in
            if self.isSkip == false {
                if let callback = self.AnimationEnd {
                    callback()
                }
            }
            self.removeFromSuperview()
            self.setup()
        }
    }

    func stopAnimation(){
        isSkip = true
        if timer2 != nil {
            timer2.invalidate()
        }
        if timer3 != nil {
            timer3.invalidate()
        }
        self.removeFromSuperview()
        self.setup()
    }
}
