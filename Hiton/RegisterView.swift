//
//  RegisterView.swift
//  Hiton
//
//  Created by yao on 08/06/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit
import RMActionController
import RMPickerViewController


class RegisterView: UIView, UITextFieldDelegate, UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet var TextField_Email: UITextField!
    @IBOutlet var TextField_Password: UITextField!
    @IBOutlet var TextField_CPassword: UITextField!
    
    @IBOutlet var Button_Male: UIButton!
    @IBOutlet var Button_Female: UIButton!
    @IBOutlet var Button_YOB: UIButton!
    @IBOutlet var Button_Country: UIButton!
    
    @IBOutlet var tac: FRHyperLabel!
    
    var userInfo = UserClass.sharedInstance
    var transferData: TransferData!
    var hud: MBProgressHUD!
    
    var gender = "Male"
    var ppd = 0.0
    var mpr = 0.0
    
    
    var registerSuccess: (() -> Void)?
    
    @IBOutlet weak var tableView: UITableView!
    var showPicker:String!
    var MA_Country = NSMutableArray()
    var MA_YOB = NSMutableArray()
    var myActionSheet:UIActionSheet!
    
    func getCurrentViewController() -> UIViewController? {
        
        if let rootController = UIApplication.sharedApplication().keyWindow?.rootViewController {
            var currentController: UIViewController! = rootController
            while( currentController.presentedViewController != nil ) {
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil
        
    }
    
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
        
        for i in 0...200 {
            MA_YOB.addObject(1900+i)
        }
        
        MA_Country.addObject("Malaysia")
        MA_Country.addObject("China")
        
        setTextFieldDelegate(TextField_Email)
        setTextFieldDelegate(TextField_Password)
        setTextFieldDelegate(TextField_CPassword)
        
        Button_Male.setImage(UIImage(named: "Register_Male_1"), forState: .Normal)
        
        transferData = NSBundle.mainBundle().loadNibNamed("TransferData", owner: self, options: nil).last as? TransferData
        transferData!.frame = self.bounds
        transferData.setup()
        transferData.Close_Pressed = {
            Void in
            self.callAPI()
        }
        transferData.YES_Pressed = {
            Void in
            self.ppd = self.userInfo.PPD
            self.mpr = self.userInfo.MPR
            self.callAPI()
        }
        transferData.NO_Pressed = {
            Void in
            self.callAPI()
        }
    }
    
    func setTextFieldDelegate(txt: UITextField){
        txt.delegate = self
        let spacerView = UIView(frame: CGRectMake(0, 0, 10, 10))
        txt.leftViewMode = .Always
        txt.leftView = spacerView
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == TextField_Email {
            textField.resignFirstResponder()
            TextField_Password.becomeFirstResponder()
        }else if textField == TextField_Password {
            textField.resignFirstResponder()
            TextField_CPassword.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        return true
    }


    @IBAction func malePressed(sender: AnyObject) {
        gender = "Male"
        Button_Male.setImage(UIImage(named: "Register_Male_1"), forState: .Normal)
        Button_Female.setImage(UIImage(named: "Register_Female_2"), forState: .Normal)
    }
    
    @IBAction func femalePressed(sender: AnyObject) {
        gender = "Female"
        Button_Male.setImage(UIImage(named: "Register_Male_2"), forState: .Normal)
        Button_Female.setImage(UIImage(named: "Register_Female_1"), forState: .Normal)
    }
    
    @IBAction func YOBPressed(sender: AnyObject) {
        showPicker = "YOB"
        self.openPickerViewController()
    }
    
    @IBAction func countryPressed(sender: AnyObject) {
        showPicker = "Country"
        self.openPickerViewController()
    }
    
    @IBAction func registerPressed(sender: AnyObject) {
        if myTools.isNotNull(TextField_Email){
            if myTools.isNotNull(TextField_Password){
                if myTools.isNotNull(TextField_CPassword){
                    if TextField_Password.text == TextField_CPassword.text {
                        //callAPI()
                        self.addSubview(transferData)
                    }
                }
            }
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if showPicker == "Country" {
            return MA_Country.count
        }else if showPicker == "YOB" {
            return MA_YOB.count
        }else{
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if showPicker == "Country"{
            return MA_Country.objectAtIndex(row) as? String
        }else if showPicker == "YOB"{
//            print(MA_YOB.objectAtIndex(row))
            return String(MA_YOB.objectAtIndex(row))
        }else{
            return ""
        }
    }

    
    func openPickerViewController() {
        let style = RMActionControllerStyle.White
        
        let selectAction = RMAction(title: "Select", style: RMActionStyle.Done) { controller in
            if let pickerController = controller as? RMPickerViewController {
                let selectedRows = NSMutableArray();
                
                for(var i=0 ; i<pickerController.picker.numberOfComponents ; i++) {
                    selectedRows.addObject(pickerController.picker.selectedRowInComponent(i));
                }
                
                //print("Successfully selected rows: ", selectedRows);
                if self.showPicker == "Country"{
                    self.Button_Country.setTitle(self.MA_Country[selectedRows[0] as! Int] as? String, forState: .Normal)
                }else if self.showPicker == "YOB"{
                    //self.t_State.text = self.MA_State[selectedRows[0] as! Int] as? String
                    self.Button_YOB.setTitle(String(self.MA_YOB[selectedRows[0] as! Int]), forState: .Normal)
                }
            }
        }
        
        let cancelAction = RMAction(title: "Cancel", style: RMActionStyle.Cancel) { _ in
            print("Row selection was canceled")
        }
        
        let actionController = RMPickerViewController(style: style, title: "", message: "", selectAction: selectAction, andCancelAction: cancelAction)!;
        
        actionController.picker.delegate = self;
        actionController.picker.dataSource = self;
        
        //On the iPad we want to show the date selection view controller within a popover. Fortunately, we can use iOS 8 API for this! :)
        //(Of course only if we are running on iOS 8 or later)
        if actionController.respondsToSelector(Selector("popoverPresentationController:")) && UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
            //First we set the modal presentation style to the popover style
            actionController.modalPresentationStyle = UIModalPresentationStyle.Popover
            
            
            
            //Then we tell the popover presentation controller, where the popover should appear
            if let popoverPresentationController = actionController.popoverPresentationController {
                popoverPresentationController.sourceView = self.tableView
                popoverPresentationController.sourceRect = self.tableView.rectForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
            }
            
            
        }
        //Now just present the date selection controller using the standard iOS presentation method
        //presentViewController(actionController, animated: true, completion: nil)
        //let storyboard: UIStoryboard = UIStoryboard (name: "Main", bundle: nil)
        //let vc: ProfileViewController = storyboard.instantiateViewControllerWithIdentifier("profile") as! ProfileViewController
        let currentController = self.getCurrentViewController()
        currentController?.presentViewController(actionController, animated: true, completion: nil)
    }
    
    func callAPI(){
        dispatch_async(dispatch_get_main_queue(), {
            self.hud = MBProgressHUD.showHUDAddedTo(self, animated: true)
            self.hud.label.text = "Loading"
            self.hud.dimBackground = true
        });
        let pathDocuments: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let textName: String = String(format: "/registerFile.txt")
        let createPath = pathDocuments.stringByAppendingString(textName)//stringByAppendingPathComponent(textName)
        //用文件名补全路径 }
        
        
        var Token: String!
        if let str = NSUserDefaults.standardUserDefaults().valueForKey("Token"){
            Token = str as? String
        }
        let datastr = "IDN=\(userInfo.IDN!)&EMAIL=\(TextField_Email.text!)&PASSWORD=\(TextField_Password.text!)&NAME=\(userInfo.Name!)&GENDER=\(gender)&COUNTRY=Malaysia&PPD=\(ppd)&MPR=\(mpr)"
        //IDN=1&EMAIL=test1@appverything.com&PASSWORD=123123&NAME=test1&GENDER=Female&COUNTRY=Malaysia&PPD=3.2&MPR=26.3
        print(datastr)
        do {
            try datastr.writeToFile(createPath as String, atomically: false, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print(error.localizedDescription);
        }
        let txtData = NSData(contentsOfFile: createPath as String)
        
        let urlString = "http://hiton.apsystem.solutions/handle/Player_RegisterAccount.ashx"
        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        request.HTTPMethod = "POST"
        let boundary = "---------------------------14737809831466499882746641449"
        let contentType = NSString(string: "multipart/form-data; boundary=\(boundary)")
        request.addValue(contentType as String, forHTTPHeaderField: "Content-Type")
        
        let body = NSMutableData()
        body.appendData("\r\n--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("Content-Disposition: form-data; name=\"userfile\"; filename=\"\(textName)\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("Content-Type: application/octet-stream\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(txtData!)
        body.appendData("\r\n--\(boundary)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        request.HTTPBody = body
        
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            //let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
            do {
                let dic:NSDictionary!
                try dic = NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                //print(dic)
                self.sendFileCompleted(dic)
                
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
            //print(response)
            //print(error)
        }).resume()
    }
    
    func sendFileCompleted(dic: NSDictionary){
        print(dic)
        let tempCode = dic.valueForKey("ResponeCode")!.integerValue
        switch tempCode{
        case 200:
            dispatch_async(dispatch_get_main_queue(), {
                MBProgressHUD.hideHUDForView(self, animated: true)
                let tempMessage = dic.valueForKey("ResponeMessage") as! String
                tools.ShowAlert("HitOn", tempMessage)
            })
            
            break
        case 201:
            
            break
        case 252:
            //userInfo 
            dispatch_async(dispatch_get_main_queue(), {
                MBProgressHUD.hideHUDForView(self, animated: true)
                let tempData = dic.valueForKey("Detail")
                let tempArray = tempData as! NSMutableArray
                
                self.userInfo.QBAccount = tempArray.objectAtIndex(0).valueForKey("QBAccount")?.integerValue
                self.userInfo.Name = tempArray.objectAtIndex(0).valueForKey("Name") as? String
                self.userInfo.Email = tempArray.objectAtIndex(0).valueForKey("Email") as? String
                self.userInfo.Gender = tempArray.objectAtIndex(0).valueForKey("Gender") as? String
                self.userInfo.PPD = tempArray.objectAtIndex(0).valueForKey("PPD")?.doubleValue
                self.userInfo.MPR = tempArray.objectAtIndex(0).valueForKey("MPR")?.doubleValue
                self.userInfo.Rank = tempArray.objectAtIndex(0).valueForKey("Rank")?.integerValue
                self.userInfo.Country = tempArray.objectAtIndex(0).valueForKey("Country") as? String
                self.userInfo.Identity = "Player"
                self.userInfo.Save()
                
                if let callback = self.registerSuccess {
                    callback()
                }
                self.removeFromSuperview()
            })
            
            break
            
        default:
            break
        }

    }
    
}
