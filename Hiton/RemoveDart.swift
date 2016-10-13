


//
//  RemoveDart.swift
//  Hiton
//
//  Created by yao on 27/04/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class RemoveDart: UIView {

    @IBOutlet var d1: UIImageView!
    @IBOutlet var d2: UIImageView!
    @IBOutlet var d3: UIImageView!
    
    var audio = AudioClass()
    
    var isSkip = false
    
    var AnimationEnd: (() -> Void)?
    
    func setup(){
        
    }
    
    func show(){
        isSkip = false
        audio.RemoveDartPlay()
        UIView.animateWithDuration(0.2, animations: { 
            self.d1.alpha = 0
            self.d2.alpha = 0
            self.d3.alpha = 0
            }) { (bool) in
                UIView.animateWithDuration(0.2, animations: {
                    self.d1.alpha = 1
                    self.d2.alpha = 1
                    self.d3.alpha = 1
                }) { (bool) in
                    UIView.animateWithDuration(0.2, animations: {
                        self.d1.alpha = 0
                        self.d2.alpha = 0
                        self.d3.alpha = 0
                    }) { (bool) in
                        UIView.animateWithDuration(0.2, animations: {
                            self.d1.alpha = 1
                            self.d2.alpha = 1
                            self.d3.alpha = 1
                        }) { (bool) in
                            UIView.animateWithDuration(0.2, animations: {
                                self.d1.alpha = 0
                                self.d2.alpha = 0
                                self.d3.alpha = 0
                            }) { (bool) in
                                UIView.animateWithDuration(0.2, animations: {
                                    self.d1.alpha = 1
                                    self.d2.alpha = 1
                                    self.d3.alpha = 1
                                }) { (bool) in
                                    self.removeFromSuperview()
                                    self.setup()
                                    if self.isSkip == false{
                                        if let callback = self.AnimationEnd {
                                            callback()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
        }
        
        /*UIView.animateWithDuration(0.2, animations: {
            self.layoutIfNeeded()
        }) { (bool) in
            self.removeFromSuperview()
            self.setup()
            if let callback = self.AnimationEnd {
                callback()
            }
        }*/
    }
    
    func stopAnimation(){
        isSkip = true
        self.removeFromSuperview()
        setup()
    }
}
