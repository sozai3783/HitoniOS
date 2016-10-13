
//
//  HalfIf_Cut.swift
//  Hiton
//
//  Created by yao on 05/08/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class HalfIf_Cut: UIView {

    
    @IBOutlet var Cut_Y: NSLayoutConstraint!
    @IBOutlet var Cut_X: NSLayoutConstraint!
    @IBOutlet var Cut: UIImageView!
    @IBOutlet var Ninjia: UIImageView!
    
    @IBOutlet var Ninja_Top: NSLayoutConstraint!
    @IBOutlet var Ninja_Bot: NSLayoutConstraint!
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    func setup(){
        print(self.frame.size.width)
        print(self.frame.size.height)
        
        Cut_X.constant = 0 - (Cut.frame.size.width / 2)
        Cut_Y.constant = 0 - Cut.frame.size.height
        
        Ninja_Top.constant = 80
        Ninja_Bot.constant = 80
        self.layoutIfNeeded()
    }

    
    func animation(){
        self.Ninjia.alpha = 1
        Ninja_Top.constant = -200
        Ninja_Bot.constant = -200
        UIView.animateWithDuration(0.2, animations: {
            self.layoutIfNeeded()
            UIView.animateWithDuration(0.1, animations: {
                
                }, completion: { (true) in
                    self.Ninjia.image = UIImage(named: "samurai_blur")
            })
            }, completion: { (true) in
                self.Ninjia.alpha = 0
                
                self.Cut_X.constant = self.frame.size.width + (self.Cut.frame.size.width / 2)
                self.Cut_Y.constant = self.frame.size.height + self.Cut.frame.size.height
                UIView.animateWithDuration(0.3, animations: {
                    self.layoutIfNeeded()
                    
                }) { (true) in
                    self.removeFromSuperview()
                    
                    self.Ninja_Top.constant = 80
                    self.Ninja_Bot.constant = 80
                    self.Cut_X.constant = 0 - (self.Cut.frame.size.width / 2)
                    self.Cut_Y.constant = 0 - self.Cut.frame.size.height
                    self.layoutIfNeeded()
                }
        })
        
        
        
        
    }
}
