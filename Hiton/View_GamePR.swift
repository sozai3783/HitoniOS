//
//  View_GamePR.swift
//  Hiton
//
//  Created by yao on 04/04/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class View_GamePR: UIView {

    @IBOutlet var img: UIImageView!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    func startAnimation(){
        UIView.animateWithDuration(0.2, animations: { 
            self.img.alpha = 1
            }) { (true) in
                
        }
    }

    func removeAnimation(){
        img.alpha = 0
    }
    
}
