//
//  RegisterViewController.swift
//  XZ
//
//  Created by wjz on 2018/12/27.
//  Copyright © 2018年 wjz. All rights reserved.
//

import UIKit
import Alamofire
class RegisterViewController: UIViewController {

    @IBOutlet weak var tv_phone: UITextField!
    @IBOutlet weak var bt_Yz: UIButton!
    @IBOutlet weak var tv_pass: UITextField!
    @IBOutlet weak var tv_yanzh: UITextField!
    var phone: String = ""
    var pass: String = ""
    var yanzh: String = ""
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBottomBorder(textField: tv_phone)
        //左侧图片
        tv_phone.leftView = UIImageView(image: UIImage(named: "phone"))
        tv_phone.leftViewMode = UITextField.ViewMode.always
        tv_pass.leftView = UIImageView(image: UIImage(named: "mima"))
        tv_pass.leftViewMode = UITextField.ViewMode.always
        tv_yanzh.leftView = UIImageView(image: UIImage(named: "xinxi"))
        tv_yanzh.leftViewMode = UITextField.ViewMode.always
        // Do any additional setup after loading the view.
    }
    //左边栏图片
    func setBottomBorder(textField:UITextField){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField.frame.size.height)
        
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
    //提示框方法
    func showMsgbox(_message: String, _title: String = "提示"){
        
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction func getYanzhen(_ sender: Any) {
        CodeRequest()
    }
    func CodeRequest()  {
        phone = tv_phone.text!
        pass = tv_pass.text!
        yanzh=tv_yanzh.text!
        let url = "http://47.106.217.3:8360/app/user/code"
        let paras = ["phone":phone]
        print("手机号"+phone)
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            print("jsonRequest:\(response.result)")
            let data = response.result.value
            print("结果:\(data)")
        }
        self.countDown(timeOut: 60)
    }
    
    //验证码倒计时
    //验证码倒计时
    func countDown(timeOut:Int){
        
        //倒计时时间
        var timeout = timeOut
        let queue:DispatchQueue = DispatchQueue.global(qos: .default)
        
        // 在global线程里创建一个时间源
        let codeTimer = DispatchSource.makeTimerSource(queue:queue)
        
        
        codeTimer.scheduleRepeating(deadline: .now(), interval:.seconds(1))
        
        //每秒执行
        codeTimer.setEventHandler(handler: { () -> Void in
            if(timeout<=0){ //倒计时结束，关闭
                
                
                codeTimer.cancel()
                
                DispatchQueue.main.sync(execute: { () -> Void in
                    //设置界面的按钮显示 根据自己需求设置
                    self.bt_Yz.setTitle("重新发送", for: UIControl.State.normal)
                    
                    self.bt_Yz.isUserInteractionEnabled = true
                    
                    
                })
            }else{//正在倒计时
                
                let seconds = timeout
                let strTime = NSString.localizedStringWithFormat("%.d", seconds)
                
                DispatchQueue.main.sync(execute: { () -> Void in
                    //                    NSLog("----%@", NSString.localizedStringWithFormat("%@S", strTime) as String)
                    
                    UIView.beginAnimations(nil, context: nil)
                    UIView.setAnimationDuration(1)
                    //设置界面的按钮显示 根据自己需求设置
                    self.bt_Yz.setTitle(NSString.localizedStringWithFormat("%@S", strTime) as String, for: UIControl.State.normal)
                    UIView.commitAnimations()
                    self.bt_Yz.isUserInteractionEnabled = false
                })
                timeout -= 1;
            }
            
        })
        codeTimer.resume()
    }
    @IBAction func ToRegister(_ sender: Any) {
        phone = tv_phone.text!
        pass = tv_pass.text!
        yanzh = tv_yanzh.text!
        if (phone == ""){
            showMsgbox(_message: "请输入帐号")
            return
            
        }
        if (isTelNumber(num: phone as NSString) == false) {
            showMsgbox(_message: "请输入正确的手机号")
            return
        }
        if (pass == ""){
            showMsgbox(_message: "请输入密码")
            return
        }
        if (pass.count > 16 || pass.count < 6){
            showMsgbox(_message: "请输入6到16位密码")
            return
        }
        if (yanzh == ""){
            showMsgbox(_message: "请输入验证码")
            return
        }
        else {
//            let alertController = UIAlertController(title: "注册成功!",
//                                                    message: nil, preferredStyle: .alert)
//            //显示提示框
//            self.present(alertController, animated: true, completion: nil)
//            //两秒钟后自动消失
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
//                self.presentedViewController?.dismiss(animated: false, completion: nil)
//            }
//            let time: TimeInterval = 0.8
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
//                //code
//                let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: LoginViewController())))
//                    as! LoginViewController
//                self.present(controller, animated: true, completion: nil)
//            }
            RegisterRequest()
        }
        
    }
    func isTelNumber(num:NSString)->Bool
    {
        var mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        var  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        var  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        var  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        var regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        var regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        var regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        var regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluate(with: num) == true)
            || (regextestcm.evaluate(with: num)  == true)
            || (regextestct.evaluate(with: num) == true)
            || (regextestcu.evaluate(with: num) == true))
        {
            return true
        }
        else
        {
            return false
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func RegisterRequest()  {
        phone = tv_phone.text!
        pass = tv_pass.text!
        yanzh = tv_yanzh.text!
        let url = "https://www.xingzhu.club/XzTest/users/register"
        let paras = ["userPhoneNumber":phone,"userPwd":pass]
        print("手机号"+phone)
        print("手机号"+pass)
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
                if(message == "注册成功"){
                    let time: TimeInterval = 1
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                        //code
                        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: LoginViewController())))
                            as! LoginViewController
                        self.present(controller, animated: true, completion: nil)
                    }
                }
//
//                }
//                if(erro == 10){
//                    let alertController = UIAlertController(title: "验证码错误!",
//                                                            message: nil, preferredStyle: .alert)
//                    //显示提示框
//                    self.present(alertController, animated: true, completion: nil)
//                    //两秒钟后自动消失
//                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
//                        self.presentedViewController?.dismiss(animated: false, completion: nil)
//                    }
//                }
//                if(erro == 16){
//                    let alertController = UIAlertController(title: "密码错误!",
//                                                            message: nil, preferredStyle: .alert)
//                    //显示提示框
//                    self.present(alertController, animated: true, completion: nil)
//                    //两秒钟后自动消失
//                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
//                        self.presentedViewController?.dismiss(animated: false, completion: nil)
//                    }
//                }
//                if(erro == 14){
//                    let alertController = UIAlertController(title: "用户不存在!",
//                                                            message: nil, preferredStyle: .alert)
//                    //显示提示框
//                    self.present(alertController, animated: true, completion: nil)
//                    //两秒钟后自动消失
//                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
//                        self.presentedViewController?.dismiss(animated: false, completion: nil)
//                    }
//                }
            }
            
        }
    }
}
