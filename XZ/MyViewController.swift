//
//  MyViewController.swift
//  XZ
//
//  Created by wjz on 2018/12/20.
//  Copyright © 2018年 wjz. All rights reserved.
//

import UIKit
import Alamofire
class MyViewController: UIViewController {

    @IBOutlet weak var iv_head: UIImageView!
    @IBOutlet weak var messv: UIView!
    @IBOutlet weak var message: UIView!
    @IBOutlet weak var Sugg: UIView!
    @IBOutlet weak var sett: UIView!
    @IBOutlet weak var tv_phone: UILabel!
    @IBOutlet weak var tv_name: UILabel!
    var userphone = ""
    var username = ""
    var nameph:String = ""
    @IBAction func TZ(_ sender: Any) {
        
        let secondViewController = MymessViewController()
        self.present(secondViewController, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        let suggclick = UITapGestureRecognizer(target: self, action: #selector(suggAction))
        Sugg.addGestureRecognizer(suggclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        Sugg.isUserInteractionEnabled = true
        
        let settclick = UITapGestureRecognizer(target: self, action: #selector(settAction))
        sett.addGestureRecognizer(settclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        sett.isUserInteractionEnabled = true
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
    //点击事件方法
    @objc func myAction() -> Void {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: MymessViewController())))
            as! MymessViewController
        controller.name = username
        controller.root = self
        self.present(controller, animated: true, completion: nil)
    }
    //点击事件方法
    @objc func messAction() -> Void {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: MessageViewController())))
            as! MessageViewController
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
