//
//  UserDetailTableViewCell.swift
//  ZjutLogin
//
//  Created by 王宇 on 16/1/31.
//  Copyright © 2016年 Kojirou. All rights reserved.
//

import UIKit

class UserDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var lockedLabel: UILabel!
    
    @IBOutlet weak var lockButton: UIButton!
    
    var username: String?
    var locked: Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(username: String) {
        var password: String
        var locked: Bool
        var type: Int
        (password, locked, type) = dm.getDataForUser(username)
        self.username = username
        self.locked = locked
        usernameLabel.text = "用户名：" + username
        passwordLabel.text = "密码：" + password
        print(password)
        lockedLabel.text = "上锁状态：" + (locked ? "已上锁" : "未上锁")
        typeLabel.text = "用户类型：" + (type == 1 ? "管理员" : "用户")
        lockButton.setTitle(locked ? "解锁" : "上锁", forState: .Normal)
    }
    
    @IBAction func lockButtonPressed(sender: AnyObject) {
        if (username != nil) {
            dm.changeLockStateForUser(username!, state: !locked)
            self.configCell(self.username!)
        }
    }
    
}
