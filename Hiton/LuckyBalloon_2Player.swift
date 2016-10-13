//
//  LuckyBalloon_2Player.swift
//  Hiton
//
//  Created by yao on 15/08/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class LuckyBalloon_2Player: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet var P1_Line: UIImageView!
    @IBOutlet var P2_Line: UIImageView!
    
    @IBOutlet var P1_Line_Bottom: NSLayoutConstraint!
    @IBOutlet var P2_Line_Bottom: NSLayoutConstraint!
    
    //@IBOutlet var Line_Center: NSLayoutConstraint!
    //@IBOutlet var ImageView_Line: UIImageView!
    
    @IBOutlet var PlayerScore: UIImageView!
    @IBOutlet var Player1_Name: UILabel!
    @IBOutlet var Player2Score: UIImageView!
    @IBOutlet var Player2_Name: UILabel!
    
    
    @IBOutlet var P1_BG: UIImageView!
    @IBOutlet var P2_BG: UIImageView!
    
    @IBOutlet var line: NSLayoutConstraint!
    
    @IBOutlet var P1LeftConstraint: NSLayoutConstraint!
    @IBOutlet var P2RightConstraint: NSLayoutConstraint!
    
    func setup(_score: Int){
        PlayerScore.drawPlayerScore(1, _score: _score)
        Player2Score.drawPlayerScoreGray(_score)
        P2_BG.image = UIImage(named: "Game01_2_2_Gray")
        line.constant = 50
        P2RightConstraint.constant = 40
        
        //Line_Center.constant = self.center.x - (ImageView_Line.frame.size.width/2) + 30
        //P1_Line_Bottom.constant = -5
        //P2_Line_Bottom.constant = -5
        P2_Line.hidden = true
        
        self.layoutIfNeeded()
    }
    
    func hiddenScore(){
        PlayerScore.hidden = true
        Player2Score.hidden = true
    }
    
    func DrawLine(_nPlayer: Int){
        switch _nPlayer {
        case 1:
            P1_Line.hidden = false
            P2_Line.hidden = true
            break
        case 2:
            P1_Line.hidden = true
            P2_Line.hidden = false
            break
        case 3:
            break
        case 4:
            break
        default:
            break
        }
    }
    
    
    func drawScore(_nPlayer: Int, _score: Int){
        switch _nPlayer {
        case 1:
            line.constant = 50
            PlayerScore.drawPlayerScore(1, _score: _score)
            break
        case 2:
            print("iN?")
            line.constant = -50
            Player2Score.drawPlayerScore(2, _score: _score)
            break
        default:
            break
        }
        self.layoutIfNeeded()
    }


}
