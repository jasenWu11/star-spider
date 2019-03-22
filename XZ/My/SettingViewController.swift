//
//  SettingViewController.swift
//  XZ
//
//  Created by wjz on 2018/12/21.
//  Copyright © 2018年 wjz. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var loset: UIButton!
    @IBOutlet weak var zhanyin: UIView!
    @IBOutlet weak var abus: UIView!
    var userId: String = ""
    var userPwd: String = ""
    var userEmail: String = ""
    var userBalance: String = ""
    var userProfilePhoto: String = ""
    var userName: String = ""
    var userRegisterTime: String = ""
    var isVip: String = ""
    var userPhoneNumber: String = ""
    var userPwdSalt: String = ""
    @IBAction func back(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "系统设置"
        let handLeftRight = UISwipeGestureRecognizer(target: self, action: #selector(funLeftRight))
        //handLeftRight.direction = .left //支持向左
        self.view.addGestureRecognizer(handLeftRight)
        
        let zhclick = UITapGestureRecognizer(target: self, action: #selector(zhAction))
        zhanyin.addGestureRecognizer(zhclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        zhanyin.isUserInteractionEnabled = true
        
        let abclick = UITapGestureRecognizer(target: self, action: #selector(abAction))
        abus.addGestureRecognizer(abclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        abus.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
        let losetclick = UITapGestureRecognizer(target: self, action: #selector(losetAction))
        loset.addGestureRecognizer(losetclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        loset.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    //点击事件方法
    @objc func zhAction() -> Void {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: ZhanyinViewController())))
            as! ZhanyinViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    //点击事件方法
    @objc func abAction() -> Void {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: AboutusViewController())))
            as! AboutusViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @objc func losetAction() -> Void {
        userId = ""
        userPwd = ""
        userEmail = ""
        userBalance = ""
        userProfilePhoto = ""
        userName = ""
        userRegisterTime = ""
        isVip = ""
        userPhoneNumber = ""
        userId = ""
        print("文本框的值等于"+userId)
        UserDefaults.standard.set(userId, forKey: "userId")
        UserDefaults.standard.set(userPwd, forKey: "userPwd")
        UserDefaults.standard.set(userEmail, forKey: "userEmail")
        UserDefaults.standard.set(userBalance, forKey: "userBalance")
        UserDefaults.standard.set(userProfilePhoto, forKey: "userProfilePhoto")
        UserDefaults.standard.set(userName, forKey: "userName")
        UserDefaults.standard.set(userRegisterTime, forKey: "userRegisterTime")
        UserDefaults.standard.set(isVip, forKey: "isVip")
        UserDefaults.standard.set(userPhoneNumber, forKey: "userPhoneNumber")
          UserDefaults.standard.set(userPwdSalt, forKey: "userPwdSalt")
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: LoginViewController())))
            as! LoginViewController
        self.present(controller, animated: true, completion: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func funLeftRight(sender: UIPanGestureRecognizer){
        
    }
}
