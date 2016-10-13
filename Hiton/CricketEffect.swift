//
//  CricketEffect.swift
//  Hiton
//
//  Created by yao on 11/07/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class CricketEffect: UIView {

    @IBOutlet var IMG_1: UIImageView!
    @IBOutlet var IMG_2: UIImageView!
    @IBOutlet var IMG_3: UIImageView!

    var tempA: Int!
    var tempB: Int!
    var tempC: Int!
    var nPlayer: Int!
    var AnimationEnd: (() -> Void)?
    var audio = AudioClass()
    
    func drawImg(_player: Int, _array: NSMutableArray){
        IMG_1.hidden = true
        IMG_2.hidden = true
        IMG_3.hidden = true
        
        nPlayer = _player
        tempA = _array[0].integerValue
        tempB = _array[1].integerValue
        tempC = _array[2].integerValue
        
        NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: #selector(CricketEffect.draw1), userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(0.65, target: self, selector: #selector(CricketEffect.draw2), userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(0.9, target: self, selector: #selector(CricketEffect.draw3), userInfo: nil, repeats: false)
    }

    
    func draw1(){
        audio.CRMarkChompPlay()
        IMG_1.image = UIImage(named: tempA == 0 ? "P\(nPlayer)_Cricket_0" : "P\(nPlayer)_Cricket_\(tempA)")
        IMG_1.hidden = false
    }

    func draw2(){
        IMG_2.image = UIImage(named: tempB == 0 ? "P\(nPlayer)_Cricket_0" : "P\(nPlayer)_Cricket_\(tempB)")
        IMG_2.hidden = false
        //audio.CRMarkChompPlay()
    }
    
    func draw3(){
        IMG_3.image = UIImage(named: tempC == 0 ? "P\(nPlayer)_Cricket_0" : "P\(nPlayer)_Cricket_\(tempC)")
        IMG_3.hidden = false
        //audio.CRMarkChompPlay()
        NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: #selector(CricketEffect.AnimationFinish), userInfo: nil, repeats: false)
    }
    
    func AnimationFinish(){
        if let callback = self.AnimationEnd {
            callback()
        }
        
        self.removeFromSuperview()
        IMG_1.hidden = true
        IMG_2.hidden = true
        IMG_3.hidden = true
    }
}
