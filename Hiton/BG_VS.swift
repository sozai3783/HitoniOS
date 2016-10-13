//
//  BG_VS.swift
//  Hiton
//
//  Created by yao on 07/04/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class BG_VS: UIView {

    @IBOutlet var r_Dart: UIImageView!
    @IBOutlet var b_Dart: UIImageView!
    
    var timer: NSTimer!
    
    func startAnimation(){
        if timer != nil {
            timer.invalidate()
        }
        
        UIView.animateWithDuration(0.3, animations: {
            if self.r_Dart.alpha == 0 {
                self.r_Dart.alpha = 1
            }else{
                self.r_Dart.alpha = 0
            }
            if self.b_Dart.alpha == 0 {
                self.b_Dart.alpha = 1
            }else{
                self.b_Dart.alpha = 0
            }
            UIView.animateWithDuration(0.2, animations: {
                if self.r_Dart.alpha == 0 {
                    self.r_Dart.alpha = 1
                }else{
                    self.r_Dart.alpha = 0
                }
                if self.b_Dart.alpha == 0 {
                    self.b_Dart.alpha = 1
                }else{
                    self.b_Dart.alpha = 0
                }
            }) { (bool) in
                self.timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(BG_VS.startAnimation), userInfo: nil, repeats: false)
                
            }

        }) { (bool) in
            //self.timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(BG_VS.startAnimation), userInfo: nil, repeats: false)
            
        }

    }
    
    /*func bingbing(img: UIImageView){
        if timer != nil {
            timer.invalidate()
        }
        
        UIView.animateWithDuration(0.16, animations: {
            if img.alpha == 0 {
                img.alpha = 1
            }else{
                img.alpha = 0
            }
            }) { (bool) in
                self.timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(BG_VS.bingbing(img)), userInfo: nil, repeats: false)

        }
    }*/
    
    /*
     NSArray *imageNames = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg",
     @"5.jpg", @"6.jpg", @"7.jpg", @"8.jpg",
     @"9.jpg", @"10.jpg", @"12.jpg", @"12.jpg",
     @"13.jpg", @"14.jpg", @"15.jpg"];
     
     NSMutableArray *images = [[NSMutableArray alloc] init];
     for (int i = 0; i < imageNames.count; i++) {
     [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
     }
     
     // Normal Animation
     ImageView_Logo.animationImages = images;
     ImageView_Logo.animationDuration = 0.85;
     
     ImageView_Logo.animationRepeatCount = 1;
     [ImageView_Logo startAnimating];
     NSTimer *RandomTimer;
     RandomTimer = [NSTimer scheduledTimerWithTimeInterval:2.75 target:self selector:@selector(changeview) userInfo:nil repeats:NO];
     [ImageView_Logo setImage:[UIImage imageNamed:@"15.jpg"]];
     

     */

}
