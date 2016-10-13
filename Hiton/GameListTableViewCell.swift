//
//  GameListTableViewCell.swift
//  Hiton
//
//  Created by yao on 04/05/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class GameListTableViewCell: UITableViewCell {

    @IBOutlet var PlayerName: UILabel!
    @IBOutlet var Rank: UILabel!
    @IBOutlet var Country: UILabel!
    
    @IBOutlet var BG: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        /*print("select")
        if selected == true {
            BG.image = UIImage(named: "Lobby_List_BG_Select")
        }*/
    }
    
}
