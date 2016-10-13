//
//  View_GameCR.swift
//  Hiton
//
//  Created by yao on 04/04/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class View_GameCR: UIView {

    @IBOutlet var cr1: UIImageView!
    @IBOutlet var cr2: UIImageView!
    @IBOutlet var cr3: UIImageView!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    func startAnimation(){
        UIView.animateWithDuration(0.2, animations: {
            self.cr1.alpha = 1
            }) { (bool) in
                UIView.animateWithDuration(0.2, animations: {
                    self.cr2.alpha = 1
                }) { (bool) in
                    UIView.animateWithDuration(0.4, animations: {
                        self.cr3.alpha = 1
                    }) { (bool) in
                    }
                }
        }
    }
    func removeAnimation(){
        cr1.alpha = 0
        cr2.alpha = 0
        cr3.alpha = 0
    }

}
