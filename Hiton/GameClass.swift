//
//  GameClass.swift
//  DemoP2P
//
//  Created by yao on 25/03/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class GameClass: NSObject {
    
    // 1: 01Game
    // 2: 01Game Online
    // 3: Cricket
    // 4: Cricket Online
    // Default = 1
    private var mode = 1
    
    
    private var isThrow: Bool!
    
    private var player = 1
    
    var roundDarts = NSMutableArray()
    var scoreDarts = NSMutableArray()
    var originalRoundScore = NSMutableArray()
    var checkMoreThenFive = NSMutableArray()
    
    
    var playerCount = 0
    var score: Int?
    
    var scoreKey = ScoreKeyClass()
    
    var audio = AudioClass()
    
    
    override init() {
        super.init()
    }
    
    init(_count: Int, _score: Int) {
        playerCount = _count
        score = _score
        super.init()
        //setup()
    }
    
    func GameLogic(hitScore: String, callback: (Int) -> Void) {
        //callback(tempScore!)
    }
    
    func Game_01_Logic(playerScore: Int, hitScore: String, _p: PlayerClass, callback: (Int, Int, String, Int, String) -> Void){
        var tempScore: Int?
        scoreKey.GameLogic_01(hitScore) { (_score, _originalScore, _sound, SDTBM) in
            //SDTB = Single / Double / Triple / Bull / Miss
            //callback(totalscore, originalScore, SDTB, status, videoString)
            //1 = Calculate / 2 = Bust / 3 = Win / 4 = Miss 
            
                self.Game_01_Sound(_sound, _originalScore: _originalScore)
                
                tempScore = playerScore - self.scoreKey.returnScore(hitScore)
                if tempScore < 0 {
                    print("GameClass - Bust...")
                    callback(playerScore, 0, "", 2, "Bust")
                }else if tempScore == 0 {
                    print("GameClass - Win...")
                    callback(tempScore!, _originalScore, SDTBM, 3, "Win")
                }else{
                    print("GameClass - Calculate...")
                    if _p.inOption == 0 {
                        
                    }else{
                        
                    }
                    
                    self.roundDarts.addObject("\(SDTBM == "D-Bull" ? "D-Bull" : SDTBM == "S-Bull" ? "S-Bull" : SDTBM == "Triple" ? "T\(_originalScore)" : SDTBM == "Double" ? "D\(_originalScore)" : "\(_originalScore)")")
                    self.scoreDarts.addObject(self.scoreKey.returnScore(hitScore))
                    self.originalRoundScore.addObject(_originalScore)
                    
                    if self.roundDarts.count == 3 {
                        let a = self.roundDarts[0] as! String
                        let b = self.roundDarts[1] as! String
                        let c = self.roundDarts[2] as! String
                        
                        
                        let a_Int = self.originalRoundScore[0].integerValue
                        let b_Int = self.originalRoundScore[1].integerValue
                        let c_Int = self.originalRoundScore[2].integerValue

                        let total = self.scoreDarts[0].integerValue + self.scoreDarts[1].integerValue + self.scoreDarts[2].integerValue
                        
                        //print("\(a) \(b) \(c)")
                        if (a == "T15" && b == "T15" && c == "T15") || (a == "T16" && b == "T16" && c == "T16") || (a == "T17" && b == "T17" && c == "T17") || (a == "T18" && b == "T18" && c == "T18") || (a == "T19" && b == "T19" && c == "T19") {
                            callback(tempScore!, _originalScore, SDTBM, 1, "ThreeInABed")
                        }else if (a_Int == 1 || a_Int == 20 || a_Int == 5) && (b_Int == 1 || b_Int == 20 || b_Int == 5) && (c_Int == 1 || c_Int == 20 || c_Int == 5) && a_Int != b_Int && a_Int != c_Int && b_Int != a_Int && b_Int != c_Int && c_Int != a_Int && c_Int != b_Int {
                            callback(tempScore!, _originalScore, SDTBM, 1, "FishAndChip")
                        }else if (a == "S-Bull" || a == "D-Bull") && (b == "S-Bull" || b == "D-Bull") && (c == "S-Bull" || c == "D-Bull") {
                            callback(tempScore!, _originalScore, SDTBM, 1, "HatTrick")
                        }else if a == "T20" && b == "T20" && c == "T20" {
                            callback(tempScore!, _originalScore, SDTBM, 1, "Ton80")
                        }else if (a == "1" || a == "D1" || a == "T1") && (b == "1" || b == "D1" || b == "T1") && (c == "1" || c == "D1" || c == "T1")  {
                            callback(tempScore!, _originalScore, SDTBM, 1, "BucketOfNail")
                        }else if total >= 101 && total <= 150 {
                            callback(tempScore!, _originalScore, SDTBM, 1, "LowTon")
                        }else if total >= 151 && total <= 180 {
                            callback(tempScore!, _originalScore, SDTBM, 1, "HighTon")
                        }else{
                            callback(tempScore!, _originalScore, SDTBM, 1, "")
                        }
                        
                        self.originalRoundScore = NSMutableArray()
                        self.roundDarts = NSMutableArray()
                        self.scoreDarts = NSMutableArray()
                    }else{
                        if _p.Bool_in == true {
                            print(_p.inOption)
                            switch _p.inOption {
                            case 1:
                                if SDTBM == "Double" {
                                    callback(tempScore!, _originalScore, SDTBM, 1, "")
                                    _p.Bool_in = false
                                }else{
                                    callback(playerScore, 0, "", 2, "Bust")
                                }
                                break
                            case 2:
                                if SDTBM == "Triple" {
                                    callback(tempScore!, _originalScore, SDTBM, 1, "")
                                    _p.Bool_in = false
                                }else{
                                    callback(playerScore, 0, "", 2, "Bust")
                                }
                                break
                            case 3:
                                if SDTBM == "Double" || SDTBM == "Triple" {
                                    callback(tempScore!, _originalScore, SDTBM, 1, "")
                                    _p.Bool_in = false
                                }else{
                                    callback(playerScore, 0, "", 2, "Bust")
                                }
                                break
                            default:
                                break
                            }
                        }else{
                            callback(tempScore!, _originalScore, SDTBM, 1, "")
                        }
                    }
                }

            /*}else{
                switch _p.inOption{
                case 1:
                    
                    break
                default:
                    break
                }
            }*/
        }
    }
    
    func checkDoubleIN(key: String) -> Bool {
        
        return false
    }
    
    func checkTripleIN(){
        
    }
    
    func checkMasterIN(){
        
    }
    
    /*func Game01_OnePlayerLogic(playerScore: Int, hitScore: String, callback: (Int, Int, String, String, String) -> Void){
        var tempScore: Int?
        scoreKey.GameLogic(hitScore) { (_score, _originalScore, _sound, SDTB) in
            //SDTB = Single / Double / Triple / Bull
            //callback(totalscore, originalScore, SDTB, status, videoString)
            
            self.Game_01_Sound(_sound)
            tempScore = playerScore - self.scoreKey.returnScore(hitScore)
            if tempScore < 0 {
                callback(playerScore, 0, "", "Bust", "Bust")
            }else{
                self.roundDarts.addObject(self.scoreKey.returnScore(hitScore))
                if self.roundDarts.count == 3 {
                    let a = self.roundDarts[0].intValue
                    let b = self.roundDarts[1].intValue
                    let c = self.roundDarts[2].intValue
                    print("\(a) \(b) \(c)")
                    let total = a + b + c
                    if (a == 45 && b == 45 && c == 45) || (a == 48 && b == 48 && c == 48) || (a == 51 && b == 51 && c == 51) || (a == 54 && b == 54 && c == 54) || (a == 57 && b == 57 && c == 57) {
                        callback(tempScore!, _originalScore, SDTB, "Cal", "ThreeInABed")
                    }else if a == 50 && b == 50 && c == 50 {
                        callback(tempScore!, _originalScore, SDTB, "Cal", "HatTrick")
                    }else if a + b + c >= 100 && a + b + c <= 150 {
                        callback(tempScore!, _originalScore, SDTB, "Cal", "LowTon")
                    }else if a == 60 && b == 60 && c == 60 {
                        callback(tempScore!, _originalScore, SDTB, "Cal", "Ton80")
                    }else if a >= 45 && b >= 45 && c >= 45 {
                        callback(tempScore!, _originalScore, SDTB, "Cal", "WhiteHorse")
                    }else if total >= 151 && total <= 180 {
                        callback(tempScore!, _originalScore, SDTB, "Cal", "HighTon")
                    }else{
                        callback(tempScore!, _originalScore, SDTB, "Cal", "")
                    }
                    self.roundDarts = NSMutableArray()
                }else{
                    callback(tempScore!, _originalScore, SDTB, "Cal", "")
                }
            }
        }
    }*/
    
    func Game_01_Sound(str: String, _originalScore: Int){
        switch str {
        case "Single":
            audio.SinglePlay()
            break
        case "Double":
            audio.DoublePlay()
            break
        case "Triple":
            switch _originalScore {
            case 16:
                audio.Triple16Play()
                break
            case 17:
                audio.Triple17Play()
                break
            case 18:
                audio.Triple18Play()
                break
            case 19:
                audio.Triple19Play()
                break
            case 20:
                audio.Triple20Play()
                break
            default:
                audio.TriplePlay()
                break
            }
            break
        case "S-Bull":
            audio.SBullPlay()
            break
        case "D-Bull":
            audio.DBullPlay()
            break
        case "Miss":
            audio.MissPlay()
            break
        default:
            break
        }
    }
    
    //-------------------------------
    
    func Logic_CR(hitScore: String, callback: (Int, String, Int, String, String) -> Void){
        scoreKey.GameLogic(hitScore) { (_score, _originalScore, _sound, _SDTBM) in
            self.roundDarts.addObject("\(_SDTBM == "D-Bull" ? "D-Bull" : _SDTBM == "S-Bull" ? "S-Bull" : _SDTBM == "Triple" ? "T\(_originalScore)" : _SDTBM == "Double" ? "D\(_originalScore)" : _SDTBM == "Single" ? "\(_originalScore)" : "Miss")")
            
            var tempStatus = 1
            var tempVideo = ""
            if self.roundDarts.count == 3 {
                let a = self.roundDarts[0] as! String
                let b = self.roundDarts[1] as! String
                let c = self.roundDarts[2] as! String
                if a == "T20" && b == "T20" && c == "T20"{
                    tempVideo = "Ton80"
                }else if (a == "T15" || a == "T16" || a == "T17" || a == "T18" || a == "T19" || a == "T20") && (b == "T15" || b == "T16" || b == "T17" || b == "T18" || b == "T19" || b == "T20") && (c == "T15" || c == "T16" || c == "T17" || c == "T18" || c == "T19" || c == "T20") && a != b && a != c && b != a && b != c && c != a && c != b {
                    tempVideo = "WhiteHorse"
                }else if (a == "S-Bull" || a == "D-Bull") && (b == "S-Bull" || b == "D-Bull") && (c == "S-Bull" || c == "D-Bull") {
                    tempVideo = "HatTrick"
                }else if (a == "T15" && b == "T15" && c == "T15") || (a == "T16" && b == "T16" && c == "T16") || (a == "T17" && b == "T17" && c == "T17") || (a == "T18" && b == "T18" && c == "T18") || (a == "T19" && b == "T19" && c == "T19") {
                    tempVideo = "ThreeInABed"
                }else{
                    tempVideo = ""
                }
                print("Logic video = \(tempVideo)")
                
                if _SDTBM == "Miss" {tempStatus = 2}else{tempStatus = 1}
                
                self.roundDarts = NSMutableArray()
                self.scoreDarts = NSMutableArray()
            }else{
                if _SDTBM == "Miss" {tempStatus = 2}else{tempStatus = 1}
                tempVideo = ""
            }
            if _originalScore >= 15 || _originalScore == 0{
                callback(_originalScore, _SDTBM, tempStatus, tempVideo, _sound)
            }else{
                callback(_originalScore, _SDTBM, 3, "", _sound)
            }

        }
    }
    
    
    func Logic_Cricket(hitScore: String, callback: (Int, String, Int, String, String) -> Void){
        //callback(totalscore, originalScore, SDTB, status, videoString, Sound)
        //1 = Calculate / 2 = Miss / 3 = < 15 / 4 = Windf
        scoreKey.GameLogic(hitScore) { (_score, _originalScore, _sound, _SDTBM) in
            
            /*if isClose == true {
                self.Cricket_Sound("Miss", _originalScore: _originalScore)
            }else{
                self.Cricket_Sound(_sound, _originalScore: _originalScore)
            }*/
            
            //if _originalScore >= 15 || _originalScore == 0{
                self.roundDarts.addObject("\(_SDTBM == "D-Bull" ? "D-Bull" : _SDTBM == "S-Bull" ? "S-Bull" : _SDTBM == "Triple" ? "T\(_originalScore)" : _SDTBM == "Double" ? "D\(_originalScore)" : _SDTBM == "Single" ? "\(_originalScore)" : "Miss")")
                
                var tempStatus = 1
                var tempVideo = ""
                if self.roundDarts.count == 3 {
                    let a = self.roundDarts[0] as! String
                    let b = self.roundDarts[1] as! String
                    let c = self.roundDarts[2] as! String
                    if a == "T20" && b == "T20" && c == "T20"{
                        tempVideo = "Ton80"
                    }else if (a == "T15" || a == "T16" || a == "T17" || a == "T18" || a == "T19" || a == "T20") && (b == "T15" || b == "T16" || b == "T17" || b == "T18" || b == "T19" || b == "T20") && (c == "T15" || c == "T16" || c == "T17" || c == "T18" || c == "T19" || c == "T20") && a != b && a != c && b != a && b != c && c != a && c != b {
                        tempVideo = "WhiteHorse"
                    }else if (a == "S-Bull" || a == "D-Bull") && (b == "S-Bull" || b == "D-Bull") && (c == "S-Bull" || c == "D-Bull") {
                        tempVideo = "HatTrick"
                    }else if (a == "T15" && b == "T15" && c == "T15") || (a == "T16" && b == "T16" && c == "T16") || (a == "T17" && b == "T17" && c == "T17") || (a == "T18" && b == "T18" && c == "T18") || (a == "T19" && b == "T19" && c == "T19") {
                        tempVideo = "ThreeInABed"
                    }else{
                        tempVideo = ""
                    }
                    print("Logic video = \(tempVideo)")
                    
                    if _SDTBM == "Miss" {tempStatus = 2}else{tempStatus = 1}
                    
                    self.roundDarts = NSMutableArray()
                    self.scoreDarts = NSMutableArray()
                }else{
                    if _SDTBM == "Miss" {tempStatus = 2}else{tempStatus = 1}
                    tempVideo = ""
                }
            if _originalScore >= 15 || _originalScore == 0{
//                if _SDTBM == "D-Bull" {
//                    callback(50, _SDTBM, tempStatus, tempVideo)
//                }else if _SDTBM == "S-Bull"{
//                    callback(50, _SDTBM, tempStatus, tempVideo)
//                }else{
                //print(tempVideo)
                callback(_originalScore, _SDTBM, tempStatus, tempVideo, _sound)
//                }
            }else{
                callback(_originalScore, _SDTBM, 3, "", _sound)
            }
            //}else{
            //    callback(_originalScore, _SDTBM, 3, "")
            //}
        }
        
    }
    
   
    func Cricket_Sound(str: String, _originalScore: Int){
        switch str {
        case "Single":
            if _originalScore >= 15 {
                audio.SinglePlay()
            }else{
                audio.MissPlay()
            }
            break
        case "Double":
            if _originalScore >= 15 {
                audio.DoublePlay()
            }else{
                audio.MissPlay()
            }
            break
        case "Triple":
            switch _originalScore {
            case 15:
                audio.CRTriple15Play()
                break
            case 16:
                audio.CRTriple16Play()
                break
            case 17:
                audio.CRTriple17Play()
                break
            case 18:
                audio.CRTriple18Play()
                break
            case 19:
                audio.CRTriple19Play()
                break
            case 20:
                audio.CRTriple20Play()
                break
            default:
                audio.MissPlay()
                break
            }
            break
        case "S-Bull":
            audio.SBullPlay()
            break
        case "D-Bull":
            audio.DBullPlay()
            break
        case "Miss":
            audio.MissPlay()
            break
        default:
            break
        }

    }
    
    func Logic_CountUp(playerScore: Int, hitScore: String, _p: PlayerClass, callback: (Int, Int, String, Int, String) -> Void){
        var tempScore: Int?
        scoreKey.GameLogic(hitScore) { (_score, _originalScore, _sound, SDTBM) in
            //SDTB = Single / Double / Triple / Bull / Miss
            //callback(totalscore, originalScore, SDTB, status, videoString)
            //1 = Calculate / 2 = Bust / 3 = Win / 4 = Miss
            
            
            self.Game_01_Sound(_sound, _originalScore: _originalScore)
            
            tempScore = playerScore + self.scoreKey.returnScore(hitScore)
            print("GameClass - Calculate...")
            
            self.roundDarts.addObject("\(SDTBM == "D-Bull" ? "D-Bull" : SDTBM == "S-Bull" ? "S-Bull" : SDTBM == "Triple" ? "T\(_originalScore)" : SDTBM == "Double" ? "D\(_originalScore)" : "\(_originalScore)")")
            self.scoreDarts.addObject(self.scoreKey.returnScore(hitScore))
            self.originalRoundScore.addObject(_originalScore)
            
            if self.roundDarts.count == 3 {
                let a = self.roundDarts[0] as! String
                let b = self.roundDarts[1] as! String
                let c = self.roundDarts[2] as! String
                
                let a_Int = self.originalRoundScore[0].integerValue
                let b_Int = self.originalRoundScore[1].integerValue
                let c_Int = self.originalRoundScore[2].integerValue
                
                let total = self.scoreDarts[0].integerValue + self.scoreDarts[1].integerValue + self.scoreDarts[2].integerValue
                
                print("\(a) \(b) \(c)")
                if (a == "T15" && b == "T15" && c == "T15") || (a == "T16" && b == "T16" && c == "T16") || (a == "T17" && b == "T17" && c == "T17") || (a == "T18" && b == "T18" && c == "T18") || (a == "T19" && b == "T19" && c == "T19") {
                    callback(tempScore!, _originalScore, SDTBM, 1, "ThreeInABed")
                }else if (a_Int == 1 || a_Int == 20 || a_Int == 5) && (b_Int == 1 || b_Int == 20 || b_Int == 5) && (c_Int == 1 || c_Int == 20 || c_Int == 5) && a_Int != b_Int && a_Int != c_Int && b_Int != a_Int && b_Int != c_Int && c_Int != a_Int && c_Int != b_Int {
                    callback(tempScore!, _originalScore, SDTBM, 1, "FishAndChip")
                }else if (a == "S-Bull" || a == "D-Bull") && (b == "S-Bull" || b == "D-Bull") && (c == "S-Bull" || c == "D-Bull") {
                    callback(tempScore!, _originalScore, SDTBM, 1, "HatTrick")
                }else if a == "T20" && b == "T20" && c == "T20" {
                    callback(tempScore!, _originalScore, SDTBM, 1, "Ton80")
                }else if (a == "1" || a == "D1" || a == "T1") && (b == "1" || b == "D1" || b == "T1") && (c == "1" || c == "D1" || c == "T1")  {
                    callback(tempScore!, _originalScore, SDTBM, 1, "BucketOfNail")
                }else if total >= 101 && total <= 150 {
                    callback(tempScore!, _originalScore, SDTBM, 1, "LowTon")
                }else if total >= 151 && total <= 180 {
                    callback(tempScore!, _originalScore, SDTBM, 1, "HighTon")
                }else{
                    callback(tempScore!, _originalScore, SDTBM, 1, "")
                }
                
                self.originalRoundScore = NSMutableArray()
                self.roundDarts = NSMutableArray()
                self.scoreDarts = NSMutableArray()
            }else{
                callback(tempScore!, _originalScore, SDTBM, 1, "")
            }
        }
    }
    
    
    
    func Logic_HalfIf(hitScore: String, _round: Int, _playerScore: Int, callback: (Int, Int, String, Int, Int, Bool) -> Void){
        
        var tempScore: Int?
        var tempBool = false // true = hit true, false = hit false
        var tempSmile = false
        scoreKey.GameLogic(hitScore) { (_score, _originalScore, _sound, _SDTBM) in
            
            
            switch _round {
            case 1:
                if _originalScore == 15 {
                    tempBool = true
                    self.Cricket_Sound(_sound, _originalScore: _originalScore)
                }else {
                    self.Cricket_Sound("Miss", _originalScore: _originalScore)
                }
                break
            case 2:
                if _originalScore == 16 {
                    tempBool = true
                    self.Cricket_Sound(_sound, _originalScore: _originalScore)
                }else {
                    self.Cricket_Sound("Miss", _originalScore: _originalScore)
                }
                break
            case 3:
                if _SDTBM == "Double" {
                    tempBool = true
                    self.Cricket_Sound(_sound, _originalScore: _originalScore)
                }else {
                    self.Cricket_Sound("Miss", _originalScore: _originalScore)
                }
                break
            case 4:
                if _originalScore == 17 {
                    tempBool = true
                    self.Cricket_Sound(_sound, _originalScore: _originalScore)
                }else {
                    self.Cricket_Sound("Miss", _originalScore: _originalScore)
                }
                break
            case 5:
                if _originalScore == 18 {
                    tempBool = true
                    self.Cricket_Sound(_sound, _originalScore: _originalScore)
                }else {
                    self.Cricket_Sound("Miss", _originalScore: _originalScore)
                }
                break
            case 6:
                if _SDTBM == "Triple" {
                    tempBool = true
                    self.Cricket_Sound(_sound, _originalScore: _originalScore)
                }else {
                    self.Cricket_Sound("Miss", _originalScore: _originalScore)
                }
                break
            case 7:
                if _originalScore == 19 {
                    tempBool = true
                    self.Cricket_Sound(_sound, _originalScore: _originalScore)
                }else {
                    self.Cricket_Sound("Miss", _originalScore: _originalScore)
                }
                break
            case 8:
                if _originalScore == 20 {
                    tempBool = true
                    self.Cricket_Sound(_sound, _originalScore: _originalScore)
                }else {
                    self.Cricket_Sound("Miss", _originalScore: _originalScore)
                }
                break
            case 9:
                if _SDTBM == "S-Bull" || _SDTBM == "D-Bull" {
                    tempBool = true
                    self.Cricket_Sound(_sound, _originalScore: _originalScore)
                }else {
                    self.Cricket_Sound("Miss", _originalScore: _originalScore)
                }
                break
            default:
                break
            }
            self.roundDarts.addObject(tempBool)
            
            if tempBool == true {
                tempScore = _playerScore + self.scoreKey.returnScore(hitScore)
            }else{
                tempScore = _playerScore
                tempSmile = true
            }
            
            if self.roundDarts.count == 3 {
                let a = self.roundDarts[0] as! Bool
                let b = self.roundDarts[1] as! Bool
                let c = self.roundDarts[2] as! Bool
                
                print("a = \(a) b = \(b) c = \(c)")
                
                var tempInt = 0
                //0 = normal , 1 = cut
                if a == false && b == false && c == false {
                    if _playerScore > 1 {
                        tempScore = _playerScore / 2
                    }else {
                        tempScore = _playerScore 
                    }
                    tempInt = 1
                }else{
                    //tempScore = tempScore
                    tempInt = 0
                }
                
                print(tempScore)
                print(tempInt)
                callback(tempScore!, _originalScore, _SDTBM, 1, tempInt, tempSmile)
                
                
                self.roundDarts = NSMutableArray()
                self.scoreDarts = NSMutableArray()
            }else{
                if tempBool == true {
                    callback(tempScore!, _originalScore, _SDTBM, 1, 0, tempSmile)
                }else{
                    callback(_playerScore, _originalScore, _SDTBM, 1, 0, tempSmile)
                }
            }
        }

    }
    
    func Logic_BullShooter(hitScore: String, _playerScore: Int, callback: (Int, Int, String, Int, String) -> Void){
        //callback = tempScore, originalScore, SDTBM, Status, Video
        
        var tempScore: Int?
        scoreKey.GameLogic(hitScore) { (_score, _originalScore, _sound, SDTBM) in
            
            
            if SDTBM == "D-Bull" || SDTBM == "S-Bull" {
                tempScore = _playerScore + (SDTBM == "D-Bull" ? 50 : 25)
                self.Game_01_Sound(_sound, _originalScore: _originalScore)
            }else{
                tempScore = _playerScore
                self.Game_01_Sound("Miss", _originalScore: _originalScore)
            }
            
            self.roundDarts.addObject("\(SDTBM == "D-Bull" ? "D-Bull" : SDTBM == "S-Bull" ? "S-Bull" : SDTBM == "Triple" ? "T\(_originalScore)" : SDTBM == "Double" ? "D\(_originalScore)" : "\(_originalScore)")")
            self.scoreDarts.addObject(self.scoreKey.returnScore(hitScore))
            
            if self.roundDarts.count == 3 {
                let a = self.roundDarts[0] as! String
                let b = self.roundDarts[1] as! String
                let c = self.roundDarts[2] as! String
                
                if (a == "S-Bull" || a == "D-Bull") && (b == "S-Bull" || b == "D-Bull") && (c == "S-Bull" || c == "D-Bull") {
                        callback(tempScore!, _originalScore, SDTBM, 1, "HatTrick")
                }else{
                        callback(tempScore!, _originalScore, SDTBM, 1, "")
                }
                self.roundDarts = NSMutableArray()
                self.scoreDarts = NSMutableArray()
            }else{
                callback(tempScore!, _originalScore, SDTBM, 1, "")
            }
        }
    }

    func Logic_BigBull(hitScore: String, _playerScore: Int, callback: (Int, Int, String, Int, String) -> Void){
        //callback = tempScore, originalScore, SDTBM, Status, Video
        var tempScore: Int?
        scoreKey.GameLogic_BigBull(hitScore) { (_score, _originalScore, _sound, SDTBM) in
            //SDTB = Single / Double / Triple / Bull / Miss
            //callback(totalscore, originalScore, SDTB, status, videoString)
            
            print(_score)
            
            self.Game_01_Sound((_score == 50 ? "S-Bull" : _sound), _originalScore: _originalScore)
            
            tempScore = _playerScore + _score
            
            self.roundDarts.addObject("\(SDTBM == "D-Bull" ? "D-Bull" : SDTBM == "S-Bull" ? "S-Bull" : SDTBM == "Small" ? "Small" : SDTBM == "Triple" ? "T\(_originalScore)" : SDTBM == "Double" ? "D\(_originalScore)" : "\(_originalScore)")")
            self.scoreDarts.addObject(_score)
            self.originalRoundScore.addObject(_originalScore)
            
            if self.roundDarts.count == 3 {
                let a = self.roundDarts[0] as! String
                let b = self.roundDarts[1] as! String
                let c = self.roundDarts[2] as! String
                
                let a_Int = self.scoreDarts[0].integerValue
                let b_Int = self.scoreDarts[1].integerValue
                let c_Int = self.scoreDarts[2].integerValue
                
                
                let a_FAC = self.originalRoundScore[0].integerValue
                let b_FAC = self.originalRoundScore[1].integerValue
                let c_FAC = self.originalRoundScore[2].integerValue
                
                let total = self.scoreDarts[0].integerValue + self.scoreDarts[1].integerValue + self.scoreDarts[2].integerValue
                
                if (a == "T15" && b == "T15" && c == "T15") || (a == "T16" && b == "T16" && c == "T16") || (a == "T17" && b == "T17" && c == "T17") || (a == "T18" && b == "T18" && c == "T18") || (a == "T19" && b == "T19" && c == "T19") {
                    callback(tempScore!, _originalScore, SDTBM, 1, "ThreeInABed")
                }else if (a_Int == 100 || a_Int == 75 || a_Int == 50) && (b_Int == 100 || b_Int == 75 || b_Int == 50) && (c_Int == 100 || c_Int == 75 || c_Int == 50) {
                    callback(tempScore!, _originalScore, SDTBM, 1, "HatTrick")
                }else if (a_FAC == 1 || a_FAC == 20 || a_FAC == 5) && (b_FAC == 1 || b_FAC == 20 || b_FAC == 5) && (c_FAC == 1 || c_FAC == 20 || c_FAC == 5) && a_FAC != b_FAC && a_FAC != c_FAC && b_FAC != a_FAC && b_FAC != c_FAC && c_FAC != a_FAC && c_FAC != b_FAC {
                    callback(tempScore!, _originalScore, SDTBM, 1, "FishAndChip")
                }else if a == "T20" && b == "T20" && c == "T20" {
                    callback(tempScore!, _originalScore, SDTBM, 1, "Ton80")
                }else if (a == "1" || a == "D1" || a == "T1") && (b == "1" || b == "D1" || b == "T1") && (c == "1" || c == "D1" || c == "T1")  {
                    callback(tempScore!, _originalScore, SDTBM, 1, "BucketOfNail")
                }else if total >= 101 && total <= 150 {
                    callback(tempScore!, _originalScore, SDTBM, 1, "LowTon")
                }else if total >= 151 && total != 180 {
                    callback(tempScore!, _originalScore, SDTBM, 1, "HighTon")
                }else{
                    callback(tempScore!, _originalScore, SDTBM, 1, "")
                }
                
                self.roundDarts = NSMutableArray()
                self.scoreDarts = NSMutableArray()
            }else{
                callback(tempScore!, _originalScore, SDTBM, 1, "")
            }
        }
    }
    
    func Logic_Balloon(hitScore: String, callback: (Int, Int, String) -> Void){
        //callback = tempScore, originalScore, SDTBM, Status, Video
        
        scoreKey.GameLogic_01(hitScore) { (_score, _originalScore, _sound, _SDTBM) in
            
            self.Game_01_Sound((_score == 50 ? "S-Bull" : _sound), _originalScore: _originalScore)
            callback(_score, _originalScore, _SDTBM)
        }
        
        /*var tempScore: Int?
        scoreKey.GameLogic_BigBull(hitScore) { (_score, _originalScore, _sound, SDTBM) in
            //SDTB = Single / Double / Triple / Bull / Miss
            //callback(totalscore, originalScore, SDTB, status, videoString)
            
            print(_score)
            
            self.Game_01_Sound((_score == 50 ? "S-Bull" : _sound), _originalScore: _originalScore)
            
            tempScore = _playerScore + _score
            
            self.roundDarts.addObject("\(SDTBM == "D-Bull" ? "D-Bull" : SDTBM == "S-Bull" ? "S-Bull" : SDTBM == "Small" ? "Small" : SDTBM == "Triple" ? "T\(_originalScore)" : SDTBM == "Double" ? "D\(_originalScore)" : "\(_originalScore)")")
            self.scoreDarts.addObject(_score)
            self.originalRoundScore.addObject(_originalScore)
            
            if self.roundDarts.count == 3 {
                let a = self.roundDarts[0] as! String
                let b = self.roundDarts[1] as! String
                let c = self.roundDarts[2] as! String
                
                let a_Int = self.scoreDarts[0].integerValue
                let b_Int = self.scoreDarts[1].integerValue
                let c_Int = self.scoreDarts[2].integerValue
                
                
                let a_FAC = self.originalRoundScore[0].integerValue
                let b_FAC = self.originalRoundScore[1].integerValue
                let c_FAC = self.originalRoundScore[2].integerValue
                
                let total = self.scoreDarts[0].integerValue + self.scoreDarts[1].integerValue + self.scoreDarts[2].integerValue
                
                if (a == "T15" && b == "T15" && c == "T15") || (a == "T16" && b == "T16" && c == "T16") || (a == "T17" && b == "T17" && c == "T17") || (a == "T18" && b == "T18" && c == "T18") || (a == "T19" && b == "T19" && c == "T19") {
                    callback(tempScore!, _originalScore, SDTBM, 1, "ThreeInABed")
                }else if (a_Int == 100 || a_Int == 75 || a_Int == 50) && (b_Int == 100 || b_Int == 75 || b_Int == 50) && (c_Int == 100 || c_Int == 75 || c_Int == 50) {
                    callback(tempScore!, _originalScore, SDTBM, 1, "HatTrick")
                }else if (a_FAC == 1 || a_FAC == 20 || a_FAC == 5) && (b_FAC == 1 || b_FAC == 20 || b_FAC == 5) && (c_FAC == 1 || c_FAC == 20 || c_FAC == 5) && a_FAC != b_FAC && a_FAC != c_FAC && b_FAC != a_FAC && b_FAC != c_FAC && c_FAC != a_FAC && c_FAC != b_FAC {
                    callback(tempScore!, _originalScore, SDTBM, 1, "FishAndChip")
                }else if a == "T20" && b == "T20" && c == "T20" {
                    callback(tempScore!, _originalScore, SDTBM, 1, "Ton80")
                }else if (a == "1" || a == "D1" || a == "T1") && (b == "1" || b == "D1" || b == "T1") && (c == "1" || c == "D1" || c == "T1")  {
                    callback(tempScore!, _originalScore, SDTBM, 1, "BucketOfNail")
                }else if total >= 101 && total <= 150 {
                    callback(tempScore!, _originalScore, SDTBM, 1, "LowTon")
                }else if total >= 151 && total != 180 {
                    callback(tempScore!, _originalScore, SDTBM, 1, "HighTon")
                }else{
                    callback(tempScore!, _originalScore, SDTBM, 1, "")
                }
                
                self.roundDarts = NSMutableArray()
                self.scoreDarts = NSMutableArray()
            }else{
                callback(tempScore!, _originalScore, SDTBM, 1, "")
            }
        }*/
    }


}
