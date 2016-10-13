


//
//  OptionView.swift
//  Hiton
//
//  Created by yao on 17/05/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class OptionView: UIView {
    
    var gameSetting: (() -> Void)?
    var rethrowDart: (() -> Void)?
    var returnToGame: (() -> Void)?
    var Exit: (() -> Void)?
    
    @IBAction func handicapSettingPressed(sender: AnyObject) {
        
    }
    
    @IBAction func gameSettingPressed(sender: AnyObject) {
        if let callback = self.gameSetting {
            callback()
        }
    }
    
    @IBAction func rethrowDartPressed(sender: AnyObject) {
        if let callback = self.rethrowDart {
            callback()
        }
    }
    
    @IBAction func playingRulesPressed(sender: AnyObject) {
        
    }
    
    @IBAction func roundSettingPressed(sender: AnyObject) {
        
    }
    
    @IBAction func returnToGamePressed(sender: AnyObject) {
        if let callback = self.returnToGame {
            callback()
        }
    }

    @IBAction func ExitPreseed(sender: AnyObject) {
        if let callback = self.Exit {
            callback()
        }
    }
}
