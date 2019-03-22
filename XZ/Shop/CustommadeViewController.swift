//
//  CustommadeViewController.swift
//  XZ
//
//  Created by wjz on 2019/1/25.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit
import Alamofire
class CustommadeViewController: UIViewController ,UIWebViewDelegate{
    @IBOutlet weak var v_xxk: UIView!
    @IBOutlet weak var bt_lxfs: UIButton!
    @IBOutlet weak var bt_xlx: UIButton!
    @IBOutlet weak var bt_xll: UIButton!
    @IBOutlet weak var bt_xkf: UIButton!
    @IBOutlet weak var v1: UIView!
    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var v3: UIView!
    @IBOutlet weak var iv_close: UIButton!
    @IBOutlet weak var l_email: UILabel!
    @IBOutlet weak var l_qq: UILabel!
    @IBOutlet weak var l_phone: UILabel!
    @IBOutlet weak var tv_selfmess: UIView!
    @IBOutlet weak var v_web: UIView!
    @IBOutlet weak var bt_tj: UIButton!
    @IBOutlet weak var tf_web: UILabel!
    @IBOutlet weak var tv_data: UITextField!
    @IBOutlet weak var tf_rem: UITextView!
    @IBOutlet weak var tv_QQ: UITextField!
    @IBOutlet weak var tv_email: UITextField!
    @IBOutlet weak var tv_phone: UITextField!
     @IBOutlet weak var v_data: UIView!
    
    var webs : String = ""
    var datas : String = ""
    var remas : String = ""
    var phones : String = ""
    var qqs : String = ""
    var emails : String = ""
    var userid:Int = 0
    var v_url:UIView?
    var bt_close:UIButton?
    var bt_addurl:UIButton?
    var l_tishiurl:UILabel?
    var l_url:UILabel?
    var tf_url:UITextField?
    var to_url:String = ""
    var zt_sfqr:Int = 0
    var thephone:String = ""
    var theQQ:String = ""
    var theemail:String = ""
    var zt_mess:Int = 0
    var v_hmess:UIView?
    var bt_pho:UIButton?
    var tf_pho:UITextField?
    var bt_qq:UIButton?
    var tf_qq:UITextField?
    var bt_ema:UIButton?
    var tf_ema:UITextField?
    var zt_hmess:Int = 0
    var l_tishi:UILabel?
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    var v_fenge1:UIView?
    var v_fenge2:UIView?
    var v_fenge3:UIView?
    var qqNumber:Int = 1252279088
    override func viewDidLoad() {
        super.viewDidLoad()
        v1.frame.size.width = screenWidth-40
        v2.frame.size.width = screenWidth-40
        v3.frame.size.width = screenWidth-40
        iv_close.frame.origin.x = (screenWidth-72)/2
        let nv_height = self.navigationController?.navigationBar.frame.size.height
        self.title = "自定义服务"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title:"提交",style:UIBarButtonItem.Style.plain,target:self,action:#selector(Custommade))
        v_xxk.frame.size.width = screenWidth
        bt_xlx.frame.origin.x = 10
        bt_xlx.frame.origin.y = 5
        bt_xlx.frame.size.height = 40
        bt_xlx.frame.size.width = (v_xxk.frame.size.width-40)/3
        //图片内容填满格式
        bt_xlx.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        bt_xll.frame.origin.x = (v_xxk.frame.size.width-40)/3+20
        bt_xll.frame.origin.y = 5
        bt_xll.frame.size.height = 40
        bt_xll.frame.size.width = (v_xxk.frame.size.width-40)/3
        bt_xll.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        bt_xkf.frame.origin.x = (v_xxk.frame.size.width-40)/3*2+30
        bt_xkf.frame.origin.y = 5
        bt_xkf.frame.size.height = 40
        bt_xkf.frame.size.width = (v_xxk.frame.size.width-40)/3
        bt_xkf.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        tv_selfmess.isHidden = true
        //右滑方法
        let handRight = UISwipeGestureRecognizer(target: self, action: #selector(funRight))
        //左滑方法
        let handLeft = UISwipeGestureRecognizer(target: self, action: #selector(funLeft))
        handLeft.direction = .left //支持向左
        //下滑方法
        let handdown = UISwipeGestureRecognizer(target: self, action: #selector(funDown))
        handdown.direction = .down //支持向下
        //个人信息视图
        tv_selfmess.frame.size.width = screenWidth-40
        tv_selfmess.frame.origin.x = 20
        tv_selfmess?.clipsToBounds=true
        tv_selfmess?.layer.cornerRadius = 10
        tv_selfmess?.layer.shadowColor = UIColor.gray.cgColor
        tv_selfmess?.layer.shadowOpacity = 1.0
        tv_selfmess?.layer.shadowOffset = CGSize(width: 0, height: 0)
        tv_selfmess?.layer.shadowRadius = 4
        tv_selfmess?.layer.masksToBounds = false
        //添加手势
        v_hmess?.addGestureRecognizer(handdown)
        //跳出来的个人信息视图
        v_hmess = UIView(frame: CGRect(x:-screenWidth, y:225, width:screenWidth-40, height: 197))
        v_hmess?.clipsToBounds=true
        v_hmess?.layer.cornerRadius = 10
        v_hmess?.layer.shadowColor = UIColor.gray.cgColor
        v_hmess?.layer.shadowOpacity = 1.0
        v_hmess?.layer.shadowOffset = CGSize(width: 0, height: 0)
        v_hmess?.layer.shadowRadius = 4
        v_hmess?.layer.masksToBounds = false
        v_hmess?.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        v_data.addSubview(v_hmess!)
        //添加手势
        v_hmess?.addGestureRecognizer(handRight)
        v_hmess?.addGestureRecognizer(handLeft)
        v_hmess?.isHidden = true
        //手机按钮
        bt_pho = UIButton(frame: CGRect(x:15, y:10, width:40, height: 40))
        bt_pho?.setImage(UIImage(named: "shouji"), for: .normal)
        bt_pho?.setTitleColor(UIColor.black, for: .normal)
        bt_pho?.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        bt_pho?.addTarget(self, action: #selector(whitephone), for: UIControl.Event.touchUpInside)
        v_hmess?.addSubview(bt_pho!)
        
        //手机输入框
        tf_pho = UITextField(frame: CGRect(x:65, y:10, width:screenWidth-40-80, height: 40))
        tf_pho?.font = UIFont.systemFont(ofSize: 16)
        tf_pho?.placeholder = "请输入手机号码"
        tf_pho?.clearButtonMode=UITextField.ViewMode.always//一直显示清除按钮
        tf_pho?.textColor = UIColor.black
        tf_pho?.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        tf_pho?.clipsToBounds=true
        tf_pho?.layer.cornerRadius = 5
        tf_pho?.layer.masksToBounds = false
        v_hmess?.addSubview(tf_pho!)
        
        //输入框左边缩进
        let leftView = UILabel()
        tf_pho?.leftView = leftView
        leftView.bounds = CGRect(x:0, y:0, width:15, height:(tf_pho?.frame.size.height)!)
        leftView.backgroundColor = UIColor.clear
        tf_pho?.leftViewMode = .always
        // Do any additional setup after loading the view.
        
        //分割线1
        v_fenge1 = UIView(frame: CGRect(x:0, y:52, width:screenWidth-40, height: 3))
        v_fenge1?.backgroundColor = UIColor.white
        v_hmess?.addSubview(v_fenge1!)
        
        //QQ按钮
        bt_qq = UIButton(frame: CGRect(x:15, y:60, width:40, height: 40))
        bt_qq?.setImage(UIImage(named: "QQ"), for: .normal)
        bt_qq?.addTarget(self, action: #selector(whiteQQ), for: UIControl.Event.touchUpInside)
        bt_qq?.setTitleColor(UIColor.black, for: .normal)
        v_hmess?.addSubview(bt_qq!)
        
        //QQ输入框
        tf_qq = UITextField(frame: CGRect(x:65, y:60, width:screenWidth-40-80, height: 40))
        tf_qq?.placeholder = "请输入QQ号码"
        tf_qq?.font = UIFont.systemFont(ofSize: 16)
        tf_qq?.clearButtonMode=UITextField.ViewMode.always//一直显示清除按钮
        tf_qq?.textColor = UIColor.black
        tf_qq?.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        tf_qq?.clipsToBounds=true
        tf_qq?.layer.cornerRadius = 5
        tf_qq?.layer.masksToBounds = false
        v_hmess?.addSubview(tf_qq!)
        
        //QQ输入框左边缩进
        let leftViewqq = UILabel()
        tf_qq?.leftView = leftViewqq
        leftViewqq.bounds = CGRect(x:0, y:0, width:15, height:(tf_qq?.frame.size.height)!)
        leftViewqq.backgroundColor = UIColor.clear
        tf_qq?.leftViewMode = .always
        
        //分割线2
        v_fenge2 = UIView(frame: CGRect(x:0, y:102, width:screenWidth-40, height: 3))
        v_fenge2?.backgroundColor = UIColor.white
        v_hmess?.addSubview(v_fenge2!)
        
        userid = UserDefaults.standard.object(forKey: "userId") as! Int
        v_web?.backgroundColor=UIColor(red: 236.0/255.0, green: 236.0/255.0, blue: 236.0/255.0, alpha: 1.0)
        v_web?.clipsToBounds=true
        v_web?.layer.cornerRadius = 5
        v_web?.layer.masksToBounds = false
        tf_rem?.backgroundColor=UIColor.white
        //邮箱按钮
        bt_ema = UIButton(frame: CGRect(x:15, y:110, width:40, height: 40))
        bt_ema?.setImage(UIImage(named: "youxiang"), for: .normal)
        bt_ema?.addTarget(self, action: #selector(whiteemail), for: UIControl.Event.touchUpInside)
        bt_ema?.setTitleColor(UIColor.black, for: .normal)
        v_hmess?.addSubview(bt_ema!)
        //邮箱输入框
        tf_ema = UITextField(frame: CGRect(x:65, y:110, width:screenWidth-40-80, height: 40))
        tf_ema?.font = UIFont.systemFont(ofSize: 16)
        tf_ema?.placeholder = "请输入邮箱地址"
        tf_ema?.clearButtonMode=UITextField.ViewMode.always//一直显示清除按钮
        tf_ema?.textColor = UIColor.black
        tf_ema?.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        tf_ema?.clipsToBounds=true
        tf_ema?.layer.cornerRadius = 5
        tf_ema?.layer.masksToBounds = false
        v_hmess?.addSubview(tf_ema!)
        
        //邮箱输入框左边缩进
        let leftViewema = UILabel()
        tf_ema?.leftView = leftViewema
        leftViewema.bounds = CGRect(x:0, y:0, width:15, height:(tf_ema?.frame.size.height)!)
        leftViewema.backgroundColor = UIColor.clear
        tf_ema?.leftViewMode = .always
        
        //分割线3
        v_fenge3 = UIView(frame: CGRect(x:0, y:152, width:screenWidth-40, height: 3))
        v_fenge3?.backgroundColor = UIColor.white
        v_hmess?.addSubview(v_fenge3!)
        
        userid = UserDefaults.standard.object(forKey: "userId") as! Int
        v_web?.backgroundColor=UIColor(red: 236.0/255.0, green: 236.0/255.0, blue: 236.0/255.0, alpha: 1.0)
        v_web?.clipsToBounds=true
        v_web?.layer.cornerRadius = 5
        v_web?.layer.masksToBounds = false
        tf_rem?.backgroundColor=UIColor.white
        
        //分割线3
        l_tishi = UILabel(frame: CGRect(x:0, y:160, width:screenWidth-40, height: 32))
        l_tishi?.text = "右滑确认"
        l_tishi?.textAlignment = .center
        v_hmess?.addSubview(l_tishi!)
        
        userid = UserDefaults.standard.object(forKey: "userId") as! Int
        v_web?.backgroundColor=UIColor(red: 236.0/255.0, green: 236.0/255.0, blue: 236.0/255.0, alpha: 1.0)
        v_web?.clipsToBounds=true
        v_web?.layer.cornerRadius = 5
        v_web?.layer.masksToBounds = false
        tf_rem?.backgroundColor=UIColor.white
        
        //添加跳转手势
        let tourlclick = UITapGestureRecognizer(target: self, action: #selector(tourlAction))
        tf_web.addGestureRecognizer(tourlclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        tf_web.isUserInteractionEnabled = true
        v_web.isHidden = true
        
        bt_tj?.setTitle("提交需求", for: UIControl.State.normal)
        bt_tj?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        bt_tj?.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        bt_tj?.backgroundColor = UIColorRGB_Alpha(R: 0.0, G: 140.0, B: 255.0, alpha: 0.8);
        v_url = UIView(frame: CGRect(x:0, y:screenHeight, width:screenWidth, height: screenHeight-20))
        
        v_url?.backgroundColor = UIColor.white
        self.view.addSubview(v_url!)
        
        bt_close = UIButton(frame: CGRect(x:15, y:15, width:40, height: 40))
        bt_close?.setImage(UIImage(named: "close"), for: .normal)
        bt_close?.addTarget(self, action: #selector(CloseClick), for: UIControl.Event.touchUpInside)
        v_url?.addSubview(bt_close!)
        
        bt_addurl = UIButton(frame: CGRect(x:screenWidth-70, y:15, width:50, height: 40))
        bt_addurl?.setTitle("添加", for: .normal)
        bt_addurl?.setTitleColor(UIColor.blue, for: .normal)
        bt_addurl?.addTarget(self, action: #selector(URLClick), for: UIControl.Event.touchUpInside)
        v_url?.addSubview(bt_addurl!)
        
        l_tishiurl = UILabel(frame: CGRect(x:15, y:60, width:screenWidth-30, height: 20))
        l_tishiurl?.text = "添加网址链接"
        v_url?.addSubview(l_tishiurl!)
        
        l_url = UILabel(frame: CGRect(x:15, y:100, width:screenWidth-30, height: 20))
        l_url?.font = UIFont.systemFont(ofSize: 14)
        l_url?.textColor = UIColor.gray
        l_url?.text = "请您按照正确格式填写您需要爬取的网络地址"
        v_url?.addSubview(l_url!)
        
        
        tf_url = UITextField(frame: CGRect(x:15, y:140, width:screenWidth-30, height: 45))
        tf_url?.font = UIFont.systemFont(ofSize: 16)
        tf_url?.clearButtonMode=UITextField.ViewMode.always//一直显示清除按钮
        tf_url?.textColor = UIColor.black
        tf_url?.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        tf_url?.clipsToBounds=true
        tf_url?.layer.cornerRadius = 5
        tf_url?.layer.masksToBounds = false
        v_url?.addSubview(tf_url!)
        //输入框左边缩进
        let leftView1 = UILabel()
        tf_url?.leftView = leftView1
        leftView1.bounds = CGRect(x:0, y:0, width:15, height:(tf_url?.frame.size.height)!)
        leftView1.backgroundColor = UIColor.clear
        tf_url?.leftViewMode = .always
    }
    
    @IBAction func back(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    func UIColorRGB_Alpha(R:CGFloat, G:CGFloat, B:CGFloat, alpha:CGFloat) -> UIColor
    {
        let color = UIColor.init(red: (R / 255.0), green: (G / 255.0), blue: (B / 255.0), alpha: alpha);
        return color;
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func cleanurl(_ sender: Any) {
        tf_web.text = ""
        to_url = ""
        v_web.isHidden = true
    }
    
    @objc func Custommade() {
        webs = tf_web.text!
        datas = tv_data.text ?? ""
        remas = tf_rem.text
        phones = l_phone.text ?? ""
        qqs = l_qq.text ?? ""
        emails = l_email.text ?? ""
        if(webs == ""){
            let alertController = UIAlertController(title: "请输入网站链接",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            print("uil视图出现")
            self.v_url?.transform = CGAffineTransform.identity
            self.navigationController?.isNavigationBarHidden = true
            
            UIView.animate(withDuration: 0.3) {
                self.v_url?.frame.origin.y -= self.screenHeight-20
            }
        }
        if(datas == ""){
            showMsgbox(_message: "请输入需爬取的数据")
            return
        }
        else if(phones == ""){
            let alertController = UIAlertController(title: "请输入您的个人信息",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            if(self.zt_hmess == 0){
                UIView.animate(withDuration: 1 , delay: 0 , usingSpringWithDamping: 0.6 , initialSpringVelocity: 8 , options: [] , animations: {
                    self.v_hmess?.center.x += self.screenWidth+20
                    self.v_hmess?.isHidden = true
                }, completion: nil)
                self.zt_hmess = 1
            }
            else{
                UIView.animate(withDuration: 1 , delay: 0 , usingSpringWithDamping: 0.6 , initialSpringVelocity: 8 , options: [] , animations: {
                    self.v_hmess?.center.x -= self.screenWidth+20
                }, completion: nil)
                self.zt_hmess = 0
            }
        }else{
            postDemand()
        }
    }
    @objc func postDemand()  {
        
        let url = "https://www.xingzhu.club/XzTest/demands/postDemand"
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        let paras = ["userId":self.userid,"demandWeb":self.webs,"demandData":self.datas,"demandRemarks":self.remas,"demandPhoneNumber":self.phones,"demandEmail":self.emails,"demandQq":self.qqs] as [String : Any]
        print("网站\(self.webs),手机\(phones),QQ\(qqs),数据\(datas),备注\(remas),邮箱\(emails)")
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("jsonRequest:\(response.result)")
            if let data = response.result.value {
                let json = JSON(data)
                print("结果:\(json)")
                var code: Int = json["code"].int!
                print("错误:\(code)")
                var message:String = json["message"].string!
                print("提示:\(message)")
                if(message == "需求提交成功！"){
                    let alertController = UIAlertController(title: "需求提交成功,我们会尽快处理",
                                                            message: nil, preferredStyle: .alert)
                    //显示提示框
                    self.present(alertController, animated: true, completion: nil)
                    //两秒钟后自动消失
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                        self.presentedViewController?.dismiss(animated: false, completion: nil)
                    }
                }
            }
        }
    }
    func showMsgbox(_message: String, _title: String = "提示"){
        
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction func toUrl(_ sender: Any) {
        print("uil视图出现")
        self.navigationController?.isNavigationBarHidden = true
        self.v_url?.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.3) {
            self.v_url?.frame.origin.y -= self.screenHeight-20
        }
    }
    @objc func CloseClick() {
        self.v_url?.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.3) {
            self.v_url?.frame.origin.y += self.screenHeight-20
        }
        self.navigationController?.isNavigationBarHidden = false
    }
    @objc func URLClick() {
        var theurl = tf_url?.text
        if(theurl == ""){
            showMsgbox(_message: "请输入爬取网址")
        }else{
            var result:Int = checkURL(str: theurl!)
            if(result == 0){
                let alertController = UIAlertController(title: "请输入正确的链接",
                                                        message: nil, preferredStyle: .alert)
                //显示提示框
                self.present(alertController, animated: true, completion: nil)
                //两秒钟后自动消失
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                    self.presentedViewController?.dismiss(animated: false, completion: nil)
                }
            }
            else{
                self.tf_web?.text = theurl
                self.to_url = theurl!
                self.v_web.isHidden = false
                self.v_url?.transform = CGAffineTransform.identity
                UIView.animate(withDuration: 0.3) {
                            self.v_url?.frame.origin.y += self.screenHeight-20
                 }
                self.navigationController?.isNavigationBarHidden = false
            }
        }

    }
    func checkURL(str:String) ->Int {
        // 创建一个正则表达式对象
        var isurl:Int = 0
        do {
            let dataDetector = try NSDataDetector(types: NSTextCheckingTypes(NSTextCheckingResult.CheckingType.link.rawValue))
            // 匹配字符串，返回结果集
            let res = dataDetector.matches(in: str, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, str.characters.count))
            // 取出结果
            for checkingRes in res {
                print((str as NSString).substring(with: checkingRes.range))
                if((str as NSString).substring(with: checkingRes.range) != ""){
                    isurl = 1
                }else{
                    isurl = 0
                }
            }
        }
        catch {
            print(error)
        }
        return isurl
    }
    @objc func tourlAction() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: ToWebViewController())))
            as! ToWebViewController
        controller.theurl = to_url
        controller.thetitle = "链接网址"
        controller.hidesBottomBarWhenPushed = true
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func messClick(_ sender: Any) {
        if(self.zt_hmess == 0){
            UIView.animate(withDuration: 1 , delay: 0 , usingSpringWithDamping: 0.6 , initialSpringVelocity: 8 , options: [] , animations: {
                self.v_hmess?.center.x += self.screenWidth+20
            }, completion: nil)
            self.zt_hmess = 1
            v_hmess?.isHidden = false
        }
        else{
            UIView.animate(withDuration: 1 , delay: 0 , usingSpringWithDamping: 0.6 , initialSpringVelocity: 8 , options: [] , animations: {
                self.v_hmess?.center.x -= self.screenWidth+20
            }, completion: nil)
            if(zt_sfqr == 0){
                self.perform(#selector(self.yincang), with: self, afterDelay: 0.3)
            }else{
                zt_sfqr = 1
            }
            
            self.zt_hmess = 0
        }
    }
    @objc func whitephone() {
        print("自动填写手机号")
        if UserDefaults.standard.object(forKey: "userPhoneNumber") != nil {
            thephone = UserDefaults.standard.object(forKey: "userPhoneNumber") as! String
            tf_pho?.text = thephone
        }
    }
    @objc func whiteemail() {
        print("自动填写邮箱")
        if UserDefaults.standard.object(forKey: "userEmail") != nil {
            theemail = UserDefaults.standard.object(forKey: "userEmail") as! String
            tf_ema?.text = theemail
        }
    }
    @objc func whiteQQ() {
        print("自动填写QQ")
        if UserDefaults.standard.object(forKey: "userQQ") != nil {
            theQQ = UserDefaults.standard.object(forKey: "userQQ") as! String
            tf_qq?.text = theQQ
        }
    }
    @objc func funLeft(sender: UIPanGestureRecognizer){
        print("取消")
        self.v_url?.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.3) {
            self.v_hmess?.center.x -= self.screenWidth+20
            self.perform(#selector(self.yincang), with: self, afterDelay: 0.3)
        }
        self.zt_hmess = 0
    }
    @objc func funRight(sender: UIPanGestureRecognizer){
        print("确定")
        var hmess_phone = tf_pho?.text
        var hmess_email = tf_ema?.text
        var hmess_QQ = tf_qq?.text
        if (hmess_phone == "") {
            let alertController = UIAlertController(title: "联系电话不能为空",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
        }
        if (hmess_email == "") {
            let alertController = UIAlertController(title: "邮箱地址不能为空",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
        }
        if (isTelNumber(num: hmess_phone as! NSString) == false) {
            showMsgbox(_message: "请输入正确的手机号")
            return
        }
        if (validateEmail(email: hmess_email as! String) == false) {
            showMsgbox(_message: "请输入正确的邮箱地址")
            return
        }
        else{
            self.v_url?.transform = CGAffineTransform.identity
            UIView.animate(withDuration: 0.3) {
                self.v_hmess?.center.x += self.screenWidth+20
            }
            self.zt_hmess = 1
            self.zt_sfqr = 1
            self.l_phone.text = hmess_phone
            self.l_qq.text = hmess_QQ
            self.l_email.text = hmess_email
            tv_selfmess.isHidden = false
        }
        
    }
    @objc func funDown(sender: UIPanGestureRecognizer){
        tv_selfmess.isHidden = true
        self.l_phone.text = ""
        self.l_qq.text = ""
        self.l_email.text = ""
    }
    
    //手机号正则表达式
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
    //邮箱正则表达式
    func validateEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
        
    }
    
    @IBAction func closemessview(_ sender: Any) {
        tv_selfmess.isHidden = true
        self.l_phone.text = ""
        self.l_qq.text = ""
        self.l_email.text = ""
    }

    @IBAction func callhelp(_ sender: Any) {
        print("即将打开QQ，联系客服？")
        let alertController = UIAlertController(title: "联系客服", message: "即将打开QQ，联系客服？",preferredStyle: .alert)
        let cancelAction1 = UIAlertAction(title: "确定", style: .destructive, handler: {
            action in
            self.CallQQ()
        })
        let cancelAction2 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction1)
        alertController.addAction(cancelAction2)
        self.present(alertController, animated: true, completion: nil)
    }
    func CallQQ() {
        print("帮助哟")
        // 按钮事件中唤醒QQ聊天界面
        let webView = UIWebView(frame: CGRect(x:30, y: (screenHeight-130)/2, width:screenWidth-60, height: 130))
        let url1 = URL(string: "mqq://im/chat?chat_type=wpa&uin=1252279088&version=1&src_type=web")
        let request = NSURLRequest(url: url1!)
        webView.delegate = self
        webView.loadRequest(request as URLRequest)
        webView.isHidden = true
        view.addSubview(webView)
    }
    @objc func yincang(){
        self.v_hmess?.isHidden = true
    }
}
