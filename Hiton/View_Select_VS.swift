





//
//  View_Select_VS.swift
//  Hiton
//
//  Created by yao on 08/04/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class View_Select_VS: UIView {

    @IBOutlet var Button_SelectPlayer: UIButton!
    @IBOutlet var Button_Back: UIButton!
    
    @IBOutlet var topFrameYConstraint: NSLayoutConstraint!
    @IBOutlet var botFrameYConstraint: NSLayoutConstraint!
    
    @IBOutlet var BGView: UIView!
    
    var playerPressedBack: (() -> Void)?
    var playerPressedSelect: ((mode: Int) -> Void)?
    @IBOutlet var Button_01: UIButton!
    @IBOutlet var Button_CR: UIButton!

    @IBOutlet var Line: UIImageView!
    
    func viewSetup(){
        
        BGView.alpha = 0
        Button_01.alpha = 0
        Button_CR.alpha = 0
        Line.alpha = 0
        
        topFrameYConstraint.constant = -Button_SelectPlayer.bounds.size.height
        botFrameYConstraint.constant = -Button_Back.bounds.size.height
        self.layoutIfNeeded()
        return
    }
    
    func startAnimation(){
        topFrameYConstraint.constant = 0
        botFrameYConstraint.constant = 0
        UIView.animateWithDuration(0.2, animations: {
            self.BGView.alpha = 0.4
            self.Line.alpha = 1
            self.layoutIfNeeded()
        }) { (bool) in
            
        }
        UIView.animateWithDuration(0.6, animations: {
            self.Button_01.alpha = 1
            self.Button_CR.alpha = 1
            self.layoutIfNeeded()
        }) { (bool) in
            
        }
    }
    
    @IBAction func Button_01Pressed(sender: AnyObject) {
        if let callback = self.playerPressedSelect {
            callback(mode: 1)
        }
    }
    
    @IBAction func Button_CRPressed(sender: AnyObject) {
        if let callback = self.playerPressedSelect {
            callback(mode: 2)
        }
    }
    
    @IBAction func backPressed(sender: AnyObject) {
        topFrameYConstraint.constant = -Button_SelectPlayer.bounds.size.height
        botFrameYConstraint.constant = -Button_Back.bounds.size.height
        UIView.animateWithDuration(0.2, animations: {
            
            self.BGView.alpha = 0
            self.Button_01.alpha = 0
            self.Button_CR.alpha = 0
            self.Line.alpha = 0
            self.layoutIfNeeded()
        }) { (bool) in
            self.removeFromSuperview()
            if let callback = self.playerPressedBack{
                callback()
            }
        }
    }

}
