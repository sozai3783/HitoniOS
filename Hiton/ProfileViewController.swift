


//
//  ProfileViewController.swift
//  Hiton
//
//  Created by yao on 26/05/2016.
//  Copyright © 2016 apsystem. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var Avatar: UIImageView!
    
    @IBOutlet var Name: UITextField!
    @IBOutlet var PPD: UILabel!
    @IBOutlet var MPR: UILabel!
    @IBOutlet var Country: UITextField!
    @IBOutlet var Gender: UIImageView!
    
    @IBOutlet var Button_Edit: UIButton!
    @IBOutlet var Button_Logout: UIButton!
    @IBOutlet var Button_Back: UIButton!
    
    @IBOutlet var Button_ChangePassword: UIButton!
    @IBOutlet var Button_Save: UIButton!
    @IBOutlet var Button_Cancel: UIButton!
    
    @IBOutlet var Edit_Male: UIButton!
    @IBOutlet var Edit_Female: UIButton!
    
    
    var userInfo = UserClass.sharedInstance
    var API = DataClass.sharedInstance
    
    var loginView: LoginView!
    var registerView: RegisterView!
    var logoutView: LogoutView!
    
    var userIsEditing = false
    var editGender: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Name.userInteractionEnabled = false
        Country.userInteractionEnabled = false
        
        Button_ChangePassword.hidden = true
        Button_Save.hidden = true
        Button_Cancel.hidden = true
        
        Edit_Male.hidden = true
        Edit_Female.hidden = true
        
        setupCustomView()
        
        if userInfo.Identity == "Guest" {
            self.view.addSubview(loginView)
        }else{
            /*API.getPlayerDetails(userInfo.IDN!, callback: { (dic) in
                let tempData = dic.valueForKey("Detail")
                let tempArray = tempData as! NSMutableArray
                if let _name = tempArray.objectAtIndex(0).valueForKey("Name"){
                    self.Name.text = "\(_name)"
                }
                self.PPD.text = "\(tempArray.objectAtIndex(0).valueForKey("PPD")?.doubleValue!)"
                self.MPR.text = "\(tempArray.objectAtIndex(0).valueForKey("MPR")?.doubleValue!)"
                self.Country.text = "\(tempArray.objectAtIndex(0).valueForKey("Country")!)"
                self.Gender.image = UIImage(named: self.userInfo.Gender == "Male" ? "Profile_Male" : "Profile_Female" )
            })*/
            Name.text = userInfo.Name!
            Country.text = userInfo.Country!
            PPD.text = "\(userInfo.PPD!)"
            MPR.text = "\(userInfo.MPR!)"
            Gender.image = UIImage(named: userInfo.Gender == "Male" ? "Profile_Male" : "Profile_Female" )
            editGender = userInfo.Gender
            print(userInfo.Gender)
        }
    }
    
    func setupCustomView(){
        registerView = NSBundle.mainBundle().loadNibNamed("RegisterView", owner: self, options: nil).last as? RegisterView
        registerView!.frame = self.view.bounds
        registerView.setup()
        registerView.registerSuccess = {
            Void in
            self.Name.text = "\(self.userInfo.Name!)"
            self.PPD.text = "\(self.userInfo.PPD!)"
            self.MPR.text = "\(self.userInfo.MPR!)"
            self.Country.text = "\(self.userInfo.Country!)"
            self.Gender.image = UIImage(named: self.userInfo.Gender == "Male" ? "Profile_Male" : "Profile_Female" )
        }
        
        loginView = NSBundle.mainBundle().loadNibNamed("LoginView", owner: self, options: nil).last as? LoginView
        loginView!.frame = self.view.bounds
        loginView.setup()
        loginView.goRegister = {
            Void in
            self.view.addSubview(self.registerView)
        }
        loginView.loginSuccess = {
            Void in
            self.Name.text = "\(self.userInfo.Name!)"
            self.PPD.text = "\(self.userInfo.PPD!)"
            self.MPR.text = "\(self.userInfo.MPR!)"
            self.Country.text = "\(self.userInfo.Country!)"
            self.Gender.image = UIImage(named: self.userInfo.Gender == "Male" ? "Profile_Male" : "Profile_Female" )
        }
        
        logoutView = NSBundle.mainBundle().loadNibNamed("LogoutView", owner: self, options: nil).last as? LogoutView
        logoutView!.frame = self.view.bounds

    }
    
    func reset(){
        Name.userInteractionEnabled = false
        Name.background = UIImage(named: "")
        Country.userInteractionEnabled = false
        Country.background = UIImage(named: "")
        
        Button_ChangePassword.hidden = true
        Button_Save.hidden = true
        Button_Cancel.hidden = true
        
        Gender.hidden = false
        Edit_Male.hidden = true
        Edit_Female.hidden = true
        
        Button_Logout.hidden = false
    }
    
    func refreshData(){
        self.Name.text = "\(self.userInfo.Name!)"
        self.PPD.text = "\(self.userInfo.PPD!)"
        self.MPR.text = "\(self.userInfo.MPR!)"
        self.Country.text = "\(self.userInfo.Country!)"
        self.Gender.image = UIImage(named: self.userInfo.Gender == "Male" ? "Profile_Male" : "Profile_Female" )

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func EditPressed(sender: AnyObject) {
        Name.userInteractionEnabled = true
        Name.background = UIImage(named: "Edit_TextBox")
        Country.userInteractionEnabled = true
        Country.background = UIImage(named: "Edit_TextBox")
        
        Button_ChangePassword.hidden = false
        Button_Save.hidden = false
        Button_Cancel.hidden = false
        
        Gender.hidden = true
        Edit_Male.hidden = false
        Edit_Female.hidden = false

        Button_Logout.hidden = true
    }
    
    @IBAction func Edit_Male_Pressed(sender: AnyObject) {
        Edit_Male.setImage(UIImage(named: "Edit_Male_2"), forState: .Normal)
        Edit_Female.setImage(UIImage(named: "Edit_Female_1"), forState: .Normal)
        editGender = "Male"
    }
    
    @IBAction func Edit_Female_Pressed(sender: AnyObject) {
        Edit_Male.setImage(UIImage(named: "Edit_Male_1"), forState: .Normal)
        Edit_Female.setImage(UIImage(named: "Edit_Female_2"), forState: .Normal)
        editGender = "Female"
    }
    
    
    @IBAction func LogoutPressed(sender: AnyObject) {
        self.view.addSubview(logoutView)
    }
    
    @IBAction func ChangePasswordPressed(sender: AnyObject) {
        //reset()
    }
    
    @IBAction func SavePressed(sender: AnyObject) {
        API.updateProfile(userInfo.IDN!, Name: Name.text!, Country: Country.text!, Gender: editGender!) { (tempDic) in
            print(tempDic)
            let tempCode = tempDic.valueForKey("ResponeCode")!.integerValue
            switch tempCode {
            case 252:
                let tempData = tempDic.valueForKey("Detail")
                let tempArray = tempData as! NSMutableArray
                self.userInfo.Name = tempArray.objectAtIndex(0).valueForKey("Name") as? String
                self.userInfo.Country = tempArray.objectAtIndex(0).valueForKey("Country") as? String
                self.userInfo.Gender = tempArray.objectAtIndex(0).valueForKey("Gender") as? String
                self.userInfo.Save()
                self.reset()
                self.refreshData()
                break
            default:
                break
            }
        }
        //reset()
    }
    
    @IBAction func CancelPressed(sender: AnyObject) {
        reset()
    }
    
    
    @IBAction func BackPressed(sender: AnyObject) {
        print("Touch Back")
        dispatch_async(dispatch_get_main_queue(), {
            self.navigationController?.popViewControllerAnimated(false)
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
