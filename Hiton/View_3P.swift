

//
//  View_3P.swift
//  Hiton
//
//  Created by yao on 19/04/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class View_3P: UIView {

    @IBOutlet var P1_Photo: UIImageView!
    @IBOutlet var P1_Name: UILabel!
    @IBOutlet var P1_PPD: UILabel!
    @IBOutlet var P1_MRP: UILabel!
    
    @IBOutlet var P2_Photo: UIImageView!
    @IBOutlet var P2_Name: UILabel!
    @IBOutlet var P2_Label_PPD: UILabel!
    @IBOutlet var P2_Label_MRP: UILabel!
    @IBOutlet var P2_PPD: UILabel!
    @IBOutlet var P2_MRP: UILabel!
    @IBOutlet var P2_TTJ: UIButton!
    
    @IBOutlet var P3_Photo: UIImageView!
    @IBOutlet var P3_Name: UILabel!
    @IBOutlet var P3_Label_PPD: UILabel!
    @IBOutlet var P3_Label_MRP: UILabel!
    @IBOutlet var P3_PPD: UILabel!
    @IBOutlet var P3_MRP: UILabel!
    @IBOutlet var P3_TTJ: UIButton!
    
    
    
    func setup(){
        self.performSelector(#selector(View_3P.setStyleCircleForImage(_:)), withObject: P1_Photo)
        self.performSelector(#selector(View_3P.setStyleCircleForImage(_:)), withObject: P2_Photo)
        self.performSelector(#selector(View_3P.setStyleCircleForImage(_:)), withObject: P3_Photo)
        P1_Photo.image = UIImage(named: "Guest")
        P2_Photo.image = UIImage(named: "Guest")
        P3_Photo.image = UIImage(named: "Guest")

        
        P2_Label_PPD.hidden = true
        P2_Label_MRP.hidden = true
        P2_PPD.hidden = true
        P2_MRP.hidden = true
        
        P3_Label_PPD.hidden = true
        P3_Label_MRP.hidden = true
        P3_PPD.hidden = true
        P3_MRP.hidden = true
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
            if self.P3_TTJ.alpha == 0 {
                self.P3_TTJ.alpha = 1
            }else{
                self.P3_TTJ.alpha = 0
            }
        }) { (bool) in
            self.startAnimation()
        }
    }


    @IBAction func P2TTJPRessed(sender: AnyObject) {
    }
    
    @IBAction func P3TTJPressed(sender: AnyObject) {
    }
    
}
