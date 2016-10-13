



//
//  GameRoomViewController.swift
//  Hiton
//
//  Created by yao on 06/05/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class GameRoomViewController: UIViewController {

    @IBOutlet var ImageView_AcceptChallenge: UIImageView!
    @IBOutlet var ImageView_CountDown: UIImageView!
    
    @IBOutlet var Button_Yes: UIButton!
    @IBOutlet var Button_No: UIButton!
    
    @IBOutlet var ReadyBG: UIImageView!
    
    @IBOutlet var ReadyDart: UIImageView!
    @IBOutlet var MiddleLight: UIImageView!
    @IBOutlet var ReadyNumber: UIImageView!
    @IBOutlet var ReadyEffectNumber: UIImageView!
    
    var Player = 0
    var otherPlayerIDN = 0
    var otherPlayerQuickBloxIDN = 0
    
    @IBOutlet var P1_Photo: UIImageView!
    @IBOutlet var P1_Name: UILabel!
    @IBOutlet var P1_PPD: UILabel!
    @IBOutlet var P1_MPR: UILabel!
    
    @IBOutlet var P2_Photo: UIImageView!
    @IBOutlet var P2_Name: UILabel!
    @IBOutlet var P2_PPD: UILabel!
    @IBOutlet var P2_MPR: UILabel!
    
    var API = DataClass.sharedInstance
    var userInfo = UserClass.sharedInstance
    
    var qbUser = QBUUser()
    
    var socket = HitonSocketClass.sharedInstance
    
    var countDownTimer: NSTimer!
    
    var checkStatusTimer: NSTimer!
    var readyToStartTimer: NSTimer!
    
    var GameMode = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API_GetName()
        
        self.performSelector(#selector(GameRoomViewController.setStyleCircleForImage(_:)), withObject: P1_Photo)
        self.performSelector(#selector(GameRoomViewController.setStyleCircleForImage(_:)), withObject: P2_Photo)
        P1_Photo.image = UIImage(named: "Guest")
        P2_Photo.image = UIImage(named: "Guest")
        
        switch Player {
        case 1:
            ImageView_AcceptChallenge.hidden = true
            Button_Yes.hidden = true
            Button_No.hidden = true
            break
        case 2:
            break
        default:
            break
        }
        
        socket.notify = {
            (_str) -> Void in
            let tempArray = _str.componentsSeparatedByString(":")
            let tempCode = (tempArray[0] as NSString).integerValue
            switch tempCode {
            case 204: // No
                dispatch_async(dispatch_get_main_queue(), {
                    self.navigationController?.popViewControllerAnimated(false)
                    if self.countDownTimer != nil {
                        self.countDownTimer.invalidate()
                    }
                });
                break
            case 205: // Yes
                if self.countDownTimer != nil {
                    self.countDownTimer.invalidate()
                }
                self.accept()
                break
            default:
                break
            }
        }
    }
    
    func API_GetName(){
        API.connectionStart_GetName(userInfo.IDN!, IDN2: otherPlayerIDN) { (dic) in
            let tempCode = dic.valueForKey("ResponeCode")!.integerValue
            if tempCode == 200 {
                let tempData = dic.valueForKey("Detail")
                let tempArray = tempData as! NSMutableArray
                self.P1_Name.text = tempArray.valueForKey("Player1_Name").objectAtIndex(0) as? String
                self.P1_PPD.text = "PPD : \(tempArray.valueForKey("Player1_PPD").objectAtIndex(0) as! String)"
                self.P1_MPR.text = "MPR : \(tempArray.valueForKey("Player1_MPR").objectAtIndex(0) as! String)"
                
                self.P2_Name.text = tempArray.valueForKey("Player2_Name").objectAtIndex(0) as? String
                self.P2_PPD.text = "PPD : \(tempArray.valueForKey("Player2_PPD").objectAtIndex(0) as! String)"
                self.P2_MPR.text = "MPR : \(tempArray.valueForKey("Player2_MPR").objectAtIndex(0) as! String)"
            }
        }

    }
    
    func setStyleCircleForImage(imgView: UIImageView){
        imgView.layer.cornerRadius = imgView.frame.size.width / 2.0
        imgView.clipsToBounds = true
    }

    
    override func viewWillAppear(animated: Bool) {
        ImageView_CountDown.countDown()
        countDownTimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(GameRoomViewController.timeout), userInfo: nil, repeats: false)
        /*if Player == 1 {
            NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: #selector(GameRoomViewController.checkStatus), userInfo: nil, repeats: false)
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func timeout(){
        self.socket.Decline()
    }
    
    /*func checkStatus(){
        API.connectionStart_LobbyCheckStatus(userInfo.IDN!) { (dic) in
            let tempCode = dic.valueForKey("ResponeCode")!.integerValue
            //print("GameRoom Check = \(dic)")
            if tempCode == 201 {
            
            }else if tempCode == 203 {
                NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: #selector(GameRoomViewController.checkStatus), userInfo: nil, repeats: false)
            }else if tempCode == 205{
                if self.checkStatusTimer != nil {
                    self.checkStatusTimer.invalidate()
                }
                let tempData = dic.valueForKey("Detail")
                let tempArray = tempData as! NSMutableArray
                self.otherPlayerIDN = tempArray.valueForKey("Player2_IDN").objectAtIndex(0) as! Int
                self.API.connectionStart_GetP1QBID(tempArray.valueForKey("GameIDN").objectAtIndex(0) as! Int, callback: { (dic1) in
                    let tempData1 = dic1.valueForKey("Detail")
                    let tempArray1 = tempData1 as! NSMutableArray
                    self.otherPlayerQuickBloxIDN = tempArray1.valueForKey("Player2_QB_IDN").objectAtIndex(0) as! Int
                    self.readyToStart(tempArray1.valueForKey("Player1_QB_IDN").objectAtIndex(0) as! UInt, GameRoom: tempArray1.valueForKey("GameIDN").objectAtIndex(0) as! Int)
                })
                
            }
        }
    }*/
    
    func readyToStart(quickBloxID: UInt, GameRoom: Int){
        qbUser.ID = quickBloxID
        /*if Player == 1 {
            qbUser.login = "\(GameRoom)A"
        }else{
            qbUser.login = "\(GameRoom)B"
        }*/
        qbUser.password = "12345678"
        //QBChat.instance().connectWithUser(qbUser, completion: { (error) in
        //})
        if Player == 2 {
            QBChat.instance().connectWithUser(qbUser, completion: { (error) in
            })
        }
        
        
        ImageView_AcceptChallenge.hidden = true
        Button_Yes.hidden = true
        Button_No.hidden = true
        
        self.ImageView_CountDown.hidden = true
        
        self.ReadyNumber.alpha = 1
        self.ReadyNumber.image = UIImage(named: "Ready_5")
        self.ReadyEffectNumber.image = UIImage(named: "Ready_5_5")
        UIView.animateWithDuration(0.4, animations: {
            self.ReadyEffectNumber.alpha = 1
            self.ReadyBG.alpha = 1
            self.ReadyDart.alpha = 1
            }, completion: { (bool) in
                UIView.animateWithDuration(0.6, animations: {
                    self.ReadyEffectNumber.alpha = 0
                    self.ReadyBG.alpha = 0
                    self.ReadyDart.alpha = 0
                    }, completion: { (bool) in
                        self.ReadyNumber.image = UIImage(named: "Ready_4")
                        self.ReadyEffectNumber.image = UIImage(named: "Ready_4_4")
                        UIView.animateWithDuration(0.4, animations: {
                            self.ReadyEffectNumber.alpha = 1
                            self.ReadyBG.alpha = 1
                            self.ReadyDart.alpha = 1
                            }, completion: { (bool) in
                                UIView.animateWithDuration(0.6, animations: {
                                    self.ReadyEffectNumber.alpha = 0
                                    self.ReadyBG.alpha = 0
                                    self.ReadyDart.alpha = 0
                                    }, completion: { (bool) in
                                        self.ReadyNumber.image = UIImage(named: "Ready_3")
                                        self.ReadyEffectNumber.image = UIImage(named: "Ready_3_3")
                                        UIView.animateWithDuration(0.4, animations: {
                                            self.ReadyEffectNumber.alpha = 1
                                            self.ReadyBG.alpha = 1
                                            self.ReadyDart.alpha = 1
                                            }, completion: { (bool) in
                                                UIView.animateWithDuration(0.6, animations: {
                                                    self.ReadyEffectNumber.alpha = 0
                                                    self.ReadyBG.alpha = 0
                                                    self.ReadyDart.alpha = 0
                                                    }, completion: { (bool) in
                                                        self.ReadyNumber.image = UIImage(named: "Ready_2")
                                                        self.ReadyEffectNumber.image = UIImage(named: "Ready_2_2")
                                                        UIView.animateWithDuration(0.4, animations: {
                                                            self.ReadyEffectNumber.alpha = 1
                                                            self.ReadyBG.alpha = 1
                                                            self.ReadyDart.alpha = 1
                                                            }, completion: { (bool) in
                                                                UIView.animateWithDuration(0.6, animations: {
                                                                    self.ReadyEffectNumber.alpha = 0
                                                                    self.ReadyBG.alpha = 0
                                                                    self.ReadyDart.alpha = 0
                                                                    }, completion: { (bool) in
                                                                        self.ReadyNumber.image = UIImage(named: "Ready_1")
                                                                        self.ReadyEffectNumber.image = UIImage(named: "Ready_1_1")
                                                                        UIView.animateWithDuration(0.4, animations: {
                                                                            self.ReadyEffectNumber.alpha = 1
                                                                            self.ReadyBG.alpha = 1
                                                                            self.ReadyDart.alpha = 1
                                                                            }, completion: { (bool) in
                                                                                UIView.animateWithDuration(0.6, animations: {
                                                                                    self.ReadyEffectNumber.alpha = 0
                                                                                    self.ReadyBG.alpha = 0
                                                                                    self.ReadyDart.alpha = 0
                                                                                    }, completion: { (bool) in
                                                                                        
                                                                                        self.startGame()
                                                                                })
                                                                        })
                                                                        
                                                                })
                                                        })
                                                        
                                                })
                                        })
                                })
                        })
                        
                })
        })

    }
    
    func startGame(){
        //print(Player)
        if GameMode == 1{
            self.performSegueWithIdentifier("P2P01", sender: Player)
        }else{
            self.performSegueWithIdentifier("P2PCR", sender: Player)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "P2P01" {
            let nextScene =  segue.destinationViewController as! P2P01ViewController
            if Player == 1 {
                nextScene.P1_Name = P1_Name.text
                nextScene.P2_Name = P2_Name.text
                nextScene.otherPlayerIDN = otherPlayerIDN
                nextScene.otherPlayerQuickBloxIDN = otherPlayerQuickBloxIDN
                nextScene.qbUser = qbUser
                nextScene.isMe = Player
            }else{
                nextScene.P1_Name = P2_Name.text
                nextScene.P2_Name = P1_Name.text
                nextScene.otherPlayerIDN = otherPlayerIDN
                nextScene.otherPlayerQuickBloxIDN = otherPlayerQuickBloxIDN
                nextScene.qbUser = qbUser
                nextScene.isMe = Player
            }
        }else{
            let nextScene =  segue.destinationViewController as! P2PCricketViewController
            if Player == 1 {
                nextScene.P1_Name = P1_Name.text
                nextScene.P2_Name = P2_Name.text
                nextScene.otherPlayerIDN = otherPlayerIDN
                nextScene.otherPlayerQuickBloxIDN = otherPlayerQuickBloxIDN
                nextScene.qbUser = qbUser
                nextScene.isMe = Player
            }else{
                nextScene.P1_Name = P2_Name.text
                nextScene.P2_Name = P1_Name.text
                nextScene.otherPlayerIDN = otherPlayerIDN
                nextScene.otherPlayerQuickBloxIDN = otherPlayerQuickBloxIDN
                nextScene.qbUser = qbUser
                nextScene.isMe = Player
            }

        }
        
    }
 
    
    func accept(){
        API.PlayerCheckStatus(userInfo.IDN!) { (dic) in
            print(dic)
            let tempCode = dic.valueForKey("ResponeCode")!.integerValue
            if tempCode == 205 {
                let tempData = dic.valueForKey("Detail")
                let tempArray = tempData as! NSMutableArray
                /*if self.Player == 1 {
                    self.otherPlayerIDN = tempArray.valueForKey("Player1_IDN").objectAtIndex(0) as! Int
                }*/
                dispatch_async(dispatch_get_main_queue(), {
                    /*if self.Player == 1 {
                        
                    }else{
                        self.readyToStart(tempArray.valueForKey("Player2_QB_IDN").objectAtIndex(0) as! UInt, GameRoom: tempArray.valueForKey("GameIDN").objectAtIndex(0) as! Int)
                    }*/
                    if self.Player == 1 {
                        self.readyToStart(UInt(tempArray.valueForKey("Player1_QB_IDN").objectAtIndex(0) as! NSNumber), GameRoom: tempArray.valueForKey("GameIDN").objectAtIndex(0) as! Int)
                        self.otherPlayerQuickBloxIDN = tempArray.valueForKey("Player2_QB_IDN").objectAtIndex(0) as! Int
                    }else{
                        self.readyToStart(UInt(tempArray.valueForKey("Player2_QB_IDN").objectAtIndex(0) as! NSNumber), GameRoom: tempArray.valueForKey("GameIDN").objectAtIndex(0) as! Int)
                        self.otherPlayerQuickBloxIDN = tempArray.valueForKey("Player1_QB_IDN").objectAtIndex(0) as! Int
                    }
                    
                });
            }
        }
    }

    @IBAction func YesPressed(sender: AnyObject) {
        Button_Yes.enabled = false
        socket.Accept()
    }
    
    @IBAction func NoPressed(sender: AnyObject) {
        socket.Decline()
    }
    
    
}
