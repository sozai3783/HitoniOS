//
//  GameSetting.swift
//  Hiton
//
//  Created by yao on 02/06/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class GameSetting: UIView {
    
    @IBOutlet var P1_Avatar: UIImageView!
    @IBOutlet var P1_INOption: UIButton!
    @IBOutlet var P1_OUTOption: UIButton!
    @IBOutlet var P1_BullSplit: UIButton!
    
    @IBOutlet var P2_Avatar: UIImageView!
    @IBOutlet var P2_INOption: UIButton!
    @IBOutlet var P2_OUTOption: UIButton!
    @IBOutlet var P2_BullSplit: UIButton!
    
    @IBOutlet var P3_Avatar: UIImageView!
    @IBOutlet var P3_INOption: UIButton!
    @IBOutlet var P3_OUTOption: UIButton!
    @IBOutlet var P3_BullSplit: UIButton!
    
    @IBOutlet var P4_Avatar: UIImageView!
    @IBOutlet var P4_INOption: UIButton!
    @IBOutlet var P4_OUTOption: UIButton!
    @IBOutlet var P4_BullSplit: UIButton!
    
    var playerCount: Int!
    
    var stringArray = ["NORMAL", "DOUBLE", "TRIPLE", "MASTER"]
    
    var P1_INSelect = 0
    var P1_OUTSelect = 0
    var P1_BullSelect = 0
    
    
    var P2_INSelect = 0
    var P2_OUTSelect = 0
    var P2_BullSelect = 0
    
    
    var P3_INSelect = 0
    var P3_OUTSelect = 0
    var P3_BullSelect = 0
    
    
    var P4_INSelect = 0
    var P4_OUTSelect = 0
    var P4_BullSelect = 0
    
    var back: (() -> Void)?
    var reset: (() -> Void)?
    var confirm: (() -> Void)?
    
    var P1: PlayerClass!
    var P2: PlayerClass!
    var P3: PlayerClass!
    var P4: PlayerClass!
    
    func setup(_playerCount: Int, _p1: PlayerClass, _p2: PlayerClass, _p3: PlayerClass, _p4: PlayerClass){
        playerCount = _playerCount
        switch _playerCount {
        case 1:
            P1 = _p1
            
            P2_Avatar.hidden = true
            P2_INOption.hidden = true
            P2_OUTOption.hidden = true
            P2_BullSplit.hidden = true
            
            P3_Avatar.hidden = true
            P3_INOption.hidden = true
            P3_OUTOption.hidden = true
            P3_BullSplit.hidden = true
            
            P4_Avatar.hidden = true
            P4_INOption.hidden = true
            P4_OUTOption.hidden = true
            P4_BullSplit.hidden = true
            break
        case 2:
            P1 = _p1
            P2 = _p2
            
            P3_Avatar.hidden = true
            P3_INOption.hidden = true
            P3_OUTOption.hidden = true
            P3_BullSplit.hidden = true
            
            P4_Avatar.hidden = true
            P4_INOption.hidden = true
            P4_OUTOption.hidden = true
            P4_BullSplit.hidden = true
            break
        case 3:
            P1 = _p1
            P2 = _p2
            P3 = _p3
            
            P4_Avatar.hidden = true
            P4_INOption.hidden = true
            P4_OUTOption.hidden = true
            P4_BullSplit.hidden = true
            break
        case 4:
            P1 = _p1
            P2 = _p2
            P3 = _p3
            P4 = _p4
            break
        default:
            break
        }
    }
    
    @IBAction func backPressed(sender: AnyObject) {
        if let callback = self.back {
            callback()
        }
        self.removeFromSuperview()
    }
    
    //----P1
    @IBAction func P1_IN_Pressed(sender: AnyObject) {
        P1_INSelect = P1_INSelect == stringArray.count-1 ? 0 : P1_INSelect + 1
        P1_INOption.setTitle(stringArray[P1_INSelect], forState: .Normal)
    }
    
    @IBAction func P1_OUT_Pressed(sender: AnyObject) {
        P1_OUTSelect = P1_OUTSelect == stringArray.count-1 ? 0 : P1_OUTSelect + 1
        P1_OUTOption.setTitle(stringArray[P1_OUTSelect], forState: .Normal)
    }
    
    @IBAction func P1_Bull_Pressed(sender: AnyObject) {
        
    }
    //----P2
    
    @IBAction func P2_IN_Pressed(sender: AnyObject) {
        P2_INSelect = P2_INSelect == stringArray.count-1 ? 0 : P2_INSelect + 1
        P2_INOption.setTitle(stringArray[P2_INSelect], forState: .Normal)
    }
    
    @IBAction func P2_OUT_Pressed(sender: AnyObject) {
        P2_OUTSelect = P2_OUTSelect == stringArray.count-1 ? 0 : P2_OUTSelect + 1
        P2_OUTOption.setTitle(stringArray[P2_OUTSelect], forState: .Normal)
    }
    
    @IBAction func P2_Bull_Pressed(sender: AnyObject) {
    }

    //----P3
    @IBAction func P3_IN_Pressed(sender: AnyObject) {
        P3_INSelect = P3_INSelect == stringArray.count-1 ? 0 : P3_INSelect + 1
        P3_INOption.setTitle(stringArray[P3_INSelect], forState: .Normal)
    }
    
    @IBAction func P3_OUT_Pressed(sender: AnyObject) {
        P3_OUTSelect = P3_OUTSelect == stringArray.count-1 ? 0 : P3_OUTSelect + 1
        P3_OUTOption.setTitle(stringArray[P3_OUTSelect], forState: .Normal)
    }
    
    @IBAction func P3_Bull_Pressed(sender: AnyObject) {
    }

    //----P4
    @IBAction func P4_IN_Pressed(sender: AnyObject) {
        P4_INSelect = P4_INSelect == stringArray.count-1 ? 0 : P4_INSelect + 1
        P4_INOption.setTitle(stringArray[P4_INSelect], forState: .Normal)
    }
    
    @IBAction func P4_OUT_Pressed(sender: AnyObject) {
        P4_OUTSelect = P4_OUTSelect == stringArray.count-1 ? 0 : P4_OUTSelect + 1
        P4_OUTOption.setTitle(stringArray[P4_OUTSelect], forState: .Normal)
    }
    
    @IBAction func P4_Bull_Pressed(sender: AnyObject) {
    }

    
    
    @IBAction func resetPressed(sender: AnyObject) {
        P1_INSelect = 0
        P1_INOption.setTitle(stringArray[P1_INSelect], forState: .Normal)
        P1_OUTSelect = 0
        P1_OUTOption.setTitle(stringArray[P1_OUTSelect], forState: .Normal)
        
        P2_INSelect = 0
        P2_INOption.setTitle(stringArray[P2_INSelect], forState: .Normal)
        P2_OUTSelect = 0
        P2_OUTOption.setTitle(stringArray[P2_OUTSelect], forState: .Normal)
        
        P3_INSelect = 0
        P3_INOption.setTitle(stringArray[P3_INSelect], forState: .Normal)
        P3_OUTSelect = 0
        P3_OUTOption.setTitle(stringArray[P3_OUTSelect], forState: .Normal)
        
        P4_INSelect = 0
        P4_INOption.setTitle(stringArray[P4_INSelect], forState: .Normal)
        P4_OUTSelect = 0
        P4_OUTOption.setTitle(stringArray[P4_OUTSelect], forState: .Normal)
    }
    
    @IBAction func confirmPressed(sender: AnyObject) {
        switch playerCount {
        case 1:
            P1.inOption = P1_INSelect
            P1.outOption = P1_OUTSelect
            P1.Bool_in = P1_INSelect == 0 ? false : true
            P1.Bool_out = P1_INSelect == 0 ? false : true
            break
        case 2:
            P1.inOption = P1_INSelect
            P1.outOption = P1_OUTSelect
            P1.Bool_in = P1_INSelect == 0 ? false : true
            P1.Bool_out = P1_INSelect == 0 ? false : true
            
            P2.inOption = P2_INSelect
            P2.outOption = P2_OUTSelect
            P2.Bool_in = P2_INSelect == 0 ? false : true
            P2.Bool_out = P2_INSelect == 0 ? false : true
            break
        case 3:
            P1.inOption = P1_INSelect
            P1.outOption = P1_OUTSelect
            P1.Bool_in = P1_INSelect == 0 ? false : true
            P1.Bool_out = P1_INSelect == 0 ? false : true
            
            P2.inOption = P2_INSelect
            P2.outOption = P2_OUTSelect
            P2.Bool_in = P2_INSelect == 0 ? false : true
            P2.Bool_out = P2_INSelect == 0 ? false : true
            
            P3.inOption = P3_INSelect
            P3.outOption = P3_OUTSelect
            P3.Bool_in = P3_INSelect == 0 ? false : true
            P3.Bool_out = P3_INSelect == 0 ? false : true
            break
        case 4:
            P1.inOption = P1_INSelect
            P1.outOption = P1_OUTSelect
            P1.Bool_in = P1_INSelect == 0 ? false : true
            P1.Bool_out = P1_INSelect == 0 ? false : true
            
            P2.inOption = P2_INSelect
            P2.outOption = P2_OUTSelect
            P2.Bool_in = P2_INSelect == 0 ? false : true
            P2.Bool_out = P2_INSelect == 0 ? false : true
            
            P3.inOption = P3_INSelect
            P3.outOption = P3_OUTSelect
            P3.Bool_in = P3_INSelect == 0 ? false : true
            P3.Bool_out = P3_INSelect == 0 ? false : true
            
            P4.inOption = P4_INSelect
            P4.outOption = P4_OUTSelect
            P4.Bool_in = P4_INSelect == 0 ? false : true
            P4.Bool_out = P4_INSelect == 0 ? false : true
            break
        default:
            break
        }
        self.removeFromSuperview()
        
    }
    
}
