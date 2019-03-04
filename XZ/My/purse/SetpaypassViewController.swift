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
    @IBOutlet weak var tv_pass: UITextField!
    var userid:Int = 0
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        userid = UserDefaults.standard.object(forKey: "userId") as! Int
        // Do any additional setup after loading the view.
    }
    @IBAction func setpass(_ sender: Any) {
        if (tv_pass.text == "") {
            showMsgbox(_message: "请输入支付密码")
        }
        else{
            setUserPayPassword()
        }
    }
    func setUserPayPassword()  {
        var paypass:String = tv_pass.text!
        let url = "https://www.xingzhu.club/XzTest/users/setUserPayPassword"
        let paras = ["userId":userid,"userPayPassword":paypass] as [String : Any]
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("jsonRequest:\(response.result)")
            let data = response.result.value
            print("结果:\(data)")
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
    func showMsgbox(_message: String, _title: String = "提示"){
        
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
