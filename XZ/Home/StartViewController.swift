//
//  StartViewController.swift
//  XZ
//
//  Created by wjz on 2018/12/27.
//  Copyright © 2018年 wjz. All rights reserved.
//

import UIKit
import Alamofire
class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        var olduser : String = "";
        var oldhead : String = "";
        if UserDefaults.standard.object(forKey: "userPhoneNumber") != nil {
            olduser = UserDefaults.standard.object(forKey: "userPhoneNumber") as! String
        }
        print("以前的文本框的值等于"+olduser)
        if UserDefaults.standard.object(forKey: "userProfilePhoto") != nil {
            oldhead = UserDefaults.standard.object(forKey: "userProfilePhoto") as! String
        }
        print("以前的头像等于"+oldhead)
        let time: TimeInterval = 2.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            //code
            if (olduser == ""){
                self.ToLoginAction()
            }
            else
            {self.ToMainAction()}
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func ToLoginAction() -> Void {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: theloginUINavigationController())))
            as! theloginUINavigationController
       self.present(controller, animated: true, completion: nil)
    }
    @objc func ToMainAction() -> Void {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: MainViewController())))
            as! MainViewController
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

//    func jsonRequest()  {
//
//        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
//        Alamofire.request("http://119.29.88.72:8080/XzTest/user/connectTest", method: .post, parameters: [:], encoding: JSONEncoding.default, headers: nil)
//            .responseJSON { (response) in
//                print("jsonRequest:\(response.result)")
//
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                }
//        }
//    }
}
