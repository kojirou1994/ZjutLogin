//
//  LoginViewController.swift
//  ZjutLogin
//
//  Created by 王宇 on 16/1/31.
//  Copyright © 2016年 Kojirou. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        dm.loginWithUser(usernameTextField.text, and: passwordTextField.text) { (succ, info) -> Void in
            print(succ)
            if (succ) {
                self.presentViewController(self.storyboard!.instantiateViewControllerWithIdentifier("Main") as! UINavigationController, animated: true) {
                    self.usernameTextField.text = nil
                    self.passwordTextField.text = nil
                }
            }
            else {
                self.showAlert(nil, text: info)
            }
        }
    }
    @IBAction func RegisterButtonPressed(sender: AnyObject) {
        dm.register(usernameTextField.text, password: passwordTextField.text) { (succ, info) -> Void in
            if (succ) {
                self.loginButtonPressed(self.loginButton)
            }
            else {
                self.showAlert(nil, text: info)
            }
        }
    }
    @IBAction func guestButtonPressed(sender: AnyObject) {
        self.presentViewController(self.storyboard!.instantiateViewControllerWithIdentifier("Main") as! UINavigationController, animated: true, completion: nil)
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
