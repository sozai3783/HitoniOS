//
//  View_1P.swift
//  Hiton
//
//  Created by yao on 19/04/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class View_1P: UIView {

    @IBOutlet var P1_Photo: UIImageView!
    @IBOutlet var P1_Name: UILabel!
    @IBOutlet var P1_PPD: UILabel!
    @IBOutlet var P1_MPR: UILabel!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    func setup(){
        
        self.performSelector(#selector(View_1P.setStyleCircleForImage(_:)), withObject: P1_Photo)
        P1_Photo.image = UIImage(named: "Guest")
    }
    
    func setStyleCircleForImage(imgView: UIImageView){
        imgView.layer.cornerRadius = imgView.frame.size.width / 2.0
        imgView.clipsToBounds = true
    }

}
