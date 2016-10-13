//
//  PlayerClass.swift
//  Hiton
//
//  Created by yao on 25/04/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class PlayerClass: NSObject {
    
    /*class var sharedInstance: PlayerClass {
        struct Singleton {
            static var onceToken : dispatch_once_t = 0
            static var staticInstance: PlayerClass? = nil
        }
        dispatch_once(&Singleton.onceToken) {
            Singleton.staticInstance = PlayerClass()
        }
        return Singleton.staticInstance!
    }*/
    
    var Score = 0
    var Round3DartsScoreArray = NSMutableArray()
    var RoundTotalScoreArray = NSMutableArray()
    
    
    var CRRoundLicense = NSMutableArray()
    var CRAllRoundLicense = NSMutableArray()
    var All_License_Get = false
    
    var ScoreArray = NSMutableArray()
    var Score1Array = NSMutableArray()
    var Score2Array = NSMutableArray()
    var Score3Array = NSMutableArray()
    
    var inOption = 0
    var outOption = 0
    
    var Bool_in = false
    var Bool_out = false
    
    var twentyLicense = false
    var nineteenLicense = false
    var eighteenLicense = false
    var seventeenLicense = false
    var sixteenLicense = false
    var fifteenLicense = false
    var bullLicense = false
    
    
    var twentyHit = 0
    var nineteenHit = 0
    var eighteenHit = 0
    var seventeenHit = 0
    var sixteenHit = 0
    var fifteenHit = 0
    var bullHit = 0

    override init() {
        super.init()
    }
    
    
    
    func saveRoundTotalScore(_score: Int){
        RoundTotalScoreArray.addObject(_score)
    }
    
    func reThrowDart(){
        
    }
    
    
}
