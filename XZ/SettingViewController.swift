//
//  SettingViewController.swift
//  XZ
//
//  Created by wjz on 2018/12/21.
//  Copyright © 2018年 wjz. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var loset: UIButton!
    @IBOutlet weak var zhanyin: UIView!
    @IBOutlet weak var abus: UIView!
    var user: String = ""
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let zhclick = UITapGestureRecognizer(target: self, action: #selector(zhAction))
        zhanyin.addGestureRecognizer(zhclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        zhanyin.isUserInteractionEnabled = true
        
        let abclick = UITapGestureRecognizer(target: self, action: #selector(abAction))
        abus.addGestureRecognizer(abclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        abus.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
        let losetclick = UITapGestureRecognizer(target: self, action: #selector(losetAction))
        loset.addGestureRecognizer(losetclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        loset.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    //点击事件方法
    @objc func zhAction() -> Void {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: ZhanyinViewController())))
            as! ZhanyinViewController
        self.present(controller, animated: true, completion: nil)
    }
    //点击事件方法
    @objc func abAction() -> Void {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: AboutusViewController())))
            as! AboutusViewController
        self.present(controller, animated: true, completion: nil)
    }
    @objc func losetAction() -> Void {
        user = ""
        print("文本框的值等于"+user)
        UserDefaults.standard.set(user, forKey: "user")
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: LoginViewController())))
            as! LoginViewController
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
