//
//  ViewController1.swift
//  XZ
//
//  Created by wjz on 2019/1/24.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit

//子视图控制器1
class ViewController1: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.orange
        
        let textLabel = UILabel(frame: CGRect(x: 0, y: 100, width: self.view.frame.width,
                                              height: 30))
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 33)
        textLabel.textColor = .white
        textLabel.text = "电影"
        view.addSubview(textLabel)
    }
}
