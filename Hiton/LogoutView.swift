


//
//  LogoutView.swift
//  Hiton
//
//  Created by yao on 15/06/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class LogoutView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var YES_Pressed: (() -> Void)?
    var NO_Pressed: (() -> Void)?
    
    @IBAction func NOPressed(sender: AnyObject) {
        if let callback = self.NO_Pressed {
            callback()
        }
        self.removeFromSuperview()
    }
    
    @IBAction func YESPressed(sender: AnyObject) {
        if let callback = self.YES_Pressed {
            callback()
        }
    }
    
}
