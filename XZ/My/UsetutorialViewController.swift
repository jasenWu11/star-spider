//
//  UsetutorialViewController.swift
//  XZ
//
//  Created by wjz on 2019/3/24.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit

class UsetutorialViewController: UIViewController {
    

    @IBOutlet weak var iv_tp8: UIImageView!
    @IBOutlet weak var tv_ms8: UITextView!
    @IBOutlet weak var iv_tp7: UIImageView!
    @IBOutlet weak var tv_ms7: UITextView!
    @IBOutlet weak var l_bt5: UILabel!
    @IBOutlet weak var iv_tp6: UIImageView!
    @IBOutlet weak var tv_ms6: UITextView!
    @IBOutlet weak var iv_tp5: UIImageView!
    @IBOutlet weak var tv_ms5: UITextView!
    @IBOutlet weak var l_bt4: UILabel!
    @IBOutlet weak var iv_tp4: UIImageView!
    @IBOutlet weak var tv_ms4: UITextView!
    @IBOutlet weak var iv_tb3: UIImageView!
    @IBOutlet weak var tv_ms3: UITextView!
    @IBOutlet weak var l_bt3: UILabel!
    @IBOutlet weak var iv_tp2: UIImageView!
    @IBOutlet weak var tv_ms2: UITextView!
    @IBOutlet weak var l_bt2: UILabel!
    @IBOutlet weak var iv_tp1: UIImageView!
    @IBOutlet weak var tv_ms1: UITextView!
    @IBOutlet weak var l_bt1: UILabel!
    
    @IBOutlet weak var sv_jc: UIScrollView!
    let screenWidth =  UIScreen.main.bounds.size.width
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "使用教程"
        sv_jc.frame.size.height = 5482
        l_bt1.frame.size.width = screenWidth-16
        tv_ms1.frame.size.width = screenWidth-16
        iv_tp1.frame.size.width = screenWidth-16
        l_bt2.frame.size.width = screenWidth-16
        tv_ms2.frame.size.width = screenWidth-16
        iv_tp2.frame.size.width = screenWidth-16
        l_bt3.frame.size.width = screenWidth-16
        tv_ms3.frame.size.width = screenWidth-16
        iv_tb3.frame.size.width = screenWidth-16
        tv_ms4.frame.size.width = screenWidth-16
        iv_tp4.frame.size.width = screenWidth-16
        l_bt4.frame.size.width = screenWidth-16
        tv_ms5.frame.size.width = screenWidth-16
        iv_tp5.frame.size.width = screenWidth-16
        tv_ms6.frame.size.width = screenWidth-16
        iv_tp6.frame.size.width = screenWidth-16
        tv_ms7.frame.size.width = screenWidth-16
        iv_tp7.frame.size.width = screenWidth-16
        tv_ms8.frame.size.width = screenWidth-16
        iv_tp8.frame.size.width = screenWidth-16
        l_bt5.frame.size.width = screenWidth-16
        //是否可以滚动
        sv_jc.isScrollEnabled = true
        //垂直方向反弹
        sv_jc.alwaysBounceVertical = true
        //垂直方向是否显示滚动条
        sv_jc.showsVerticalScrollIndicator = false
        sv_jc.contentSize = CGSize(width: screenWidth,
                                     height: 5482);
        // Do any additional setup after loading the view.
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
