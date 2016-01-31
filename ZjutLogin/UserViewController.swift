//
//  UserViewController.swift
//  ZjutLogin
//
//  Created by 王宇 on 16/1/31.
//  Copyright © 2016年 Kojirou. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let reuse = "UserMenuCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (dm.currentUser == nil) {
            self.navigationItem.title = "游客"
            infoLabel.text = "欢迎回来，游客！"
            tableView.hidden = true
        }
        else {
            switch (dm.currentUser!.type) {
            case .User:
                menu = userMenu
                self.navigationItem.title = "用户"
            case .Admin:
                menu = adminMenu
                self.navigationItem.title = "管理员"
            }
            infoLabel.text = "欢迎回来，" + dm.currentUser!.username + "！"
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登出", style: .Plain, target: self, action: "logout")
        self.edgesForExtendedLayout = UIRectEdge.None
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    let adminMenu = ["用户列表", "修改密码"]
    let userMenu = ["修改密码", "删除账号"]
    var menu: [String] = []
    func logout() {
        self.dismissViewControllerAnimated(true) { () -> Void in
            dm.logout()
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuse, forIndexPath: indexPath)
        cell.textLabel?.text = menu[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (dm.currentUser!.type) {
        case .User:
            if (indexPath.row == 0) {
                self.navigationController?.pushViewController(ChangePWViewController(), animated: true)
            }
            else if (indexPath.row == 1) {
                let a = UIAlertController(title: nil, message: "确定删除？", preferredStyle: .Alert)
                a.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil))
                a.addAction(UIAlertAction(title: "删除", style: UIAlertActionStyle.Destructive, handler: { (_) -> Void in
                    dm.deleteUser(dm.currentUser!.username)
                    self.logout()
                }))
                self.presentViewController(a, animated: true, completion: nil)
            }
        case .Admin:
            if (indexPath.row == 0) {
                self.navigationController?.pushViewController(UserDetailTableViewController(), animated: true)
            }
            else if (indexPath.row == 1) {
                self.navigationController?.pushViewController(ChangePWViewController(), animated: true)
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
