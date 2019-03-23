//
//  SetpaypassViewController.swift
//  XZ
//
//  Created by wjz on 2019/3/1.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit
import Alamofire
class SetpaypassViewController: UIViewController {

    @IBOutlet weak var l_title: UILabel!
    @IBOutlet weak var nv_title: UINavigationItem!
    @IBOutlet weak var bt_fog: UIButton!
    @IBOutlet weak var v_yzm: UIView!
    @IBOutlet weak var tv_yanzh: UITextField!
    @IBOutlet weak var bt_Yz: UIButton!
    var oldphone = ""
    var zt_hqyz:Int = 0
    var phone: String = ""
    var pass: String = ""
    var yanzh: String = ""
    var verifyCode : String = ""
    var root : LoginViewController?
    var ntitle:String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tv_yanzh.addChangeTextTarget()
        tv_yanzh.maxTextNumber = 4
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target:self, action:#selector(LoginViewController.handleTap(sender:))))
        let handLeftRight = UISwipeGestureRecognizer(target: self, action: #selector(funLeftRight))
        //handLeftRight.direction = .left //支持向左
        self.view.addGestureRecognizer(handLeftRight)
        
        self.title = ntitle
        l_title.text = ntitle
        //验证码
        v_yzm?.clipsToBounds=true
        v_yzm?.layer.cornerRadius = 10
        v_yzm?.layer.shadowColor = UIColor.gray.cgColor
        v_yzm?.layer.shadowOpacity = 1.0
        v_yzm?.layer.shadowOffset = CGSize(width: 0, height: 0)
        v_yzm?.layer.shadowRadius = 4
        v_yzm?.layer.masksToBounds = false
        //确定按钮圆角
        bt_fog?.layer.cornerRadius = 10
        bt_fog?.backgroundColor = UIColorRGB_Alpha(R: 91.0, G: 84.0, B: 145.0, alpha: 0.8);
       
        //验证码按钮右边圆角
        bt_Yz?.layer.cornerRadius = 10.0
        bt_Yz?.layer.maskedCorners = [CACornerMask.layerMaxXMinYCorner , CACornerMask.layerMaxXMaxYCorner]
        bt_Yz?.layer.masksToBounds = true
        bt_Yz?.backgroundColor = UIColorRGB_Alpha(R: 91.0, G: 84.0, B: 145.0, alpha: 0.8);
        //        setBottomBorder(textField: tv_phone)
        //        //左侧图片
        //        tv_phone.leftView = UIImageView(image: UIImage(named: "phone"))
        //        tv_phone.leftViewMode = UITextField.ViewMode.always
        //        tv_pass.leftView = UIImageView(image: UIImage(named: "mima"))
        //        tv_pass.leftViewMode = UITextField.ViewMode.always
        //        tv_yanzh.leftView = UIImageView(image: UIImage(named: "xinxi"))
        //        tv_yanzh.leftViewMode = UITextField.ViewMode.always
        // Do any additional setup after loading the view.
    }
    //收起键盘
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            tv_yanzh.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
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
        self.zt_hqyz = 1
        yanzh=tv_yanzh.text!
        var userid:Int = UserDefaults.standard.object(forKey: "userId") as! Int
        let url = "https://www.xingzhu.club/XzTest/users/getResetPayPwdVerifyCode"
        let paras = ["userId":userid]
        print("手机号"+phone)
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("jsonRequest:\(response.result)")
            let jdata = response.result.value
            print("结果:\(jdata)")
            let json = JSON(jdata)
            var message: String = json["message"].string!
            print("信息:\(message)")
            let alertController = UIAlertController(title: message,
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            if(message == "发送信息成功！"){
                let codemess = json["data"]
                self.verifyCode = codemess["verifyCode"].string ?? ""
                print("数据\(codemess)")
                print("验证码\(self.verifyCode)")
                UserDefaults.standard.set(self.verifyCode, forKey: "verifyCode")
            }
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
    @IBAction func ToFoget(_ sender: Any) {
        if(zt_hqyz == 0){
             showMsgbox(_message: "请先获取验证码")
        }
        else{
            yanzh=tv_yanzh.text!
            if(tv_yanzh.text! == ""){
                showMsgbox(_message: "验证码不能为空")
            }
            else if(yanzh != verifyCode){
                print("输入\(yanzh),收到的是\(verifyCode)")
                showMsgbox(_message: "验证码不正确")
            }
            else {
                setPay()
            }
        }
        
    }
    func setPay(){
        WMPasswordView.show(type: WMPwdType.setPwd, amount: 100) { [weak self] pwd in
            self?.againPay(pwds: pwd)
        }
    }
    func againPay(pwds:String){
        WMPasswordView.show(type: WMPwdType.againPwd, amount: 100) { [weak self] pwd in
            print("第一次输入\(pwds),第二次输入\(pwd)")
            if(pwds != pwd){
                self?.showMsgbox(_message: "两次密码不一致")
            }
            else{
                self?.setUserPayPassword(paypass: pwds)
            }
        }
    }
    func setUserPayPassword(paypass:String)  {
        var userid:Int = UserDefaults.standard.object(forKey: "userId") as! Int
        let url = "https://www.xingzhu.club/XzTest/users/setUserPayPassword"
        let paras = ["userId":userid,"userPayPassword":paypass] as [String : Any]
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("jsonRequest:\(response.result)")
            let data = response.result.value
            if let jdata = response.result.value {
                let json = JSON(jdata)
                print("结果:\(json)")
                var code: Int = json["code"].int!
                print("错误:\(code)")
                var message: String = json["message"].string!
                let alertController = UIAlertController(title: message,
                                                        message: nil, preferredStyle: .alert)
                //显示提示框
                self.present(alertController, animated: true, completion: nil)
                //两秒钟后自动消失
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                    self.presentedViewController?.dismiss(animated: false, completion: nil)
                    if(message == "设置支付密码成功"){
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
        
    }
    func UIColorRGB_Alpha(R:CGFloat, G:CGFloat, B:CGFloat, alpha:CGFloat) -> UIColor
    {
        let color = UIColor.init(red: (R / 255.0), green: (G / 255.0), blue: (B / 255.0), alpha: alpha);
        return color;
    }
    @objc func funLeftRight(sender: UIPanGestureRecognizer){
       
    }
}
