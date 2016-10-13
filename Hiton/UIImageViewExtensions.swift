//
//  UIImageViewExtensions.swift
//  懒人包开发
//
//  Created by yao on 13/03/2016.
//  Copyright © 2016 yao. All rights reserved.
//

import UIKit

extension UIImageView{
    func rotateRightAnimtation(){
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = 2 * M_PI
        rotationAnimation.duration = 10.0
        rotationAnimation.repeatCount = 1e100
        
        return self.layer.addAnimation(rotationAnimation, forKey: "transform.rotation")
    }
    
    func rotateLeftAnimtation(){
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 2 * M_PI
        rotationAnimation.toValue = 0.0
        rotationAnimation.duration = 10.0
        rotationAnimation.repeatCount = 1e100
        
        return self.layer.addAnimation(rotationAnimation, forKey: "transform.rotation")
    }
    
    func stopRotateAnimationStop(){
        return self.layer.removeAnimationForKey("transform.rotation")
    }
    
    func left_SlideLeft(img: UIImage){
        let tempX = self.layer.frame.origin.x
        UIView.animateWithDuration(0.1, animations: {
            self.layer.frame.origin.x = -self.layer.frame.size.width
            self.alpha = 0
        }) { (bool) in
            self.image = img
            self.layer.frame.origin.x = self.layer.frame.size.width + self.layer.frame.size.width/2
            UIView.animateWithDuration(0.2, animations: {
                self.layer.frame.origin.x = tempX
                    self.alpha = 1
                }) { (bool) in
                    
                }
        }
        
    }
    
    func left_SlideRight(img: UIImage){
        let tempX = self.layer.frame.origin.x
        UIView.animateWithDuration(0.1, animations: {
            self.layer.frame.origin.x = self.layer.frame.size.width + self.layer.frame.size.width/2
            self.alpha = 0
        }) { (bool) in
            self.image = img
            self.layer.frame.origin.x = -self.layer.frame.size.width
            UIView.animateWithDuration(0.2, animations: {
                self.layer.frame.origin.x = tempX
                self.alpha = 1
            }) { (bool) in
                
            }
        }
        
    }
    
    func right_SlideLeft(img: UIImage){
        let tempX = self.layer.frame.origin.x
        UIView.animateWithDuration(0.1, animations: {
            self.layer.frame.origin.x = tempX - self.layer.frame.size.width
            self.alpha = 0
        }) { (bool) in
            self.image = img
            self.layer.frame.origin.x = tempX + self.layer.frame.size.width
            UIView.animateWithDuration(0.2, animations: {
                self.layer.frame.origin.x = tempX
                self.alpha = 1
            }) { (bool) in
                
            }
        }
        
    }
    
    func right_SlideRight(img: UIImage){
        let tempX = self.layer.frame.origin.x
        UIView.animateWithDuration(0.1, animations: {
            self.layer.frame.origin.x = tempX + self.layer.frame.size.width + self.layer.frame.size.width/2
            self.alpha = 0
        }) { (bool) in
            self.image = img
            self.layer.frame.origin.x = tempX - self.layer.frame.size.width
            UIView.animateWithDuration(0.2, animations: {
                self.layer.frame.origin.x = tempX
                self.alpha = 1
            }) { (bool) in
                
            }
        }
    }
    
    func GamePicInit(){
        self.layer.frame = CGRectMake(self.layer.frame.origin.x, self.layer.frame.origin.y, 0, 0)
    }
    
    func GamePicAnimation(callback:() -> Void){
        let center = self.center
        let tempFrame = self.layer.frame
       self.layer.frame = CGRectMake(center.x, center.y, 0, 0)
        UIView.animateWithDuration(0.4) {
        }
        UIView.animateWithDuration(0.3, animations: {
            self.layer.frame = tempFrame
            }) { (bool) in
            callback()
        }
    }
    
    func drawMiddleScore(_p: Int = 0, _score: Int){
        var tempP: String?
        switch _p {
        case 1:
            tempP = "P1"
            break
        case 2:
            tempP = "P2"
            break
        case 3:
            tempP = "P3"
            break
        case 4:
            tempP = "P4"
            break
        default:
            break
        }
        var img1: UIImage, img2: UIImage, img3: UIImage, img4: UIImage
        let tempScore: NSString = "\(_score)"
        if tempScore.length == 4 {
            img1 = UIImage(named: "\(tempP!)_Big_\(tempScore.substringWithRange(NSMakeRange(0, 1)))")!
            img2 = UIImage(named: "\(tempP!)_Big_\(tempScore.substringWithRange(NSMakeRange(1, 1)))")!
            img3 = UIImage(named: "\(tempP!)_Big_\(tempScore.substringWithRange(NSMakeRange(2, 1)))")!
            img4 = UIImage(named: "\(tempP!)_Big_\(tempScore.substringWithRange(NSMakeRange(3, 1)))")!
            
            let size = CGSizeMake(img1.size.width + img2.size.width + img3.size.width + img4.size.width, img1.size.height)
            UIGraphicsBeginImageContext(size)
            img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
            img2.drawInRect(CGRect(x: img1.size.width, y: 0, width: img2.size.width, height: img1.size.height))
            img3.drawInRect(CGRect(x: img1.size.width + img2.size.width, y: 0, width: img3.size.width, height: img1.size.height))
            img4.drawInRect(CGRect(x: img1.size.width + img2.size.width + img3.size.width, y: 0, width: img4.size.width, height: img4.size.height))
            
        }else if tempScore.length == 3 {
            img1 = UIImage(named: "\(tempP!)_Big_\(tempScore.substringWithRange(NSMakeRange(0, 1)))")!
            img2 = UIImage(named: "\(tempP!)_Big_\(tempScore.substringWithRange(NSMakeRange(1, 1)))")!
            img3 = UIImage(named: "\(tempP!)_Big_\(tempScore.substringWithRange(NSMakeRange(2, 1)))")!
            
            let size = CGSizeMake(img1.size.width + img2.size.width + img3.size.width, img1.size.height)
            UIGraphicsBeginImageContext(size)
            img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
            img2.drawInRect(CGRect(x: img1.size.width, y: 0, width: img2.size.width, height: img1.size.height))
            img3.drawInRect(CGRect(x: img1.size.width + img2.size.width, y: 0, width: img3.size.width, height: img1.size.height))
        }else if tempScore.length == 2 {
            img1 = UIImage(named: "\(tempP!)_Big_\(tempScore.substringWithRange(NSMakeRange(0, 1)))")!
            img2 = UIImage(named: "\(tempP!)_Big_\(tempScore.substringWithRange(NSMakeRange(1, 1)))")!
            
            let size = CGSizeMake(img1.size.width + img2.size.width, img1.size.height)
            UIGraphicsBeginImageContext(size)
            img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
            img2.drawInRect(CGRect(x: img1.size.width, y: 0, width: img2.size.width, height: img1.size.height))
        }else if tempScore.length == 1 {
            img1 = UIImage(named: "\(tempP!)_Big_\(tempScore.substringWithRange(NSMakeRange(0, 1)))")!
            let size = CGSizeMake(img1.size.width, img1.size.height)
            UIGraphicsBeginImageContext(size)
            img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
        }
        
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.image = finalImage
    }

    
    func drawPlayerScoreGray(_score: Int){
        var img1: UIImage, img2: UIImage, img3: UIImage, img4: UIImage
        let tempScore: NSString = "\(_score)"
        if tempScore.length == 4 {
            img1 = UIImage(named: "Gray_\(tempScore.substringWithRange(NSMakeRange(0, 1)))")!
            img2 = UIImage(named: "Gray_\(tempScore.substringWithRange(NSMakeRange(1, 1)))")!
            img3 = UIImage(named: "Gray_\(tempScore.substringWithRange(NSMakeRange(2, 1)))")!
            img4 = UIImage(named: "Gray_\(tempScore.substringWithRange(NSMakeRange(3, 1)))")!
            
            let size = CGSizeMake(img1.size.width + img2.size.width + img3.size.width + img4.size.width, img1.size.height)
            UIGraphicsBeginImageContext(size)
            img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
            img2.drawInRect(CGRect(x: img1.size.width, y: 0, width: img2.size.width, height: img1.size.height))
            img3.drawInRect(CGRect(x: img1.size.width + img2.size.width, y: 0, width: img3.size.width, height: img1.size.height))
            img4.drawInRect(CGRect(x: img1.size.width + img2.size.width + img4.size.width, y: 0, width: img1.size.width, height: img1.size.height))
            
        }else if tempScore.length == 3 {
            img1 = UIImage(named: "Gray_\(tempScore.substringWithRange(NSMakeRange(0, 1)))")!
            img2 = UIImage(named: "Gray_\(tempScore.substringWithRange(NSMakeRange(1, 1)))")!
            img3 = UIImage(named: "Gray_\(tempScore.substringWithRange(NSMakeRange(2, 1)))")!
            
            let size = CGSizeMake(img1.size.width + img2.size.width + img3.size.width, img1.size.height)
            UIGraphicsBeginImageContext(size)
            img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
            img2.drawInRect(CGRect(x: img1.size.width, y: 0, width: img2.size.width, height: img1.size.height))
            img3.drawInRect(CGRect(x: img1.size.width + img2.size.width, y: 0, width: img3.size.width, height: img1.size.height))
            
            
        }else if tempScore.length == 2 {
            img1 = UIImage(named: "Gray_\(tempScore.substringWithRange(NSMakeRange(0, 1)))")!
            img2 = UIImage(named: "Gray_\(tempScore.substringWithRange(NSMakeRange(1, 1)))")!
            
            let size = CGSizeMake(img1.size.width + img2.size.width, img1.size.height)
            UIGraphicsBeginImageContext(size)
            img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
            img2.drawInRect(CGRect(x: img1.size.width, y: 0, width: img2.size.width, height: img1.size.height))
        }else if tempScore.length == 1 {
            img1 = UIImage(named: "Gray_\(tempScore.substringWithRange(NSMakeRange(0, 1)))")!
            let size = CGSizeMake(img1.size.width, img1.size.height)
            UIGraphicsBeginImageContext(size)
            img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
            
        }
        
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.image = finalImage
    }
    
    func drawPlayerScore(_p: Int = 0, _score: Int){
        var tempP: String?
        switch _p {
        case 1:
            tempP = "P1"
            break
        case 2:
            tempP = "P2"
            break
        case 3:
            tempP = "P3"
            break
        case 4:
            tempP = "P4"
            break
        default:
            break
        }
        var img1: UIImage, img2: UIImage, img3: UIImage, img4: UIImage
        let tempScore: NSString = "\(_score)"
        if tempScore.length == 4 {
            img1 = UIImage(named: "\(tempP!)_\(tempScore.substringWithRange(NSMakeRange(0, 1)))")!
            img2 = UIImage(named: "\(tempP!)_\(tempScore.substringWithRange(NSMakeRange(1, 1)))")!
            img3 = UIImage(named: "\(tempP!)_\(tempScore.substringWithRange(NSMakeRange(2, 1)))")!
            img4 = UIImage(named: "\(tempP!)_\(tempScore.substringWithRange(NSMakeRange(3, 1)))")!
            
            let size = CGSizeMake(img1.size.width + img2.size.width + img3.size.width + img4.size.width, img1.size.height)
            UIGraphicsBeginImageContext(size)
            img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
            img2.drawInRect(CGRect(x: img1.size.width, y: 0, width: img2.size.width, height: img1.size.height))
            img3.drawInRect(CGRect(x: img1.size.width + img2.size.width, y: 0, width: img3.size.width, height: img1.size.height))
            img4.drawInRect(CGRect(x: img1.size.width + img2.size.width + img4.size.width, y: 0, width: img1.size.width, height: img1.size.height))
            
        }else if tempScore.length == 3 {
            img1 = UIImage(named: "\(tempP!)_\(tempScore.substringWithRange(NSMakeRange(0, 1)))")!
            img2 = UIImage(named: "\(tempP!)_\(tempScore.substringWithRange(NSMakeRange(1, 1)))")!
            img3 = UIImage(named: "\(tempP!)_\(tempScore.substringWithRange(NSMakeRange(2, 1)))")!
            
            let size = CGSizeMake(img1.size.width + img2.size.width + img3.size.width, img1.size.height)
            UIGraphicsBeginImageContext(size)
            img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
            img2.drawInRect(CGRect(x: img1.size.width, y: 0, width: img2.size.width, height: img1.size.height))
            img3.drawInRect(CGRect(x: img1.size.width + img2.size.width, y: 0, width: img3.size.width, height: img1.size.height))
            
            
        }else if tempScore.length == 2 {
            img1 = UIImage(named: "\(tempP!)_\(tempScore.substringWithRange(NSMakeRange(0, 1)))")!
            img2 = UIImage(named: "\(tempP!)_\(tempScore.substringWithRange(NSMakeRange(1, 1)))")!
            
            let size = CGSizeMake(img1.size.width + img2.size.width, img1.size.height)
            UIGraphicsBeginImageContext(size)
            img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
            img2.drawInRect(CGRect(x: img1.size.width, y: 0, width: img2.size.width, height: img1.size.height))
        }else if tempScore.length == 1 {
            img1 = UIImage(named: "\(tempP!)_\(tempScore.substringWithRange(NSMakeRange(0, 1)))")!
            let size = CGSizeMake(img1.size.width, img1.size.height)
            UIGraphicsBeginImageContext(size)
            img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
            
        }
        
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.image = finalImage
    }
    
    func drawRound(_player: Int, _now: Int, _max: Int){
        var img1: UIImage, img2: UIImage, img3: UIImage, img4: UIImage, img5: UIImage
        let tempNow: NSString = "\(_now)"
        let tempMax: NSString = "\(_max)"
        
        if tempMax.length == 1 {
            if tempNow.length == 1 {
                img1 = UIImage(named: "P\(_player)_Round_\(tempNow.substringWithRange(NSMakeRange(0, 1)))")!
                img2 = UIImage(named: "RNext")!
                img3 = UIImage(named: "R\(tempMax.substringWithRange(NSMakeRange(0, 1)))")!
                
                let size = CGSizeMake(img1.size.width + img2.size.width + img3.size.width, img1.size.height)
                UIGraphicsBeginImageContext(size)
                img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
                img2.drawInRect(CGRect(x: img1.size.width, y: 0, width: img2.size.width, height: img1.size.height))
                img3.drawInRect(CGRect(x: img1.size.width + img2.size.width, y: 0, width: img3.size.width, height: img1.size.height))
            }else if tempNow.length == 2{
                img1 = UIImage(named: "RY\(tempNow.substringWithRange(NSMakeRange(0, 1)))")!
                img2 = UIImage(named: "RNext")!
                img3 = UIImage(named: "R\(tempMax.substringWithRange(NSMakeRange(0, 1)))")!
                
                let size = CGSizeMake(img1.size.width + img2.size.width + img3.size.width, img1.size.height)
                UIGraphicsBeginImageContext(size)
                img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
                img2.drawInRect(CGRect(x: img1.size.width, y: 0, width: img2.size.width, height: img1.size.height))
                img3.drawInRect(CGRect(x: img1.size.width + img2.size.width, y: 0, width: img3.size.width, height: img1.size.height))
                           }

        }else{
            if tempNow.length == 1 {
                img1 = UIImage(named: "P\(_player)_Round_\(tempNow.substringWithRange(NSMakeRange(0, 1)))")!
                img2 = UIImage(named: "RNext")!
                img3 = UIImage(named: "R\(tempMax.substringWithRange(NSMakeRange(0, 1)))")!
                img4 = UIImage(named: "R\(tempMax.substringWithRange(NSMakeRange(1, 1)))")!
                
                let size = CGSizeMake(img1.size.width + img2.size.width + img3.size.width + img4.size.width, img1.size.height)
                UIGraphicsBeginImageContext(size)
                img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
                img2.drawInRect(CGRect(x: img1.size.width, y: 0, width: img2.size.width, height: img1.size.height))
                img3.drawInRect(CGRect(x: img1.size.width + img2.size.width, y: 0, width: img3.size.width, height: img1.size.height))
                img4.drawInRect(CGRect(x: img1.size.width + img2.size.width + img3.size.width, y: 0, width: img4.size.width, height: img1.size.height))
            }else if tempNow.length == 2{
                img1 = UIImage(named: "RY\(tempNow.substringWithRange(NSMakeRange(0, 1)))")!
                img2 = UIImage(named: "RY\(tempNow.substringWithRange(NSMakeRange(1, 1)))")!
                img3 = UIImage(named: "RNext")!
                img4 = UIImage(named: "R\(tempMax.substringWithRange(NSMakeRange(0, 1)))")!
                img5 = UIImage(named: "R\(tempMax.substringWithRange(NSMakeRange(1, 1)))")!
                
                let size = CGSizeMake(img1.size.width + img2.size.width + img3.size.width + img4.size.width + img5.size.width, img1.size.height)
                UIGraphicsBeginImageContext(size)
                img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
                img2.drawInRect(CGRect(x: img1.size.width, y: 0, width: img2.size.width, height: img1.size.height))
                img3.drawInRect(CGRect(x: img1.size.width + img2.size.width, y: 0, width: img3.size.width, height: img1.size.height))
                img4.drawInRect(CGRect(x: img1.size.width + img2.size.width + img3.size.width, y: 0, width: img4.size.width, height: img1.size.height))
                img5.drawInRect(CGRect(x: img1.size.width + img2.size.width + img3.size.width + img5.size.width, y: 0, width: img5.size.width, height: img1.size.height))
            }

        }
        
        let rImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.image = rImage
        
    }
    
    func drawPPD(_ppd: CGFloat){
        var img1: UIImage, img2: UIImage, img3: UIImage, img4: UIImage, img5: UIImage
        let temPPD: NSString = "\(_ppd)"
        if temPPD.length == 3 {
            img1 = UIImage(named: "GI_PPD\(temPPD.substringWithRange(NSMakeRange(0, 1)))")!
            img2 = UIImage(named: "GI_Dot")!
            img3 = UIImage(named: "GI_PPD\(temPPD.substringWithRange(NSMakeRange(2, 1)))")!
            let size = CGSizeMake(img1.size.width + img2.size.width + img3.size.width, img1.size.height)
            UIGraphicsBeginImageContext(size)
            img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
            img2.drawInRect(CGRect(x: img1.size.width, y: 0, width: img2.size.width, height: img1.size.height))
            img3.drawInRect(CGRect(x: img1.size.width + img2.size.width, y: 0, width: img3.size.width, height: img1.size.height))

        }else if temPPD.length == 4 {
            img1 = UIImage(named: "GI_PPD\(temPPD.substringWithRange(NSMakeRange(0, 1)))")!
            img2 = UIImage(named: "GI_PPD\(temPPD.substringWithRange(NSMakeRange(1, 1)))")!
            img3 = UIImage(named: "GI_Dot")!
            img4 = UIImage(named: "GI_PPD\(temPPD.substringWithRange(NSMakeRange(3, 1)))")!
            let size = CGSizeMake(img1.size.width + img2.size.width + img3.size.width + img4.size.width, img1.size.height)
            UIGraphicsBeginImageContext(size)
            img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
            img2.drawInRect(CGRect(x: img1.size.width, y: 0, width: img2.size.width, height: img1.size.height))
            img3.drawInRect(CGRect(x: img1.size.width + img2.size.width, y: 0, width: img3.size.width, height: img1.size.height))
            img4.drawInRect(CGRect(x: img1.size.width + img2.size.width + img3.size.width, y: 0, width: img4.size.width, height: img1.size.height))
        }else if temPPD.length == 5 {
            img1 = UIImage(named: "GI_PPD\(temPPD.substringWithRange(NSMakeRange(0, 1)))")!
            img2 = UIImage(named: "GI_PPD\(temPPD.substringWithRange(NSMakeRange(2, 1)))")!
            img3 = UIImage(named: "GI_PPD\(temPPD.substringWithRange(NSMakeRange(3, 1)))")!
            img4 = UIImage(named: "GI_Dot")!
            img5 = UIImage(named: "GI_PPD\(temPPD.substringWithRange(NSMakeRange(4, 1)))")!
            let size = CGSizeMake(img1.size.width + img2.size.width + img3.size.width + img4.size.width + img5.size.width, img1.size.height)
            UIGraphicsBeginImageContext(size)
            img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
            img2.drawInRect(CGRect(x: img1.size.width, y: 0, width: img2.size.width, height: img1.size.height))
            img3.drawInRect(CGRect(x: img1.size.width + img2.size.width, y: 0, width: img3.size.width, height: img1.size.height))
            img4.drawInRect(CGRect(x: img1.size.width + img2.size.width + img3.size.width, y: 0, width: img4.size.width, height: img1.size.height))
            img4.drawInRect(CGRect(x: img1.size.width + img2.size.width + img3.size.width + img4.size.width, y: 0, width: img5.size.width, height: img1.size.height))

        }
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.image = finalImage
    }
    
    func drawRound(_r: Int){
        var img1: UIImage, img2: UIImage, img3: UIImage
        let tempRound: NSString = "\(_r)"
        if tempRound.length == 1 {
            img1 = UIImage(named: "R")!
            img2 = UIImage(named: "R\(tempRound.substringWithRange(NSMakeRange(0, 1)))")!
            let size = CGSizeMake(img1.size.width + img2.size.width, img1.size.height)
            UIGraphicsBeginImageContext(size)
            img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
            img2.drawInRect(CGRect(x: img1.size.width, y: 0, width: img2.size.width, height: img1.size.height))

            
        }else if tempRound.length == 2 {
            img1 = UIImage(named: "R")!
            img2 = UIImage(named: "R\(tempRound.substringWithRange(NSMakeRange(0, 1)))")!
            img3 = UIImage(named: "R\(tempRound.substringWithRange(NSMakeRange(1, 1)))")!
            let size = CGSizeMake(img1.size.width + img2.size.width + img3.size.width, img1.size.height)
            UIGraphicsBeginImageContext(size)
            img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
            img2.drawInRect(CGRect(x: img1.size.width + 1, y: 0, width: img2.size.width, height: img1.size.height))
            img3.drawInRect(CGRect(x: img1.size.width + img2.size.width, y: 0, width: img3.size.width, height: img1.size.height))
        }
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.image = finalImage

    }
    
    func drawHalf(){
        var img1: UIImage
        img1 = UIImage(named: "Round_Half")!
        let size = CGSizeMake(img1.size.width, img1.size.height)
        UIGraphicsBeginImageContext(size)
        img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.image = finalImage
    }
    
    func drawDartScore(_SDTB: String, _score: Int){
        self.stopAnimating()
        var img1: UIImage, img2: UIImage, img3: UIImage
        
        if _score == 25 || _score == 50 || _score == 75 || _score == 100 {
            img1 = UIImage(named: "\(_SDTB)")!
            let size = CGSizeMake(img1.size.width, img1.size.height)
            UIGraphicsBeginImageContext(size)
            img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
        }else if _score == 0 {
            img1 = UIImage(named: "Miss")!
            let size = CGSizeMake(img1.size.width, img1.size.height)
            UIGraphicsBeginImageContext(size)
            img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
        }else{
            let tempScore: NSString = "\(_score)"
            var tempStr = ""
            if _SDTB == "Triple" {
                tempStr = "T"
            }else if _SDTB == "Double" {
                tempStr = "D"
            }else if _SDTB == "Single" {
                tempStr = "S"
            }
            
            if tempScore.length == 1 {
                img1 = UIImage(named: "\(_SDTB)")!
                img2 = UIImage(named: "\(tempStr)\(tempScore.substringWithRange(NSMakeRange(0, 1)))")!
                let size = CGSizeMake(img1.size.width + img2.size.width, img1.size.height)
                UIGraphicsBeginImageContext(size)
                img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
                img2.drawInRect(CGRect(x: img1.size.width + 3, y: 0, width: img2.size.width, height: img1.size.height))
            }else if tempScore.length == 2 {
                img1 = UIImage(named: "\(_SDTB)")!
                img2 = UIImage(named: "\(tempStr)\(tempScore.substringWithRange(NSMakeRange(0, 1)))")!
                img3 = UIImage(named: "\(tempStr)\(tempScore.substringWithRange(NSMakeRange(1, 1)))")!
                let size = CGSizeMake(img1.size.width + img2.size.width + img3.size.width, img1.size.height)
                UIGraphicsBeginImageContext(size)
                img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
                img2.drawInRect(CGRect(x: img1.size.width + 3, y: 0, width: img2.size.width, height: img1.size.height))
                img3.drawInRect(CGRect(x: img1.size.width + img2.size.width, y: 0, width: img3.size.width, height: img1.size.height))
            }
        }
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.image = finalImage
    }

    func resetDartScore(_player: Int){
        self.stopAnimating()
        let image = UIImage(named: "GrayDart")
        self.image = image
    }
    
    func Smile_Play(){
        let images = [UIImage(named: "Smile_1")!, UIImage(named: "Smile_2")!]
        
        self.animationImages = images
        self.animationRepeatCount = 5
        self.animationDuration = 0.2
        self.startAnimating()
    }
    
    func dartTurnCircle(_p: Int){
        var tempP: String?
        switch _p {
        case 1:
            tempP = "P1"
            break
        case 2:
            tempP = "P2"
            break
        case 3:
            tempP = "P3"
            break
        case 4:
            tempP = "P4"
            break
        default:
            break
        }
        let images = [
            UIImage(named: "\(tempP!)_Dart_1")!,
            UIImage(named: "\(tempP!)_Dart_2")!,
            UIImage(named: "\(tempP!)_Dart_3")!,
            UIImage(named: "\(tempP!)_Dart_4")!,
            UIImage(named: "\(tempP!)_Dart_5")!,
            UIImage(named: "\(tempP!)_Dart_6")!,
            UIImage(named: "\(tempP!)_Dart_7")!,
            UIImage(named: "\(tempP!)_Dart_8")!,
            UIImage(named: "\(tempP!)_Dart_9")!,
            UIImage(named: "\(tempP!)_Dart_10")!,]
        self.animationImages = images
        self.animationDuration = 1
        self.animationRepeatCount = -1
        self.startAnimating()
    }
    
    func countDown(){
        let images = [
            UIImage(named: "Room_10")!,
            UIImage(named: "Room_9")!,
            UIImage(named: "Room_8")!,
            UIImage(named: "Room_7")!,
            UIImage(named: "Room_6")!,
            UIImage(named: "Room_5")!,
            UIImage(named: "Room_4")!,
            UIImage(named: "Room_3")!,
            UIImage(named: "Room_2")!,
            UIImage(named: "Room_1")!,]
        self.animationImages = images
        self.animationDuration = 10
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    /*func readyCountDown(){
        let images = [
            UIImage(named: "Ready_5")!,
            UIImage(named: "Ready_4")!,
            UIImage(named: "Ready_3")!,
            UIImage(named: "Ready_2")!,
            UIImage(named: "Ready_1")!]
        self.animationImages = images
        self.animationDuration = 5
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    func readyEffectCountDown(){
        let images = [
            UIImage(named: "Ready_5_5")!,
            UIImage(named: "Ready_4_4")!,
            UIImage(named: "Ready_3_3")!,
            UIImage(named: "Ready_2_2")!,
            UIImage(named: "Ready_1_1")!]
        self.animationImages = images
        self.animationDuration = 5
        self.animationRepeatCount = 0
        self.startAnimating()
    }*/

    
    func drawRoundScore(_score: Int){
        var img1: UIImage, img2: UIImage, img3: UIImage
        let tempScore: NSString = "\(_score)"
        if tempScore.length == 3 {
            img1 = UIImage(named: "R\(tempScore.substringWithRange(NSMakeRange(0, 1)))")!
            img2 = UIImage(named: "R\(tempScore.substringWithRange(NSMakeRange(1, 1)))")!
            img3 = UIImage(named: "R\(tempScore.substringWithRange(NSMakeRange(2, 1)))")!
            
            let size = CGSizeMake(img1.size.width + img2.size.width + img3.size.width, img1.size.height)
            UIGraphicsBeginImageContext(size)
            img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
            img2.drawInRect(CGRect(x: img1.size.width, y: 0, width: img2.size.width, height: img1.size.height))
            img3.drawInRect(CGRect(x: img1.size.width + img2.size.width, y: 0, width: img3.size.width, height: img1.size.height))
            
            
        }else if tempScore.length == 2 {
            img1 = UIImage(named: "R\(tempScore.substringWithRange(NSMakeRange(0, 1)))")!
            img2 = UIImage(named: "R\(tempScore.substringWithRange(NSMakeRange(1, 1)))")!
            
            let size = CGSizeMake(img1.size.width + img2.size.width, img1.size.height)
            UIGraphicsBeginImageContext(size)
            img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
            img2.drawInRect(CGRect(x: img1.size.width, y: 0, width: img2.size.width, height: img1.size.height))
        }else if tempScore.length == 1 {
            img1 = UIImage(named: "R\(tempScore.substringWithRange(NSMakeRange(0, 1)))")!
            let size = CGSizeMake(img1.size.width, img1.size.height)
            UIGraphicsBeginImageContext(size)
            img1.drawInRect(CGRect(x: 0, y: 0, width: img1.size.width, height: img1.size.height))
            
        }
        
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.image = finalImage

    }
}

extension UIView{
    func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
}