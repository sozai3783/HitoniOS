

//
//  HalfIf_Smile.swift
//  Hiton
//
//  Created by yao on 09/08/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class HalfIf_Smile: UIView {

    @IBOutlet var Smile: UIImageView!
    var count = 0
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    func setup(){
        
    }
    
    func startAniamtion(){
        UIView.animateWithDuration(0.4, animations: { 
            self.Smile.image = UIImage(named: "smile_1")
            }) { (true) in
                UIView.animateWithDuration(0.4, animations: {
                    self.Smile.image = UIImage(named: "smile_2")
                }) { (true) in
                    if self.count <= 3 {
                        self.count += 1
                        self.startAniamtion()
                    }else{
                        self.count = 0
                        self.removeFromSuperview()
                    }
                }
        }
    }

}
