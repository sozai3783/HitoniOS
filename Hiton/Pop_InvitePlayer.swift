

//
//  Pop_InvitePlayer.swift
//  Hiton
//
//  Created by yao on 30/05/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class Pop_InvitePlayer: UIView {
    
    var No: (() -> Void)?
    var Yes: (() -> Void)?
    
    @IBAction func NOPressed(sender: AnyObject) {
        if let callback = self.No {
            callback()
        }
        self.removeFromSuperview()
    }
    
    @IBAction func OKPressed(sender: AnyObject) {
        if let callback = self.Yes {
            callback()
        }
    }

}
