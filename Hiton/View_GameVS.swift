//
//  View_GameVS.swift
//  Hiton
//
//  Created by yao on 04/04/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class View_GameVS: UIView {

    @IBOutlet var vs1: UIImageView!
    @IBOutlet var vs2: UIImageView!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    func startAnimation(){
        UIView.animateWithDuration(0.4, animations: {
            self.vs1.alpha = 1
            }) { (bool) in
                UIView.animateWithDuration(0.3, animations: {
                    self.vs2.alpha = 1
                }) { (bool) in
                    
                }
        }
    }
    
    func removeAnimation(){
        vs1.alpha = 0
        vs2.alpha = 0
    }

}
