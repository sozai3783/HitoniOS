//
//  LuckyBalloon_4Player.swift
//  Hiton
//
//  Created by yao on 15/08/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class LuckyBalloon_4Player: UIView {
    
    @IBOutlet var P1_Line: UIImageView!
    @IBOutlet var P2_Line: UIImageView!
    @IBOutlet var P3_Line: UIImageView!
    @IBOutlet var P4_Line: UIImageView!
    

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
        
        P1_Line.hidden = false
        P2_Line.hidden = true
        P3_Line.hidden = true
        P4_Line.hidden = true
        
        line.constant = 30
    }
    
    func hiddenScore(){
        PlayerScore.hidden = true
        Player2Score.hidden = true
        Player3Score.hidden = true
        Player4Score.hidden = true
    }
    
    
    func DrawLine(_nPlayer: Int){
        switch _nPlayer {
        case 1:
            P1_Line.hidden = false
            P2_Line.hidden = true
            P3_Line.hidden = true
            P4_Line.hidden = true
            break
        case 2:
            P1_Line.hidden = true
            P2_Line.hidden = false
            P3_Line.hidden = true
            P4_Line.hidden = true
            break
        case 3:
            P1_Line.hidden = true
            P2_Line.hidden = true
            P3_Line.hidden = false
            P4_Line.hidden = true
            break
        case 4:
            P1_Line.hidden = true
            P2_Line.hidden = true
            P3_Line.hidden = true
            P4_Line.hidden = false
            break
        default:
            break
        }
    }


}
