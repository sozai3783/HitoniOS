//
//  View_Game01.swift
//  Hiton
//
//  Created by yao on 04/04/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class View_Game01: UIView {

    @IBOutlet var outFrame: UIImageView!
    @IBOutlet var inFrame: UIImageView!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    func startAnimation(){
        outFrame.rotateLeftAnimtation()
        inFrame.rotateRightAnimtation()
        UIView.animateWithDuration(0.2, animations: { 
            
            self.outFrame.alpha = 1
            self.inFrame.alpha = 1
            }) { (true) in
                
        }
        
    }
  
    func removeAnimation(){
        outFrame.alpha = 0
        inFrame.alpha = 0
    }

}
