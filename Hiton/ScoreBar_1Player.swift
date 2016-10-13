//
//  ScoreBar_1Player.swift
//  Hiton
//
//  Created by yao on 19/05/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class ScoreBar_1Player: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet var PlayerName: UILabel!
    @IBOutlet var ImageView_Score: UIImageView!
    
    func setup(_score: Int){
        ImageView_Score.drawPlayerScore(1, _score: _score)  
    }
    
    func hiddenScore(){
        ImageView_Score.hidden = true
    }

}
