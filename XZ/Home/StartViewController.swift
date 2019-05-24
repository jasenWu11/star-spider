//
//  StartViewController.swift
//  XZ
//
//  Created by wjz on 2018/12/27.
//  Copyright © 2018年 wjz. All rights reserved.
//

import UIKit
import Alamofire
class StartViewController: UIViewController {
    var olduser : String = ""
    var oldhead : String = ""
    var oldpwd : String = ""
    var zhmm : Int = 0
    var userId: Int = 0
    var userPwd: String = ""
    var userEmail: String = ""
    var userBalance: Double = 0.0
    var userProfilePhoto: String = ""
    var userName: String = ""
    var userRegisterTime: String = ""
    var isVip: Int = 0
    var userPhoneNumber: String =  ""
    var userPwdSalt: String =  ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        if UserDefaults.standard.object(forKey: "userPhoneNumber") != nil {
            olduser = UserDefaults.standard.object(forKey: "userPhoneNumber") as! String
            oldpwd = UserDefaults.standard.object(forKey: "userPwd") as! String
            
        }
        print("以前的文本框的值等于"+olduser)
        if UserDefaults.standard.object(forKey: "userProfilePhoto") != nil {
            oldhead = UserDefaults.standard.object(forKey: "userProfilePhoto") as! String
        }
        print("以前的头像等于"+oldhead)
        let time: TimeInterval = 2.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            //code
            if (self.olduser == ""){
                self.ToLoginAction()
            }
            else
            {
                self.textzm()
                print("手机号1\(self.olduser)和密码1\(self.oldpwd)")
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func ToLoginAction() -> Void {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: theloginUINavigationController())))
            as! theloginUINavigationController
       self.present(controller, animated: true, completion: nil)
    }
    @objc func ToMainAction() -> Void {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: MainViewController())))
            as! MainViewController
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

//    func jsonRequest()  {
//
//        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
//        Alamofire.request("http://119.29.88.72:8080/XzTest/user/connectTest", method: .post, parameters: [:], encoding: JSONEncoding.default, headers: nil)
//            .responseJSON { (response) in
//                print("jsonRequest:\(response.result)")
//
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                }
//        }
//    }
    func textzm(){
        let url = "https://www.xingzhu.club/XzTest/users/login"
        let paras = ["userPhoneNumber":self.olduser,"userPwd":self.oldpwd]
        print("手机号\(self.olduser)和密码\(self.oldpwd)")
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("jsonRequest:\(response.result)")
            if let jdata = response.result.value {
                let json = JSON(jdata)
                print("结果:\(json)")
                var code: Int = json["code"].int!
                print("错误:\(code)")
                var message: String = json["message"].string!

                if(message == "登录成功"){
                    let usermess = json["data"]
                    self.zhmm = 1
                    self.userId = usermess["userId"].int ?? 0
                    self.userPwd = self.oldpwd
                    self.userEmail = usermess["userEmail"].string ?? ""
                    self.userBalance = usermess["userBalance"].double ?? 0.0
                    self.userProfilePhoto = usermess["userProfilePhoto"].string ?? ""
                    self.userName = usermess["userName"].string ?? ""
                    self.userRegisterTime = usermess["userRegisterTime"].string ?? ""
                    self.isVip = usermess["isVip"].int ?? 0
                    self.userPhoneNumber = usermess["userPhoneNumber"].string ?? ""
                    self.userPwdSalt = usermess["userPwdSalt"].string ?? ""
                }
                else{
                    self.zhmm = 0
                }
                self.tomainor()
            }
        }
    }
    func tomainor() {
        if(self.zhmm == 1){
            self.ToMainAction()
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
        }
        else{
            let alertController = UIAlertController(title: "账号密码已修改，请重新登录",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            let time: TimeInterval = 1
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                self.ToLoginAction()
            }
        }
    }
    //Alamofire监控网络，只能调用一次监听一次
    func AlamofiremonitorNet() {
        let manager = NetworkReachabilityManager(host: "www.apple.com")
        manager?.listener = { status in
            print("网络状态: \(status)")
            if status == .reachable(.ethernetOrWiFi) { //WIFI
                print("wifi")
            } else if status == .reachable(.wwan) { // 蜂窝网络
                print("4G")
            } else if status == .notReachable { // 无网络
                print("无网络")
            } else { // 其他
                
            }
            
        }
        manager?.startListening()//开始监听网络
    }
    

}
