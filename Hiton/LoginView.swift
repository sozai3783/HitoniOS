

//
//  LoginView.swift
//  Hiton
//
//  Created by yao on 08/06/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class LoginView: UIView, UITextFieldDelegate {

    @IBOutlet var TextField_Email: UITextField!
    @IBOutlet var TextField_Password: UITextField!
    @IBOutlet var Button_ForgotPassword: UIButton!
    
    @IBOutlet var tac: FRHyperLabel!
    
    var goRegister: (() -> Void)?
    var loginSuccess: (() -> Void)?
    
    var userInfo = UserClass.sharedInstance
    var API = DataClass.sharedInstance

    func setup(){
        let policyString = "You agree to the Terms & Conditions when you log in."
        let attributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSUnderlineStyleAttributeName: 0,
            NSFontAttributeName: UIFont(name: "Franklin Gothic Heavy", size: 9.0)!]
        let attributedString = NSMutableAttributedString(string: policyString, attributes: attributes)
        tac?.attributedText = attributedString
        tac?.textAlignment = .Center
        tac?.setLinkForSubstring("Terms & Conditions", withAttribute: [NSFontAttributeName: UIFont.boldSystemFontOfSize(9)], andLinkHandler: { label, string in
            UIApplication.sharedApplication().openURL(NSURL(string: "")!)
        })
        
        setTextFieldDelegate(TextField_Email)
        setTextFieldDelegate(TextField_Password)
    }
    
    func setTextFieldDelegate(txt: UITextField){
        txt.delegate = self
        let spacerView = UIView(frame: CGRectMake(0, 0, 10, 10))
        txt.leftViewMode = .Always
        txt.leftView = spacerView
    }
    
    @IBAction func closePressed(sender: AnyObject) {
        self.removeFromSuperview()
    }
    
    @IBAction func QQPressed(sender: AnyObject) {
    }
    
    @IBAction func FBPressed(sender: AnyObject) {
    }
    
    @IBAction func registerPressed(sender: AnyObject) {
        self.removeFromSuperview()
        if let callback = self.goRegister {
            callback()
        }
    }
    
    @IBAction func forgotPasswordPressed(sender: AnyObject) {
        
    }
    
    @IBAction func loginPressed(sender: AnyObject) {
        if myTools.isNotNull(TextField_Email){
            if myTools.isNotNull(TextField_Password){
                API.login(TextField_Email.text!, Password: TextField_Password.text!) { (dic) in
                    //do something
                    let tempCode = dic.valueForKey("ResponeCode")!.integerValue
                    switch tempCode{
                    case 101:
                        let tempMessage = dic.valueForKey("ResponeMessage") as! String
                        tools.ShowAlert("HitOn", tempMessage)
                        break
                    case 200:
                        dispatch_async(dispatch_get_main_queue(), {
                            let tempData = dic.valueForKey("Detail")
                            let tempArray = tempData as! NSMutableArray
                            
                            self.userInfo.IDN = tempArray.objectAtIndex(0).valueForKey("IDN")?.integerValue
                            self.userInfo.QBAccount = tempArray.objectAtIndex(0).valueForKey("QBAccount")?.integerValue
                            self.userInfo.Name = tempArray.objectAtIndex(0).valueForKey("Name") as? String
                            print(tempArray.objectAtIndex(0).valueForKey("Name") as? String)
                            self.userInfo.Email = tempArray.objectAtIndex(0).valueForKey("Email") as? String
                            self.userInfo.Gender = tempArray.objectAtIndex(0).valueForKey("Gender") as? String
                            self.userInfo.PPD = tempArray.objectAtIndex(0).valueForKey("PPD")?.doubleValue
                            self.userInfo.MPR = tempArray.objectAtIndex(0).valueForKey("MPR")?.doubleValue
                            self.userInfo.Rank = tempArray.objectAtIndex(0).valueForKey("Rank")?.integerValue
                            self.userInfo.Country = tempArray.objectAtIndex(0).valueForKey("Country") as? String
                            self.userInfo.Identity = "Player"
                            self.userInfo.Save()
                            if let callback = self.loginSuccess {
                                callback()
                            }
                            self.removeFromSuperview()
                        })
                    break
                    default:
                        break
                    }

                }
            }else{
                //password nil
            }
        }else{
            //email nil
        }
    }
}
