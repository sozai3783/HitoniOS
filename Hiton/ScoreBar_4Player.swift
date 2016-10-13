

//
//  ScoreBar_4Player.swift
//  Hiton
//
//  Created by yao on 20/05/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class ScoreBar_4Player: UIView {
    
    @IBOutlet var P1_BG: UIImageView!
    @IBOutlet var P2_BG: UIImageView!
    @IBOutlet var P3_BG: UIImageView!
    @IBOutlet var P4_BG: UIImageView!
    @IBOutlet var PlayerScore: UIImageView!
    @IBOutlet var Player2Score: UIImageView!
    @IBOutlet var Player3Score: UIImageView!
    @IBOutlet var Player4Score: UIImageView!

    @IBOutlet var line: NSLayoutConstraint!
    @IBOutlet var line1: NSLayoutConstraint!
    @IBOutlet var line2: NSLayoutConstraint!
    
    func setup(_score: Int){
        PlayerScore.drawPlayerScore(1, _score: _score)
        Player2Score.drawPlayerScoreGray(_score)
        Player3Score.drawPlayerScoreGray(_score)
        Player4Score.drawPlayerScoreGray(_score)
        P2_BG.image = UIImage(named: "Game01_4_Gray")
        P3_BG.image = UIImage(named: "Game01_4_Gray")
        P4_BG.image = UIImage(named: "Game01_4_Gray")
        
        line.constant = 30
    }
    
    func hiddenScore(){
        PlayerScore.hidden = true
        Player2Score.hidden = true
        Player3Score.hidden = true
        Player4Score.hidden = true
    }
    
    func drawAllPlayerScore(P1Score: Int, P2Score: Int, P3Score: Int, P4Score: Int){
        //PlayerScore.drawScore
    }

}
