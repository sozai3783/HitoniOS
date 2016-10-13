//
//  PlayerMatchViewController.swift
//  Hiton
//
//  Created by yao on 19/04/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class PlayerMatchViewController: UIViewController {
    
    var playerCount = 0
    //var selectScore: Int!
    
    var GameMode: Int!
    var GameMode_SubMode: Int!
    
    var View_APlayer: View_1P?
    var View_TwoPlayers: View_2P?
    var View_ThreePlayers: View_3P?
    var View_FourPlayers: View_4P?
    
    var PressedBack: (() -> Void)?
    
    @IBOutlet var MatchView: UIView!
    
    
    var bluetooth = HitonBluetoothClass.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bluetooth.connectSuccess = {
            Void in
            
        }
        
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    
    func setup(){
        switch playerCount {
        case 1:
            View_APlayer = NSBundle.mainBundle().loadNibNamed("View_1P", owner: self, options: nil).last as? View_1P
            View_APlayer!.frame = MatchView.bounds
            View_APlayer?.setup()
            MatchView.addSubview(View_APlayer!)
            break
        case 2:
            View_TwoPlayers = NSBundle.mainBundle().loadNibNamed("View_2P", owner: self, options: nil).last as? View_2P
            View_TwoPlayers!.frame = MatchView.bounds
            View_TwoPlayers?.setup()
            MatchView.addSubview(View_TwoPlayers!)
            
            break
        case 3:
            View_ThreePlayers = NSBundle.mainBundle().loadNibNamed("View_3P", owner: self, options: nil).last as? View_3P
            View_ThreePlayers!.frame = MatchView.bounds
            View_ThreePlayers?.setup()
            MatchView.addSubview(View_ThreePlayers!)
            break
        case 4:
            View_FourPlayers = NSBundle.mainBundle().loadNibNamed("View_4P", owner: self, options: nil).last as? View_4P
            View_FourPlayers!.frame = MatchView.bounds
            View_FourPlayers?.setup()
            MatchView.addSubview(View_FourPlayers!)
            break
        default:
            break
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Game01" {
            let nextScene =  segue.destinationViewController as! Game01_ViewController
            nextScene.playerCount = playerCount
            nextScene.selectScore = GameMode_SubMode
        }else if segue.identifier == "CR" {
            let nextScene =  segue.destinationViewController as! CricketGameViewController
            nextScene.playerCount = playerCount
            nextScene.SelectMode = GameMode_SubMode
        }else if segue.identifier == "BullShooter"{
            let nextScene =  segue.destinationViewController as! BullShooterViewController
            nextScene.playerCount = playerCount
        }else if segue.identifier == "CountUp" {
            let nextScene =  segue.destinationViewController as! CountUpViewController
            nextScene.playerCount = playerCount
        }else if segue.identifier == "HalfIf" {
            let nextScene =  segue.destinationViewController as! HalfIfViewController
            nextScene.playerCount = playerCount
        }else if segue.identifier == "BigBull" {
            let nextScene =  segue.destinationViewController as! BigBullViewController
            nextScene.playerCount = playerCount
        }else if segue.identifier == "LuckyBalloon" {
            let nextScene =  segue.destinationViewController as! LuckyBalloonViewController
            nextScene.playerCount = playerCount
        }

    }

    
    @IBAction func backPressed(sender: AnyObject) {
        if let callback = self.PressedBack {
            callback()
        }
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    @IBAction func startPressed(sender: AnyObject) {
        var tempStr = ""
        switch GameMode {
        case 1:// 01 Game
            tempStr = "Game01"
            break
        case 2:// Cricket
            if GameMode_SubMode == 0 || GameMode_SubMode == 1 {
                tempStr = "CR"
            }else{
                tempStr = ""
            }
            break
        case 3:// Practice
            if GameMode_SubMode == 0 {
                tempStr = "CountUp"
            }else if GameMode_SubMode == 1 {
                tempStr = "BullShooter"
            }else{
               tempStr = "BigBull"
            }
            break
        case 4:// Fun Game
            if GameMode_SubMode == 0 {
                tempStr = "HalfIf"
            }else{
                tempStr = "LuckyBalloon"
            }
            break
        default:
            break
        }
        self.performSegueWithIdentifier(tempStr, sender: nil)
    }
    

}
