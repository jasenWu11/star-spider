//
//  ZhanyinViewController.swift
//  XZ
//
//  Created by wjz on 2018/12/21.
//  Copyright © 2018年 wjz. All rights reserved.
//

import UIKit
import Alamofire
class ZhanyinViewController: UIViewController {
    @IBOutlet weak var l_mm: UILabel!
    @IBOutlet weak var v_mm: UIView!
    @IBOutlet weak var v_ph: UIView!
    @IBOutlet weak var l_you: UILabel!
    @IBOutlet weak var tv_ph: UILabel!
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    var phoneph:String = ""
<<<<<<< HEAD

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "账号和隐私设置"
        let handLeftRight = UISwipeGestureRecognizer(target: self, action: #selector(funLeftRight))
        //handLeftRight.direction = .left //支持向左
        self.view.addGestureRecognizer(handLeftRight)
        
=======
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
        if UserDefaults.standard.object(forKey: "userPhoneNumber") != nil {
            phoneph = UserDefaults.standard.object(forKey: "userPhoneNumber") as! String
        }
        //修改手机视图
        v_ph.frame.origin.x = 0.0   //获取坐标x
        v_ph.frame.origin.y = 73.0  // 获取坐标Y
        v_ph.frame.size.width = screenWidth  //获取宽度
        v_ph.frame.size.height = 50  //获取高度
        //修改右括号
        l_you.frame.origin.x = screenWidth-10-13   //获取坐标x
        l_you.frame.origin.y = 13.0  // 获取坐标Y
        l_you.frame.size.width = 13.0  //获取宽度
        l_you.frame.size.height = 24  //获取高度
        //修改手机
        tv_ph.frame.origin.x = screenWidth-10-13-85-10   //获取坐标x
        tv_ph.frame.origin.y = 18.0  // 获取坐标Y
        tv_ph.frame.size.width = 85.0  //获取宽度
        tv_ph.frame.size.height = 17  //获取高度
        //修改密码界面
        v_mm.frame.origin.x = 0.0   //获取坐标x
        v_mm.frame.origin.y = 131.0  // 获取坐标Y
        v_mm.frame.size.width = screenWidth  //获取宽度
        v_mm.frame.size.height = 50  //获取高度
        //修改右括号
        l_mm.frame.origin.x = screenWidth-10-13   //获取坐标x
        l_mm.frame.origin.y = 13.0  // 获取坐标Y
        l_mm.frame.size.width = 13.0  //获取宽度
        l_mm.frame.size.height = 24  //获取高度
        // Do any additional setup after loading the view.
        if(phoneph != ""){
            tv_ph.text = replacePhone(phone: phoneph)
        }
        let upassclick = UITapGestureRecognizer(target: self, action: #selector(upassAction))
        v_mm.addGestureRecognizer(upassclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        v_mm.isUserInteractionEnabled = true
    }
    //替换字符串
    func replacePhone(phone:String) -> String {
        var a=NSString(string:phoneph)
        print("替换前：\(a)")
        var b=a.replacingCharacters(in: NSMakeRange(3, 4),with: "****")
        print("替换后：\(b)")
        return b
    }
    @objc func upassAction() -> Void {
<<<<<<< HEAD
        viewDidAppear1()
=======
        viewDidAppear()
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
<<<<<<< HEAD
    
    @objc func viewDidAppear1(){
        
        
        let alertController = UIAlertController(title: "修改密码",
                                                message: "请输入原始密码", preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "原密码"
            textField.addChangeTextTarget()
            textField.maxTextNumber = 12
            textField.isSecureTextEntry = true
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .destructive, handler: {
            action in
            //也可以用下标的形式获取textField let login = alertController.textFields![0]
            let oldpass = alertController.textFields!.first!
            var opass = oldpass.text
            print("原密码：\(oldpass.text)")
            if(opass == ""){
                self.showMsgbox(_message: "原密码不能为空")
            }
            else if((opass?.count)!<6){
                self.showMsgbox(_message: "密码不能小于6位数")
            }
            else if((opass?.count)!>12){
                self.showMsgbox(_message: "密码不能大于12位数")
            }
            else{
                self.viewDidAppear(oldpass: opass!)
            }
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func viewDidAppear(oldpass: String){
        
        
        let alertController = UIAlertController(title: "修改密码",
                                                message: "请输入原密码和新密码", preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "新密码"
            textField.addChangeTextTarget()
            textField.maxTextNumber = 12
            textField.isSecureTextEntry = true
        }
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "重复输入密码"
            textField.addChangeTextTarget()
            textField.maxTextNumber = 12
=======
    @objc func viewDidAppear(){
        
        
        let alertController = UIAlertController(title: "修改密码",
                                                message: "请输入原密码和新密码", preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "原密码"
        }
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "新密码"
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
            textField.isSecureTextEntry = true
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            //也可以用下标的形式获取textField let login = alertController.textFields![0]
<<<<<<< HEAD
            let newpass1 = alertController.textFields!.first!
            let newpass = alertController.textFields!.last!
            var npass1 = newpass1.text
            var npass = newpass.text
            print("用户名：\(newpass1.text) 密码：\(newpass.text)")
            if(npass1 == ""){
                self.showMsgbox(_message: "密码不能为空")
                return
            }
            else if((npass1?.count)!<6){
                self.showMsgbox(_message: "密码不能小于6位数")
                return
            }
            else if((npass1?.count)!>12){
                self.showMsgbox(_message: "密码不能大于6位数")
                return
            }
            if(npass == ""){
                self.showMsgbox(_message: "请重复输入密码")
                return
            }
            else if((npass?.count)!<6){
                self.showMsgbox(_message: "密码不能小于6位数")
                return
            }
            if(npass1 != npass){
                self.showMsgbox(_message: "两次输入密码不一致")
                return
            }
            else{
                self.UpdatepassRequest(oldpa: oldpass,newpass: npass!)
                return
=======
            let oldpass = alertController.textFields!.first!
            let newpass = alertController.textFields!.last!
            var opass = oldpass.text
            var npass = newpass.text
            print("用户名：\(oldpass.text) 密码：\(newpass.text)")
            if(opass == ""){
                self.showMsgbox(_message: "原密码不能为空")
            }
            if(npass == ""){
                self.showMsgbox(_message: "新密码不能为空")
            }
            else{
                self.UpdatepassRequest(oldpass: opass!,newpass: npass!)
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
            }
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func showMsgbox(_message: String, _title: String = "提示"){
        
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
        
    }
<<<<<<< HEAD
    func UpdatepassRequest(oldpa:String,newpass:String)  {
        
        let url = "https://www.xingzhu.club/XzTest/users/updatePwd"
        var userid:Int = UserDefaults.standard.object(forKey: "userId") as! Int
        let paras = ["userId":userid,"userPwdOld":oldpa,"userPwdNew":newpass] as [String : Any]
        print("用户id\(userid)旧密码\(oldpa)+新密码\(newpass)")
=======
    func UpdatepassRequest(oldpass:String,newpass:String)  {
        
        let url = "https://www.xingzhu.club/XzTest/users/updatePwd"
        var userid:Int = UserDefaults.standard.object(forKey: "userId") as! Int
        let paras = ["userId":userid,"userPwdOld":oldpass,"userPwdNew":newpass] as [String : Any]
        print("用户id\(userid)旧密码\(oldpass)+新密码\(newpass)")
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("jsonRequest:\(response.result)")
            if let data = response.result.value {
                let json = JSON(data)
                print("结果:\(json)")
                let code: Int = json["code"].int!
                print("错误:\(code)")
                var message:String = json["message"].string!
                //                if(erro == 0){
                let alertController = UIAlertController(title: message,
                                                        message: nil, preferredStyle: .alert)
                //显示提示框
                self.present(alertController, animated: true, completion: nil)
                //两秒钟后自动消失
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                    self.presentedViewController?.dismiss(animated: false, completion: nil)
                }
                if(message == "更新密码成功"){
                    UserDefaults.standard.set(newpass, forKey: "userPwd")
                    
                }
               
            }
            
        }
    }
<<<<<<< HEAD
    @objc func funLeftRight(sender: UIPanGestureRecognizer){
       
    }
    
=======
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
}
