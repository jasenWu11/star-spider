//
//  ShiliViewController.swift
//  XZ
//
//  Created by wjz on 2019/1/24.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit

class ShiliViewController: UIViewController {
    var root : APImessViewController?
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    var pids:Int = 0
    var shiliView : UIView?
    var tv_shili : UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColorRGB_Alpha(R: 238.0, G: 238.0, B: 238.0, alpha: 0.8);
        // Do any additional setup after loading the view.
        //返回示例视图
        shiliView = UIView(frame: CGRect(x:0, y: 0, width:screenWidth, height: 40))
        shiliView?.backgroundColor=UIColorRGB_Alpha(R: 50.0, G: 184.0, B: 208.0, alpha: 0.8);
        shiliView?.clipsToBounds=true
        shiliView?.layer.shadowColor = UIColor.gray.cgColor
        shiliView?.layer.shadowOpacity = 1.0
        shiliView?.layer.shadowOffset = CGSize(width: 0, height: 0)
        shiliView?.layer.shadowRadius = 4
        shiliView?.layer.masksToBounds = false
        view.addSubview(shiliView!)
        //返回示例标签
        tv_shili = UILabel(frame: CGRect(x:10, y: 5, width:screenWidth-20, height: 30))
        tv_shili?.font = UIFont.systemFont(ofSize: 18)
        tv_shili?.textColor = UIColor.black
        tv_shili?.numberOfLines = 0
        tv_shili?.lineBreakMode = NSLineBreakMode.byWordWrapping
        shiliView?.addSubview(tv_shili!)
        tv_shili?.text = "返回数据示例"
        tv_shili?.textAlignment=NSTextAlignment.left
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    /// 设置颜色与透明度（RGB：0.0~255.0；alpha：0.0~1.0） 示例：UIColorRGB_Alpha(100.0, 100.0, 20.0, 1.0)
    func UIColorRGB_Alpha(R:CGFloat, G:CGFloat, B:CGFloat, alpha:CGFloat) -> UIColor
    {
        let color = UIColor.init(red: (R / 255.0), green: (G / 255.0), blue: (B / 255.0), alpha: alpha);
        return color;
    }
}
