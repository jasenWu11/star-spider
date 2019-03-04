//
//  ViewController1.swift
//  XZ
//
//  Created by wjz on 2019/1/11.
//  Copyright © 2019年 wjz. All rights reserved.
//
import UIKit

//子视图控制器1
class ViewController1: UIViewController {
     var root : ShopTableViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        let resclick = UITapGestureRecognizer(target: self, action: #selector(resAction))
        
        view.backgroundColor = UIColor.orange
        
        let textLabel = UILabel(frame: CGRect(x: 0, y: 100, width: self.view.frame.width,
                                              height: 30))
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 33)
        textLabel.textColor = .white
        textLabel.text = "电影"
        view.addSubview(textLabel)
        textLabel.addGestureRecognizer(resclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        textLabel.isUserInteractionEnabled = true
    }
    @objc func resAction() -> Void {
        
        let controller = root?.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: RegisterViewController())))
            as! RegisterViewController
        root?.present(controller, animated: true, completion: nil)
    }
}
