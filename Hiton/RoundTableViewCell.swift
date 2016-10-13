
//
//  RoundTableViewCell.swift
//  Hiton
//
//  Created by yao on 21/04/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class RoundTableViewCell: UITableViewCell {

    @IBOutlet var Round: UIImageView!
    @IBOutlet var RoundScore: UIImageView!
    @IBOutlet var RoundSelected: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func startAnimation(_player: Int){
        RoundSelected.image = UIImage(named: "P\(_player)_RoundSelect")
        UIView.animateWithDuration(0.4, animations: {
            if self.RoundSelected.alpha == 0 {
                self.RoundSelected.alpha = 1
            }else{
                self.RoundSelected.alpha = 0
            }
            }) { (bool) in
                UIView.animateWithDuration(0.4, animations: {
                    if self.RoundSelected.alpha == 0 {
                        self.RoundSelected.alpha = 1
                    }else{
                        self.RoundSelected.alpha = 0
                    }
                }) { (bool) in
                    UIView.animateWithDuration(0.4, animations: {
                        if self.RoundSelected.alpha == 0 {
                            self.RoundSelected.alpha = 1
                        }else{
                            self.RoundSelected.alpha = 0
                        }
                    }) { (bool) in
                        UIView.animateWithDuration(0.4, animations: {
                            if self.RoundSelected.alpha == 0 {
                                self.RoundSelected.alpha = 1
                            }else{
                                self.RoundSelected.alpha = 0
                            }
                        }) { (bool) in
                            UIView.animateWithDuration(0.4, animations: {
                                if self.RoundSelected.alpha == 0 {
                                    self.RoundSelected.alpha = 1
                                }else{
                                    self.RoundSelected.alpha = 0
                                }
                            }) { (bool) in
                                UIView.animateWithDuration(0.4, animations: {
                                    if self.RoundSelected.alpha == 0 {
                                        self.RoundSelected.alpha = 1
                                    }else{
                                        self.RoundSelected.alpha = 0
                                    }
                                }) { (bool) in
                                    UIView.animateWithDuration(0.4, animations: {
                                        if self.RoundSelected.alpha == 0 {
                                            self.RoundSelected.alpha = 1
                                        }else{
                                            self.RoundSelected.alpha = 0
                                        }
                                    }) { (bool) in
                                        self.RoundSelected.alpha = 1
                                    }
                                }
                            }
                        }
                    }
                }
        }
    }
    
}
