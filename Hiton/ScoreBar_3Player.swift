

//
//  ScoreBar_3Player.swift
//  Hiton
//
//  Created by yao on 20/05/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class ScoreBar_3Player: UIView {

    @IBOutlet var P1_BG: UIImageView!
    @IBOutlet var P2_BG: UIImageView!
    @IBOutlet var P3_BG: UIImageView!
    
    @IBOutlet var PlayerScore: UIImageView!
    @IBOutlet var Player2Score: UIImageView!
    @IBOutlet var Player3Score: UIImageView!
    
    @IBOutlet var P1Left: NSLayoutConstraint!
    
    @IBOutlet var P1Right: NSLayoutConstraint!
    
    @IBOutlet var P2Right: NSLayoutConstraint!
    @IBOutlet var P3Right: NSLayoutConstraint!
    
    @IBOutlet var line: NSLayoutConstraint!
    @IBOutlet var line2: NSLayoutConstraint!
    func setup(_score: Int){
        PlayerScore.drawPlayerScore(1, _score: _score)
        Player2Score.drawPlayerScoreGray(_score)
        Player3Score.drawPlayerScoreGray(_score)
        P2_BG.image = UIImage(named: "Game01_4_Gray")
        P3_BG.image = UIImage(named: "Game01_4_Gray")
        
        
        line.constant = 40
        line2.constant = 20
        P1Right.constant = 20
        P2Right.constant = 20
        
    }
    
    
    func hiddenScore(){
        PlayerScore.hidden = true
        Player2Score.hidden = true
        Player3Score.hidden = true
    }


}
