//
//  DataManager.swift
//  ZjutLogin
//
//  Created by 王宇 on 16/1/31.
//  Copyright © 2016年 Kojirou. All rights reserved.
//

import UIKit

public typealias LoginCompletionHandler = (succ: Bool, info: String?) -> Void
public let dataPath = NSHomeDirectory() + "/Documents/Data.plist"
var dm: DataManager!

class DataManager {
    var data: NSMutableDictionary!
    var currentUser: User?
    init() {
        data = NSMutableDictionary(contentsOfFile: dataPath)!
    }
    ///登录
    func loginWithUser(name: String?, and password: String?, completion: LoginCompletionHandler) {
        guard let un = name, pw = password else {
            completion(succ: false, info: "请填写用户名和密码")
            return
        }
        if (un == "" || pw == "") {
            completion(succ: false, info: "为空")
            return
        }
        if (un.containsString(" ") || pw.containsString(" ")) {
            completion(succ: false, info: "不能含有空格")
            return
        }
        if let userdata = data.valueForKey(un) {
            if let locked = userdata.valueForKey("locked") as? Bool {
                if (locked) {
                    completion(succ: false, info: "此账号已上锁")
                    return
                }
                else {
                    if let correctpw = userdata.valueForKey("password") as? String {
                        if (pw == correctpw) {
                            self.currentUser = User(username: un, type: (userdata.valueForKey("type") as? Int ?? 0) == 0 ? .User : .Admin)
                            completion(succ: true, info: nil)
                            return
                        }
                    }
                }
            }

        }
        completion(succ: false, info: "用户名或密码错误")
    }
    ///登出
    func logout() {
        currentUser = nil
    }

    func changeLockStateForUser(name: String, state: Bool) {
        if let userdata = data.valueForKey(name) {
            userdata.setValue(state, forKey: "locked")
//            data.setValue(userdata, forKey: name)
            save()
        }
    }
    func changePasswordForUser(name: String, password: String) {
        if let userdata = data.valueForKey(name) {
            userdata.setValue(password, forKey: "password")
//            data.setValue(userdata, forKey: name)
            save()
        }
    }
    func getDataForUser(name: String) -> (String, Bool, Int) {
        if let userdata = data.valueForKey(name) {
            if let locked = userdata.valueForKey("locked") as? Bool, password = userdata.valueForKey("password") as? String, type = userdata.valueForKey("type") as? Int {
                return (password, locked, type)
            }
        }
        return ("", false, 0)
    }
    func deleteUser(name: String) {
//        data.setNilValueForKey(name)
        data.removeObjectForKey(name)
        save()
    }
    func register(username: String?, password: String?, completion: (Bool, String?) -> Void) {
        if (username == nil || password == nil) {
            completion(false, "为空")
            return
        }
        if (username!.containsString(" ") || password!.containsString(" ")) {
            completion(false, "不能含有空格")
            return
        }
        for key in data.allKeys {
            if (key as! String == username!) {
                completion(false, "已有此用户")
                return
            }
        }
        let newdata = ["password": password!, "locked": false, "type": 0]
        self.data.setValue(newdata, forKey: username!)
        save()
        completion(true, nil)
    }
    func save() {
        data.writeToFile(dataPath, atomically: true)
        data = NSMutableDictionary(contentsOfFile: dataPath)!
    }
}

class User {
    var username: String!
//    var password: String!
    var type: UserType
    init(username: String, type: UserType) {
        self.username = username
//        self.password = password
        self.type = type
    }
}

public enum UserType {
    case Admin
    case User
}
extension UIViewController {
    func showAlert(title: String?, text: String?) {
        let a = UIAlertController(title: title, message: text, preferredStyle: .Alert)
        a.addAction(UIAlertAction(title: "确认", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(a, animated: true, completion: nil)
    }
}