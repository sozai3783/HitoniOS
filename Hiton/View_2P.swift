//
//  View_2P.swift
//  Hiton
//
//  Created by yao on 19/04/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class View_2P: UIView {
    
    @IBOutlet var P1Center: NSLayoutConstraint!
    @IBOutlet var P2Center: NSLayoutConstraint!
    
    @IBOutlet var P1_Photo: UIImageView!
    @IBOutlet var P1_Name: UILabel!
    @IBOutlet var P1_PPD: UILabel!
    @IBOutlet var P1_MPR: UILabel!
    
    @IBOutlet var P2_Photo: UIImageView!
    @IBOutlet var P2_Name: UILabel!
    @IBOutlet var P2_Label_PPD: UILabel!
    @IBOutlet var P2_Label_MPR: UILabel!
    @IBOutlet var P2_PPD: UILabel!
    @IBOutlet var P2_MPR: UILabel!

    @IBOutlet var P2_TTJ: UIButton!
    
    
    
    func setup(){
        
        self.performSelector(#selector(View_2P.setStyleCircleForImage(_:)), withObject: P1_Photo)
        self.performSelector(#selector(View_2P.setStyleCircleForImage(_:)), withObject: P2_Photo)
        P1_Photo.image = UIImage(named: "Guest")
        P2_Photo.image = UIImage(named: "Guest")
        
        P1Center.constant = -(self.center.x / 2)
        P2Center.constant = self.center.x / 2
        self.layoutIfNeeded()
        
        P2_Label_MPR.hidden = true
        P2_Label_PPD.hidden = true
        P2_MPR.hidden = true
        P2_PPD.hidden = true
        startAnimation()
    }
    
    
    func setStyleCircleForImage(imgView: UIImageView){
        imgView.layer.cornerRadius = imgView.frame.size.width / 2.0
        imgView.clipsToBounds = true
    }
    
    func startAnimation(){
        UIView.animateWithDuration(0.8, animations: {
            if self.P2_TTJ.alpha == 0 {
                self.P2_TTJ.alpha = 1
            }else{
                self.P2_TTJ.alpha = 0
            }
            }) { (bool) in
                self.startAnimation()
        }
    }

    @IBAction func P2TTJPressed(sender: AnyObject) {
        print("p2 touch")
    }
}
