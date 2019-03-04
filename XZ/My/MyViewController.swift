//
//  MyViewController.swift
//  XZ
//
//  Created by wjz on 2018/12/20.
//  Copyright © 2018年 wjz. All rights reserved.
//

import UIKit
import Alamofire
class MyViewController: UIViewController{
    @IBOutlet weak var l_mess: UILabel!
    @IBOutlet weak var v_purse: UIView!
    @IBOutlet weak var tv_qbdd: UILabel!
    @IBOutlet weak var iv_head: UIImageView!
    @IBOutlet weak var messv: UIView!
    @IBOutlet weak var message: UIView!
    @IBOutlet weak var Sugg: UIView!
    @IBOutlet weak var sett: UIView!
    @IBOutlet weak var tv_phone: UILabel!
    @IBOutlet weak var tv_name: UILabel!
    
    var v_pay:UIView?
    var v_tishi:UIView?
    var iv_close:UIButton?
    var l_tishi:UILabel?
    var l_forget:UILabel?
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    
    var userphone = ""
    var username = ""
    var nameph:String = ""
    @IBAction func TZ(_ sender: Any) {
        
        let secondViewController = MymessViewController()
        self.present(secondViewController, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        v_pay = UIView(frame: CGRect(x:0, y: screenHeight, width:screenWidth, height: 400))
        v_pay?.backgroundColor=UIColor.white
        v_pay?.clipsToBounds=true
        v_pay?.layer.shadowColor = UIColor.gray.cgColor
        v_pay?.layer.shadowOpacity = 0.5
        v_pay?.layer.masksToBounds = false
        self.view.addSubview(v_pay!)
        
        v_tishi = UIView(frame: CGRect(x:0, y: 0, width:screenWidth, height: 46))
        v_tishi?.addBorder(side: .bottom, thickness: 0.5, color: UIColor.lightGray)
        v_pay?.addSubview(v_tishi!)
        
        iv_close = UIButton(frame: CGRect(x:10, y: 8, width:30, height: 30))
        iv_close?.setImage(UIImage(named:"close"), for: .normal)
        iv_close?.addTarget(self, action: #selector(CloseClick), for: UIControl.Event.touchUpInside)
        v_tishi?.addSubview(iv_close!)
        
        l_tishi = UILabel(frame: CGRect(x:50, y: 8, width:screenWidth-100, height: 30))
        l_tishi?.font = UIFont.systemFont(ofSize: 16)
        l_tishi?.textColor = UIColor.black
        l_tishi?.numberOfLines = 0
        l_tishi?.lineBreakMode = NSLineBreakMode.byWordWrapping
        l_tishi?.text = "请输入支付密码"
        l_tishi?.textAlignment = .center
        v_tishi?.addSubview(l_tishi!)
        
        l_forget = UILabel(frame: CGRect(x:0, y: 140, width:screenWidth, height: 30))
        l_forget?.font = UIFont.systemFont(ofSize: 14)
        l_forget?.textColor = UIColor.blue
        l_forget?.numberOfLines = 0
        l_forget?.lineBreakMode = NSLineBreakMode.byWordWrapping
        l_forget?.text = "忘记密码?"
        l_forget?.textAlignment = .center
        v_pay?.addSubview(l_forget!)
        
        
        var headph : String = "";
        if UserDefaults.standard.object(forKey: "userProfilePhoto") != nil {
            headph = UserDefaults.standard.object(forKey: "userProfilePhoto") as! String
        }
        if UserDefaults.standard.object(forKey: "userName") != nil {
            nameph = UserDefaults.standard.object(forKey: "userName") as! String
        }
        //jsonRequest()
        iv_head.layer.cornerRadius = 35
        iv_head.layer.masksToBounds = true
        print("头像\(headph)")
        if(headph != ""){
            let url = URL(string:headph)
            let data = try! Data(contentsOf: url!)
            let smallImage = UIImage(data: data)
            iv_head.image = smallImage
        }
        if(nameph != ""){
            tv_name.text = nameph
        }
        let myclick = UITapGestureRecognizer(target: self, action: #selector(myAction))
        iv_head.addGestureRecognizer(myclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        iv_head.isUserInteractionEnabled = true
        tv_name?.textAlignment=NSTextAlignment.center
        let messclick = UITapGestureRecognizer(target: self, action: #selector(messAction))
        message.addGestureRecognizer(messclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        message.isUserInteractionEnabled = true
        let purseclick = UITapGestureRecognizer(target: self, action: #selector(purseAction))
        v_purse.addGestureRecognizer(purseclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        v_purse.isUserInteractionEnabled = true
        let suggclick = UITapGestureRecognizer(target: self, action: #selector(suggAction))
        Sugg.addGestureRecognizer(suggclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        Sugg.isUserInteractionEnabled = true
        
        let settclick = UITapGestureRecognizer(target: self, action: #selector(settAction))
        sett.addGestureRecognizer(settclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        sett.isUserInteractionEnabled = true
        
        let myqbddclick = UITapGestureRecognizer(target: self, action: #selector(qbddAction))
        tv_qbdd.addGestureRecognizer(myqbddclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        tv_qbdd.isUserInteractionEnabled = true
        
        //未读消息数量
        l_mess?.backgroundColor=UIColor.red
        l_mess?.layer.cornerRadius = 13;
        l_mess?.clipsToBounds = true
        l_mess?.layer.masksToBounds = true
        l_mess?.textAlignment = .center
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("我的前台显示")
        getUnreadNoticeCount()
        // The rest of your code.
    }
    func jsonRequest()  {
        
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request("http://119.29.88.72:8080/XzTest/user/selectUserByIdTest/1", method: .post, parameters: [:], encoding: JSONEncoding.default, headers: nil)
            .responseJSON { (response) in
                print("jsonRequest:\(response.result)")
                
                if let data = response.result.value {
                    let json = JSON(data)
                    self.userphone = json["userPhone"].string!
                    self.username = json["userName"].string!
                    print("手机号:\(self.userphone)")
                    self.tv_phone.text = self.userphone
                    self.tv_name.text = self.username
                }
        }
    }
    
    func getUnreadNoticeCount()  {
        var userid:Int = UserDefaults.standard.object(forKey: "userId") as! Int
        let url = "https://www.xingzhu.club/XzTest/notices/getUnreadNoticeCount"
        let paras = ["userId":userid]
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("jsonRequest:\(response.result)")
                
                if let data = response.result.value {
                    let json = JSON(data)
                    let data1 = json["data"]
                    let counts: Int = data1["count"].int ?? 0
                    self.l_mess.text = "\(counts)"
                }
        }
    }
    
    //点击事件方法
    @objc func myAction() -> Void {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: MymessViewController())))
            as! MymessViewController
        controller.name = username
        controller.root = self
        self.present(controller, animated: true, completion: nil)
    }
    //点击事件方法
    @objc func purseAction() -> Void {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: PurseViewController())))
            as! PurseViewController
        self.present(controller, animated: true, completion: nil)
    }
    //点击事件方法
    @objc func messAction() -> Void {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: messageTableViewController())))
            as! messageTableViewController
        self.present(controller, animated: true, completion: nil)
    }
    //点击事件方法
    @objc func suggAction() -> Void {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: SuggestViewController())))
            as! SuggestViewController
        self.present(controller, animated: true, completion: nil)
    }
    //点击事件方法
    @objc func settAction() -> Void {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: SettingViewController())))
            as! SettingViewController
        self.present(controller, animated: true, completion: nil)
    }
    //点击事件方法
    @objc func qbddAction() -> Void {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: MyorderTableViewController())))
            as! MyorderTableViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func topay(_ sender: Any) {
        let hanpwd = HanPasswordView.init(frame: CGRect.init(x: 0, y: 80, width: UIScreen.main.bounds.size.width, height: 50))
        hanpwd.entryCompleteBlock = entryCompleteBlock
        v_pay?.addSubview(hanpwd)
        UIView.animate(withDuration: 0.5) {
            self.v_pay?.center.y -= 400
        }
        

    }
    func entryCompleteBlock() ->Void{
        print("输入完毕")
        UIView.animate(withDuration: 0.5) {
            self.v_pay?.center.y += 400
        }
    }
    func Printpass(pass:String){
        print("密码是\(pass)")
    }
    @objc func CloseClick(shopcellView: UILabel) {
        UIView.animate(withDuration: 0.5) {
            self.v_pay?.center.y += 400
        }
    }
}
