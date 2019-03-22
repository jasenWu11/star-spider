//
//  MymessViewController.swift
//  XZ
//
//  Created by wjz on 2018/12/20.
//  Copyright © 2018年 wjz. All rights reserved.
//

import UIKit
import Alamofire
class MymessViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var v_email: UIView!
    @IBOutlet weak var v_name: UIView!
    @IBOutlet weak var tv_ye: UILabel!
    @IBOutlet weak var iv_head: UIImageView!
    @IBOutlet weak var tv_name: UILabel!
    @IBOutlet weak var tv_phone: UILabel!
    @IBOutlet weak var tv_email: UILabel!
    var root : MyViewController?
    var imgs :UIImageView!
    var sheet:UIAlertController!
    var headph : String = "";
    var nameph:String = ""
    var emailph:String = ""
    var nhead:String = ""
    var phoneph:String = ""
    let screenWidth =  UIScreen.main.bounds.size.width
    var sourceType = UIImagePickerController.SourceType.photoLibrary //将sourceType赋一个初值类型，防止调用时不赋值出现崩溃

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "资料管理"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title:"保存",style:UIBarButtonItem.Style.plain,target:self,action:#selector(messagechange))
        tv_ye.textAlignment = .right
        tv_name.frame.origin.x = screenWidth-125
        tv_name.textAlignment = .right
        
        tv_phone.frame.origin.x = screenWidth-175
        tv_phone.textAlignment = .right
        
        tv_email.frame.origin.x = screenWidth-275
        tv_email.textAlignment = .right
        
        imgs = UIImageView(frame: CGRect(x: 20, y: 120, width: 100, height: 100))
        self.view.addSubview(imgs)
        //头像
        if UserDefaults.standard.object(forKey: "userProfilePhoto") != nil {
            headph = UserDefaults.standard.object(forKey: "userProfilePhoto") as! String
        }
        if UserDefaults.standard.object(forKey: "userName") != nil {
            nameph = UserDefaults.standard.object(forKey: "userName") as! String
        }
        if UserDefaults.standard.object(forKey: "userPhoneNumber") != nil {
            phoneph = UserDefaults.standard.object(forKey: "userPhoneNumber") as! String
        }
        if UserDefaults.standard.object(forKey: "userEmail") != nil {
            emailph = UserDefaults.standard.object(forKey: "userEmail") as! String
        }
        nhead = headph
        //jsonRequest()
        iv_head.layer.cornerRadius = 18
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
        print("获取的用户名\(nameph)")
        if(phoneph != ""){
            tv_phone.text = replacePhone(phone: phoneph)
        }
        
        if(emailph != ""){
            tv_email.text = emailph
        }
        
        let headch = UITapGestureRecognizer(target: self, action: #selector(showActionSheet))
        iv_head.addGestureRecognizer(headch)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        iv_head.isUserInteractionEnabled = true
        //用户名视图手势
        let namech = UITapGestureRecognizer(target: self, action: #selector(namechange))
        v_name.addGestureRecognizer(namech)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        v_name.isUserInteractionEnabled = true
        //邮箱视图手势
        let emailch = UITapGestureRecognizer(target: self, action: #selector(emailchange))
        v_email.addGestureRecognizer(emailch)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        v_email.isUserInteractionEnabled = true
        //联系方式
        var phones : String = "";
        if UserDefaults.standard.object(forKey: "userPhoneNumber") != nil {
            phones = UserDefaults.standard.object(forKey: "userPhoneNumber") as! String
        }
        var yuer : Double = 0;
        if UserDefaults.standard.object(forKey: "userBalance") != nil {
            yuer = UserDefaults.standard.object(forKey: "userBalance") as! Double
        }
        print("余额\(yuer)")
        tv_ye.text = "¥\(yuer)"
        //vip
        var vips : Int = 0;
        if UserDefaults.standard.object(forKey: "isVip") != nil {
            vips = UserDefaults.standard.object(forKey: "isVip") as! Int
        }
        // Do any additional setup after loading the view.
    }
    var name:String = ""
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //对话框
    func showMsgbox(_message: String, _title: String = "提示"){
        
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
        
    }
    @objc func namechange() {
        var inputText:UITextField = UITextField();
        let msgAlertCtr = UIAlertController.init(title: "更改用户名", message: "请输入用户名", preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "确定", style:.destructive) { (action:UIAlertAction) ->() in
            if((inputText.text) != ""){
                print("你输入的是：\(String(describing: inputText.text))")
                var nname:String = inputText.text!
                self.tv_name.text = nname
            }
        }
        
        let cancel = UIAlertAction.init(title: "取消", style:.cancel) { (action:UIAlertAction) -> ()in
            print("取消输入")
        }
        
        msgAlertCtr.addAction(ok)
        msgAlertCtr.addAction(cancel)
        //添加textField输入框
        msgAlertCtr.addTextField { (textField) in
            //设置传入的textField为初始化UITextField
            inputText = textField
            inputText.placeholder = "输入数据"
        }
        //设置到当前视图
        self.present(msgAlertCtr, animated: true, completion: nil)
    }
    
    @objc func emailchange() {
        var inputText:UITextField = UITextField();
        let msgAlertCtr = UIAlertController.init(title: "更改邮箱", message: "请输入邮箱", preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "确定", style:.destructive) { (action:UIAlertAction) ->() in
            if((inputText.text) != ""){
                print("你输入的是：\(String(describing: inputText.text))")
                var nemail:String = inputText.text!
                self.tv_email.text = nemail
            }
            else if(inputText.text == ""){
                self.showMsgbox(_message: "用户名不能为空")
            }
        }
        
        let cancel = UIAlertAction.init(title: "取消", style:.cancel) { (action:UIAlertAction) -> ()in
            print("取消输入")
        }
        
        msgAlertCtr.addAction(ok)
        msgAlertCtr.addAction(cancel)
        //添加textField输入框
        msgAlertCtr.addTextField { (textField) in
            //设置传入的textField为初始化UITextField
            inputText = textField
            inputText.placeholder = "输入数据"
        }
        //设置到当前视图
        self.present(msgAlertCtr, animated: true, completion: nil)
    }
    
    //弹出底部警告框
    @objc func showActionSheet() {
        let actionSheet = UIAlertController(title: "上传头像", message: nil, preferredStyle: .actionSheet)
        let cancelBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        
        let takePhotos = UIAlertAction(title: "拍照", style: .destructive, handler: {
            (action: UIAlertAction) -> Void in
            //判断是否能进行拍照，可以的话打开相机
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                // 表示操作为拍照
                imagePicker.sourceType = .camera
                // 拍照后允许用户进行编辑
                imagePicker.allowsEditing = true
                // 也可以设置成视频
                imagePicker.cameraCaptureMode = .photo
                // 设置代理为 ViewController，已经实现了协议
                imagePicker.delegate = self
                // 进入拍照界面
                self.present(imagePicker, animated: true, completion: nil)
            }else {
                // 照相机不可用
                self.showMsgbox(_message: "模拟其中无法打开照相机,请在真机中使用")
            }
            
        })
        let selectPhotos = UIAlertAction(title: "相册选取", style: .default, handler: {
            (action:UIAlertAction)
            -> Void in
            //调用相册功能，打开相册
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
            
        })
        actionSheet.addAction(cancelBtn)
        actionSheet.addAction(takePhotos)
        actionSheet.addAction(selectPhotos)
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    //正确的写法
    //MARK: - UIImagePickerControllerDelegate、UINavigationControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //UIImagePickerControllerOriginalImage  原始图像
        //UIImagePickerControllerEditedImage    编辑后的图片(开启编辑该对象才存在)
        print("图片结果\(info)")
        self.dismiss(animated: true, completion: {
            var img:UIImage? = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            if picker.allowsEditing {
                img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            }
            
            self.iv_head.image = img
            var data = img?.jpegData(compressionQuality:1)
            while data!.count/1024 > 100{
                data = img?.jpegData(compressionQuality:0.1)// 压缩比例在0~1之间
            }
            
            let newimage:UIImage? = UIImage(data: data!)
            self.updataimage(imagename: newimage!)
        })
    }
    func  updataimage(imagename:UIImage){
        let imageData = imagename.jpegData(compressionQuality:1)
        var url:String = "https://www.xingzhu.club/XzTest/users/uploadImg"
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            //采用post表单上传
            // 参数解释：
            //withName:和后台服务器的name要一致 ；fileName:可以充分利用写成用户的id，但是格式要写对； mimeType：规定的，要上传其他格式可以自行百度查一下
            multipartFormData.append(imageData!, withName: "file", fileName: "123456.jpg", mimeType: "image/png")
            //如果需要上传多个文件,就多添加几个
            //multipartFormData.append(imageData, withName: "file", fileName: "123456.jpg", mimeType: "image/jpeg")
            //......
            
            }, usingThreshold: (10*1024*1024), to: URL.init(string: url)!, method: HTTPMethod.post, headers: nil) { (encodingResult) in
                switch encodingResult {
                case .success(let upload, _, _):
                    //连接服务器成功后，对json的处理
                    upload.responseJSON { response in
                        //解包
                        guard let result = response.result.value else { return }
                        print("json:\(result)")
                        let json = JSON(result)
                        print("结果:\(json)")
                        var code: Int = json["code"].int!
                        print("错误:\(code)")
                        var message: String = json["message"].string!
                        print("返回结果\(message)")
                        if(message == "上传图片成功！"){
                            let headmess = json["data"]
                            self.nhead = headmess["userProfilePhoto"].string ?? ""
                            print("headmess是\(headmess)")
                            print("nhead是\(self.nhead)")
                        }
                    }
                    //获取上传进度
                    upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                        print("图片上传进度: \(progress.fractionCompleted)")
                    }
                case .failure(let encodingError):
                    //打印连接失败原因
                    print(encodingError)
                }
        }

  }
    
    @objc func messagechange(_ sender: Any) {
        let url = "https://www.xingzhu.club/XzTest/users/putUser"
        var nname:String = tv_name.text ?? ""
        var userid:Int = UserDefaults.standard.object(forKey: "userId") as! Int
        var nemail = tv_email.text
        if(nname == ""){
            showMsgbox(_message: "用户名不能为空")
        }
        else{
            let paras = ["userId":userid,"userName":nname,"userEmail":nemail,"userProfilePhoto":nhead] as [String : Any]
            print("用户ID是\(userid),用户名称是\(nname),用户邮箱是\(nemail),用户头像是\(nhead)")
            Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                print("jsonRequest:\(response.result)")
                if let jdata = response.result.value {
                    let json = JSON(jdata)
                    print("结果:\(json)")
                    var code: Int = json["code"].int!
                    print("错误:\(code)")
                    var message: String = json["message"].string!
                    print("返回结果\(message)")
                    if(message == "更新成功"){
                        let alertController = UIAlertController(title: message,
                                                                message: nil, preferredStyle: .alert)
                        //显示提示框
                        self.present(alertController, animated: true, completion: nil)
                        //两秒钟后自动消失
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                            self.presentedViewController?.dismiss(animated: false, completion: nil)
                        }
                        self.tv_name.text = nname
                        self.tv_email.text = nemail
                        if(self.nhead != ""){
                            let url = URL(string:self.nhead)
                            let data = try! Data(contentsOf: url!)
                            let smallImage = UIImage(data: data)
                            self.iv_head.image = smallImage
                            UserDefaults.standard.set(self.nhead, forKey: "userProfilePhoto")
                            UserDefaults.standard.set(nname, forKey: "userName")
                            UserDefaults.standard.set(nemail, forKey: "userEmail")
                        }
                        self.nameph = nname
                        self.headph = self.nhead
                        self.root!.tv_name.text = self.nameph
                        if(self.headph != ""){
                            let url = URL(string:self.headph)
                            let data = try! Data(contentsOf: url!)
                            let smallImage = UIImage(data: data)
                            self.root!.iv_head.image = smallImage
                        }
                    }
            }
         }
     }
   }
    //替换字符串
    func replacePhone(phone:String) -> String {
        var a=NSString(string:phoneph)
        print("替换前：\(a)")
        var b=a.replacingCharacters(in: NSMakeRange(3, 4),with: "****")
        print("替换后：\(b)")
        return b
    }
}
