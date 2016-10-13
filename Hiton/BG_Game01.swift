//
//  BG_Game01.swift
//  Hiton
//
//  Created by yao on 05/04/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class BG_Game01: UIView {
    @IBOutlet var outFrameXConstraint: NSLayoutConstraint!
    @IBOutlet var bg: UIImageView!

    @IBOutlet var outFrame: UIImageView!
    @IBOutlet var inFrame: UIImageView!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    //@IBOutlet var ImageView_GameMode: UIImageView!
    
    func setup(){
        //ImageView_GameMode.hidden = true
        
        outFrameXConstraint.constant = -self.frame.size.width/3.6
        self.layoutIfNeeded()
        
        return
    }
    
    func startAnimation(){
        outFrame.rotateLeftAnimtation()
        inFrame.rotateRightAnimtation()
    }
    
    

}
