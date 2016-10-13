//
//  TransferData.swift
//  Hiton
//
//  Created by yao on 10/06/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class TransferData: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet var PPD: UILabel!
    @IBOutlet var MPR: UILabel!

    var userInfo = UserClass.sharedInstance
    
    
    var YES_Pressed: (() -> Void)?
    var NO_Pressed: (() -> Void)?
    var Close_Pressed: (() -> Void)?
    
    func setup(){
        PPD.text = "\(userInfo.PPD!)"
        MPR.text = "\(userInfo.MPR!)"
    }
    
    @IBAction func ClosePressed(sender: AnyObject) {
        if let callback = self.Close_Pressed {
            callback()
        }
    }
    
    @IBAction func NOPressed(sender: AnyObject) {
        if let callback = self.NO_Pressed {
            callback()
        }
    }
    
    @IBAction func YESPressed(sender: AnyObject) {
        if let callback = self.YES_Pressed {
            callback()
        }
    }
}
