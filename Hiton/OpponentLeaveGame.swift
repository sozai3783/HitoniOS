//
//  OpponentLeaveGame.swift
//  Hiton
//
//  Created by yao on 31/05/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class OpponentLeaveGame: UIView {
    
    var PlayerName: String!
    var MessageText: String!
    
    @IBOutlet var message: UILabel!
    
    var OK: (() -> Void)?
    

    func setMessage(){
        message.text = "\(PlayerName) has left the game."
    }
    
    @IBAction func OKPressed(sender: AnyObject) {
        if let callback = self.OK {
            callback()
        }
    }
}
