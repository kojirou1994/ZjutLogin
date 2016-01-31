//
//  ChangePWViewController.swift
//  ZjutLogin
//
//  Created by 王宇 on 16/1/31.
//  Copyright © 2016年 Kojirou. All rights reserved.
//

import UIKit

class ChangePWViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "修改密码"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func commitButtonPressed(sender: AnyObject) {
        guard let newp = passwordTextField.text else {
            return
        }
        dm.changePasswordForUser(dm.currentUser!.username, password: newp)
        self.navigationController?.popViewControllerAnimated(true)
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
