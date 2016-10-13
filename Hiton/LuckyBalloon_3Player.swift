



//
//  LuckyBalloon_3Player.swift
//  Hiton
//
//  Created by yao on 15/08/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class LuckyBalloon_3Player: UIView {

    //@IBOutlet var P1_Line_Center: NSLayoutConstraint!
    
    
    @IBOutlet var P1_Line: UIImageView!
    @IBOutlet var P1_Line_Right: NSLayoutConstraint!
    
    @IBOutlet var P2_Line: UIImageView!
    @IBOutlet var P2_Line_Center: NSLayoutConstraint!
    
    @IBOutlet var P3_Line: UIImageView!
    @IBOutlet var P3_Line_Lef: NSLayoutConstraint!
    
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
        
        self.layoutIfNeeded()
        
        P2_Line.hidden = true
        P3_Line.hidden = true
        
        
        P1_Line_Right.constant = -(P2_Line.frame.size.width/1.5)
        
        P3_Line_Lef.constant = -(P2_Line.frame.size.width/1.5)
        self.layoutIfNeeded()
    }
    
    
    func hiddenScore(){
        PlayerScore.hidden = true
        Player2Score.hidden = true
        Player3Score.hidden = true
    }
    
    func DrawLine(_nPlayer: Int){
        switch _nPlayer {
        case 1:
            P1_Line.hidden = false
            P2_Line.hidden = true
            P3_Line.hidden = true
            break
        case 2:
            P1_Line.hidden = true
            P2_Line.hidden = false
            P3_Line.hidden = true
            break
        case 3:
            P1_Line.hidden = true
            P2_Line.hidden = true
            P3_Line.hidden = false
            break
        case 4:
            break
        default:
            break
        }
    }

}
