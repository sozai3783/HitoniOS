//
//  Pop_BluetoothDisconnect.swift
//  Hiton
//
//  Created by yao on 25/07/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class Pop_BluetoothDisconnect: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
     */
    var OK: (() -> Void)?

    @IBAction func OK_Pressed(sender: AnyObject) {
        if let callback = self.OK{
            callback()
        }
    }
}
