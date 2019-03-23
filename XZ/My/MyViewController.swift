//
//  MyViewController.swift
//  XZ
//
//  Created by wjz on 2018/12/20.
//  Copyright © 2018年 wjz. All rights reserved.
//

import UIKit
import Alamofire
import MobileCoreServices
import MessageUI
class MyViewController: UIViewController ,MFMailComposeViewControllerDelegate{
    @IBOutlet weak var l_fssj: UIView!
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
    var olduser : String = ""
    var oldpwd : String = ""
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
    var headph : String = "";
    /// lazy load
    lazy var payPasswordView: WMPasswordView = {
        let pwdView = WMPasswordView(type: WMPwdType.payPwd, amount: 250.0)
        /// 回调 closure 可以在本类任意方法类写
        pwdView.completed = { [weak self] pwd in
            print("输入的密码是\(pwd)")
        }
        return pwdView
    }()
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
    var _scene = Int32(WXSceneSession.rawValue)
    var pcname:[String] = []
    @IBAction func TZ(_ sender: Any) {
        
        let secondViewController = MymessViewController()
        self.present(secondViewController, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllDataname()
        iv_head.frame.origin.x = (screenWidth-70)/2
        //关闭导航栏半透明效果
        self.navigationController?.navigationBar.isTranslucent = false
        tv_name!.frame.origin.x = (screenWidth-100)/2
        tv_name?.textAlignment=NSTextAlignment.center
        
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
        setmess()
        let myclick = UITapGestureRecognizer(target: self, action: #selector(myAction))
        iv_head.addGestureRecognizer(myclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        iv_head.isUserInteractionEnabled = true
        
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
        
        let fssjclick = UITapGestureRecognizer(target: self, action: #selector(sendData))
        l_fssj.addGestureRecognizer(fssjclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        l_fssj.isUserInteractionEnabled = true
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
        if UserDefaults.standard.object(forKey: "userPhoneNumber") != nil {
            olduser = UserDefaults.standard.object(forKey: "userPhoneNumber") as! String
            oldpwd = UserDefaults.standard.object(forKey: "userPwd") as! String
            
        }
        textzm()
        getUnreadNoticeCount()
        // The rest of your code.
    }
    func setmess(){
        if(headph != ""){
            if let url = URL(string:headph){
                let data = try! Data(contentsOf: url)
                let smallImage = UIImage(data: data)
                iv_head.image = smallImage
            }
            
        }
        if(nameph != ""){
            tv_name.text = nameph
        }
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
                    if(counts == 0){
                        self.l_mess.isHidden = true
                    }else{
                        self.l_mess.isHidden = false
                        self.l_mess.text = "\(counts)"
                    }
                }
        }
    }
    
    //点击事件方法
    @objc func myAction() -> Void {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: MymessViewController())))
            as! MymessViewController
        controller.name = username
        controller.root = self
        controller.hidesBottomBarWhenPushed = true
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    //点击事件方法
    @objc func purseAction() -> Void {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: PurseViewController())))
            as! PurseViewController
        controller.hidesBottomBarWhenPushed = true
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    //点击事件方法
    @objc func messAction() -> Void {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: messagepagViewcontroller())))
            as! messagepagViewcontroller
        controller.hidesBottomBarWhenPushed = true
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    //点击事件方法
    @objc func suggAction() -> Void {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: SuggestViewController())))
            as! SuggestViewController
        controller.hidesBottomBarWhenPushed = true
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    //点击事件方法
    @objc func settAction() -> Void {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: SettingViewController())))
            as! SettingViewController
        controller.hidesBottomBarWhenPushed = true
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    //点击事件方法
    @objc func qbddAction() -> Void {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: MyorderpagViewController())))
            as! MyorderpagViewController
        controller.hidesBottomBarWhenPushed = true
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    //发送纯文本
    @IBAction func sendTextContent(_ sender: AnyObject) {
        let message =  WXMediaMessage()
        
        message.title = "欢迎访问 hangge.com"
        message.description = "做最好的开发者知识平台。分享各种编程开发经验。"
        message.setThumbImage(UIImage(named:"apple.png"))
        
        let ext =  WXWebpageObject()
        ext.webpageUrl = "http://hangge.com"
        message.mediaObject = ext
        
        let req =  SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = _scene
        WXApi.send(req)
    }
    
    @objc func getAllDataname()  {
        let url = "https://www.xingzhu.club/XzTest/datasource/getAllDataSource"
        var userid:Int = UserDefaults.standard.object(forKey: "userId") as! Int
        let paras = ["userId":userid]
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
                let provinces = json["data"]
                self.pcname.removeAll()
                for i in 0..<provinces.count{
                    let dataSourceName: String = provinces[i]["dataSourceName"].string ?? ""
                    self.pcname += [dataSourceName]
                }
            }
            print("数据源名是\(self.pcname)")
        }
    }
    @objc func sendData(){
       viewDidAppear()
    }
    @objc func viewDidAppear(){
        
        
        let alertController = UIAlertController(title: "压缩密码",
                                                message: "请输入4位压缩密码", preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "压缩密码"
            textField.addChangeTextTarget()
            textField.maxTextNumber = 12
            textField.isSecureTextEntry = true
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let noAction = UIAlertAction(title: "不用", style: .default, handler: {
            action in
                self.toemail(pass: "")
        })
        let okAction = UIAlertAction(title: "确定", style: .destructive, handler: {
            action in
            //也可以用下标的形式获取textField let login = alertController.textFields![0]
            let oldpass = alertController.textFields!.first!
            var opass = oldpass.text
            print("压缩密码：\(oldpass.text)")
            if(opass == ""){
                self.showMsgbox(_message: "压缩密码不能为空")
            }
            else if((opass?.count)! != 4){
                self.showMsgbox(_message: "压缩密码为4位数")
            }
            else{
                self.toemail(pass: opass!)
            }
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        alertController.addAction(noAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func toemail(pass:String){
        //0.首先判断设备是否能发送邮件
        if MFMailComposeViewController.canSendMail() {
            //1.配置邮件窗口
            let mailView = configuredMailComposeViewController(pwd: pass)
            //2. 显示邮件窗口
            present(mailView, animated: true, completion: nil)
        } else {
            print("Whoop...设备不能发送邮件")
            showSendMailErrorAlert()
        }
    }
    //处理分享返回结果
    func handleSendResult(sendResult:QQApiSendResultCode){
        var message = ""
        switch(sendResult){
        case EQQAPIAPPNOTREGISTED:
            message = "App未注册"
        case EQQAPIMESSAGECONTENTINVALID, EQQAPIMESSAGECONTENTNULL,
             EQQAPIMESSAGETYPEINVALID:
            message = "发送参数错误"
        case EQQAPIQQNOTINSTALLED:
            message = "QQ未安装"
        case EQQAPIQQNOTSUPPORTAPI:
            message = "API接口不支持"
        case EQQAPISENDFAILD:
            message = "发送失败"
        case EQQAPIQZONENOTSUPPORTTEXT:
            message = "空间分享不支持纯文本分享，请使用图文分享"
        case EQQAPIQZONENOTSUPPORTIMAGE:
            message = "空间分享不支持纯图片分享，请使用图文分享"
        default:
            message = "发送成功"
        }
        print(message)
    }
    //MARK:- helper methods
    //配置邮件窗口
    func configuredMailComposeViewController(pwd:String) -> MFMailComposeViewController {
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        var files:[Any] = []
        for element in self.pcname {
            let jsonPath = (docDir as NSString).appendingPathComponent("\(element).xlsx")
            files += [jsonPath]
        }
        let zipPath3 = docDir+"/DataSource.zip"
        print("输出数据为\(files)")
        if(pwd == ""){
           SSZipArchive.createZipFile(atPath: zipPath3, withFilesAtPaths: files as! [String])
        }
        else{
            SSZipArchive.createZipFile(atPath: zipPath3, withFilesAtPaths: files as! [String],withPassword: pwd)
        }
        
        print("发送的东西是\(zipPath3)")
       
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        //测试1
        let mimeType1 = mimeType(pathExtension: "gif")
        print("文件1是\(mimeType1)")
        //设置邮件地址、主题及正文
        mailComposeVC.setToRecipients(["1252279088@qq.com"])
        mailComposeVC.setSubject("所有最新数据源")
        if(pwd == ""){
            mailComposeVC.setMessageBody("发送所有最新数据源至邮箱", isHTML: false)
        }
        else{
            mailComposeVC.setMessageBody("发送所有最新数据源至邮箱,压缩密码为\(pwd)", isHTML: false)
        }
        //添加文件附件
        let url = URL(fileURLWithPath: zipPath3)
        let mimeType2 = mimeType(pathExtension: url.pathExtension)
        print("文件类型是\(mimeType2)")
        let myData = try! Data(contentsOf: url)
        mailComposeVC.addAttachmentData(myData, mimeType: mimeType2, fileName: "DataSource.zip")
        return mailComposeVC
    }
    
    
    //提示框，提示用户设置邮箱
    func showSendMailErrorAlert() {
        
        let sendMailErrorAlert = UIAlertController(title: "未开启邮件功能", message: "设备邮件功能尚未开启，请在设置中更改", preferredStyle: .alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: "确定", style: .default) { _ in })
        self.present(sendMailErrorAlert, animated: true){}
    }
    
    
    //MARK:- Mail Delegate
    //用户退出邮件窗口时被调用
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue{
        case MFMailComposeResult.sent.rawValue:
            print("邮件已发送")
        case MFMailComposeResult.cancelled.rawValue:
            print("邮件已取消")
        case MFMailComposeResult.saved.rawValue:
            print("邮件已保存")
        case MFMailComposeResult.failed.rawValue:
            print("邮件发送失败")
        default:
            print("邮件没有发送")
            break
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    //根据后缀获取对应的Mime-Type
    func mimeType(pathExtension: String) -> String {
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,
                                                           pathExtension as NSString,
                                                           nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?
                .takeRetainedValue() {
                return mimetype as String
            }
        }
        //文件资源类型如果不知道，传万能类型application/octet-stream，服务器会自动解析文件类
        return "application/octet-stream"
    }
    func showMsgbox(_message: String, _title: String = "提示"){
        
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
        
    }
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
                    self.userProfilePhoto = usermess["userProfilePhoto"].string ?? ""
                    self.userName = usermess["userName"].string ?? ""
                    self.tomainor()
                }
                else if(message == "帐号或密码不正确"){
                    let alertController = UIAlertController(title: "账号密码被修改，请重新登录",
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
        }
    }
    func tomainor() {
        UserDefaults.standard.set(userProfilePhoto, forKey: "userProfilePhoto")
        UserDefaults.standard.set(userName, forKey: "userName")
        tv_name.text = self.userName
        if let url = URL(string:self.userProfilePhoto){
            let data = try! Data(contentsOf: url)
            let smallImage = UIImage(data: data)
            iv_head.image = smallImage
        }
    }
    @objc func ToLoginAction() -> Void {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: theloginUINavigationController())))
            as! theloginUINavigationController
        self.present(controller, animated: true, completion: nil)
    }
}
