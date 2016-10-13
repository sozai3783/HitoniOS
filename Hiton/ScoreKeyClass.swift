
//
//  ScoreKeyClass.swift
//  quickBlox-test
//
//  Created by yao on 23/03/2016.
//  Copyright © 2016 yao. All rights reserved.
//

import UIKit

class ScoreKeyClass: NSObject {
    
    var smallSingle = ["50", "56", "55", "51", "0a", "52", "05", "04", "09", "57", "08", "02", "58", "03", "53", "07", "54", "59", "06", "01"]
    var bigSingle = ["46", "4c", "4b", "47", "14", "48", "0f", "0e", "13", "4d", "12", "0c", "4e", "0d", "49", "11", "4a", "4f", "10", "0b"]
    var double = ["3c", "4C", "41", "3d", "1e", "3e", "19", "18", "1d", "43", "1C", "16", "44", "17", "3f", "1b", "40", "45", "1a", "15"]
    var triple = ["5a", "38", "37", "33", "28", "34", "23", "22", "27", "39", "26", "20", "3a", "21", "35", "25", "36", "3b", "24", "1f"]
    
    var d_bull = "29"
    var s_bull = "32"
    
    var miss = "5d"
    
    

    
    override init() {
        super.init()
    }
    
    func GameLogic_01(hitScore: String, callback: (Int, Int, String, String) -> Void) {
        if returnDBull(hitScore) != 0 {
            callback(50, 50, "D-Bull", "D-Bull")
        }else if returnSBull(hitScore) != 0 {
            callback(50, 50, "S-Bull", "S-Bull")
        }else if returnTripleKey(hitScore) != 0 {
            callback(returnTripleKey(hitScore)*3, returnTripleKey(hitScore), "Triple", "Triple")
        }else if returnDoubleKey(hitScore) != 0 {
            callback(returnDoubleKey(hitScore)*2, returnDoubleKey(hitScore), "Double", "Double")
        }else if returnBigKey(hitScore) != 0 {
            callback(returnBigKey(hitScore), returnBigKey(hitScore), "Single", "Single")
        }else if returnSmallKey(hitScore) != 0 {
            callback(returnSmallKey(hitScore), returnSmallKey(hitScore), "Single", "Single")
        }else {
            callback(0, 0, "Miss", "Miss")
        }
    }

    
    func GameLogic(hitScore: String, callback: (Int, Int, String, String) -> Void) {
        if returnDBull(hitScore) != 0 {
            callback(50, 50, "D-Bull", "D-Bull")
        }else if returnSBull(hitScore) != 0 {
            callback(25, 25, "S-Bull", "S-Bull")
        }else if returnTripleKey(hitScore) != 0 {
            callback(returnTripleKey(hitScore)*3, returnTripleKey(hitScore), "Triple", "Triple")
        }else if returnDoubleKey(hitScore) != 0 {
            callback(returnDoubleKey(hitScore)*2, returnDoubleKey(hitScore), "Double", "Double")
        }else if returnBigKey(hitScore) != 0 {
            callback(returnBigKey(hitScore), returnBigKey(hitScore), "Single", "Single")
        }else if returnSmallKey(hitScore) != 0 {
            callback(returnSmallKey(hitScore), returnSmallKey(hitScore), "Single", "Single")
        }else {
            callback(0, 0, "Miss", "Miss")
        }
    }
    
    func GameLogic_BigBull(hitScore: String, callback: (Int, Int, String, String) -> Void) {
        if returnDBull(hitScore) != 0 {
            callback(100, 100, "D-Bull", "D-Bull")
        }else if returnSBull(hitScore) != 0 {
            callback(75, 75, "S-Bull", "S-Bull")
        }else if returnSmallKey(hitScore) != 0 {
            callback(50, 50, "S-Bull", "S-Bull")
        }else if returnTripleKey(hitScore) != 0 {
            callback(returnTripleKey(hitScore)*3, returnTripleKey(hitScore), "Triple", "Triple")
        }else if returnDoubleKey(hitScore) != 0 {
            callback(returnDoubleKey(hitScore)*2, returnDoubleKey(hitScore), "Double", "Double")
        }else if returnBigKey(hitScore) != 0 {
            callback(returnBigKey(hitScore), returnBigKey(hitScore), "Single", "Single")
        }else {
            callback(0, 0, "Miss", "Miss")
        }
    }

    
    func returnScore(str: String) -> Int {
        return returnSmallKey(str) != 0 ? returnSmallKey(str) : returnBigKey(str) != 0 ? returnBigKey(str) : returnDoubleKey(str) != 0 ? returnDoubleKey(str)*2 : returnTripleKey(str) != 0 ? returnTripleKey(str)*3 : returnSBull(str) != 0 ? returnSBull(str) : returnDBull(str) != 0 ? returnDBull(str) : 0
    }
    
    func returnSBull(str: String) -> Int{
        if str == s_bull{
            return 25
        }
        return 0
    }
    
    func returnDBull(str: String) -> Int{
        if str == d_bull{
            return 50
        }
        return 0
    }
    
    func returnSmallKey(str: String) -> Int{
        for i in 0...smallSingle.count-1 {
            if smallSingle[i] == str{
                return i+1
            }
        }
        return 0
    }
    
    func returnBigKey(str: String) -> Int{
        for i in 0...smallSingle.count-1 {
            if bigSingle[i] == str{
                return i+1
            }
        }
        return 0
    }
    
    func returnDoubleKey(str: String) -> Int{
        for i in 0...smallSingle.count-1 {
            if double[i] == str{
                return (i+1)
            }
        }
        return 0
    }
    
    func returnTripleKey(str: String) -> Int{
        for i in 0...smallSingle.count-1 {
            if triple[i] == str{
                return (i+1)
            }
        }
        return 0
    }
    func returnTripleScore(str: String) -> Int{
        for i in 0...smallSingle.count-1 {
            if triple[i] == str{
                return i+1
            }
        }
        return 0
    }

}
