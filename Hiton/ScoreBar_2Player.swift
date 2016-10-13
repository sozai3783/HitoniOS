//
//  ScoreBar_2Player.swift
//  Hiton
//
//  Created by yao on 20/05/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class ScoreBar_2Player: UIView {

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
        self.layoutIfNeeded()
    }
    
    func hiddenScore(){
        PlayerScore.hidden = true
        Player2Score.hidden = true
    }

    
    func drawScore(_nPlayer: Int, _score: Int){
        switch _nPlayer {
        case 1:
            line.constant = 30
            PlayerScore.drawPlayerScore(1, _score: _score)
            break
        case 2:
            line.constant = -30
            Player2Score.drawPlayerScore(2, _score: _score)
            break
        default:
            break
        }
        self.layoutIfNeeded()
    }
}
