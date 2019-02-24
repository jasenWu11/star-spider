//
//  CustommadeViewController.swift
//  XZ
//
//  Created by wjz on 2019/1/25.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit
import Alamofire
class CustommadeViewController: UIViewController {

    @IBOutlet weak var bt_tj: UIButton!
    @IBOutlet weak var tf_web: UITextView!
    @IBOutlet weak var tv_data: UITextField!
    @IBOutlet weak var sv_dz: UIScrollView!
    @IBOutlet weak var tf_rem: UITextView!
    @IBOutlet weak var tv_QQ: UITextField!
    @IBOutlet weak var tv_email: UITextField!
    @IBOutlet weak var tv_phone: UITextField!
    var webs : String = ""
    var datas : String = ""
    var remas : String = ""
    var phones : String = ""
    var qqs : String = ""
    var emails : String = ""
    var userid:Int = 0
    let screenWidth =  UIScreen.main.bounds.size.width
    override func viewDidLoad() {
        super.viewDidLoad()
        userid = UserDefaults.standard.object(forKey: "userId") as! Int
        tf_web?.backgroundColor=UIColor.white
        tf_web?.clipsToBounds=true
        tf_web?.layer.cornerRadius = 10
        tf_web?.layer.shadowColor = UIColor.gray.cgColor
        tf_web?.layer.shadowOpacity = 1.0
        tf_web?.layer.shadowOffset = CGSize(width: 0, height: 0)
        tf_web?.layer.shadowRadius = 4
        tf_web?.layer.masksToBounds = false
        
        tf_rem?.backgroundColor=UIColor.white
        tf_rem?.clipsToBounds=true
        tf_rem?.layer.cornerRadius = 10
        tf_rem?.layer.shadowColor = UIColor.gray.cgColor
        tf_rem?.layer.shadowOpacity = 1.0
        tf_rem?.layer.shadowOffset = CGSize(width: 0, height: 0)
        tf_rem?.layer.shadowRadius = 4
        tf_rem?.layer.masksToBounds = false
        
        //是否可以滚动
        sv_dz.isScrollEnabled = false
        //垂直方向反弹
        sv_dz.alwaysBounceVertical = true
        //垂直方向是否显示滚动条
        sv_dz.showsVerticalScrollIndicator = false
        sv_dz.contentSize = CGSize(width: screenWidth,
                                     height: 1500);

        bt_tj?.setTitle("提交需求", for: UIControl.State.normal)
        bt_tj?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        bt_tj?.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        bt_tj?.backgroundColor = UIColorRGB_Alpha(R: 0.0, G: 140.0, B: 255.0, alpha: 0.8);
        
        // Do any additional setup after loading the view.
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
    
    @IBAction func Custommade(_ sender: Any) {
        webs = tf_web.text
        datas = tv_data.text ?? ""
        remas = tf_rem.text
        phones = tv_phone.text ?? ""
        qqs = tv_QQ.text ?? ""
        emails = tv_email.text ?? ""
        if(webs == ""){
            showMsgbox(_message: "请输入网站链接")
            return
        }
        if(datas == ""){
            showMsgbox(_message: "请输入需爬取的数据")
            return
        }
        if(phones == ""){
            showMsgbox(_message: "请输入您的手机号码")
            return
        }else{
            postDemand()
        }
    }
    @objc func postDemand()  {
        
        let url = "https://www.xingzhu.club/XzTest/demands/postDemand"
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        let paras = ["userId":self.userid,"demandWeb":self.webs,"demandData":self.datas,"demandRemarks":self.remas,"demandPhoneNumber":self.phones,"demandEmail":self.emails,"demandQq":self.qqs] as [String : Any]
        print("网站\(self.webs)")
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
}
