//
//  HistoryViewController.swift
//  XZ
//
//  Created by wjz on 2019/2/9.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    var root : APImessViewController?
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    var pids:Int = 0
    var provers:String = ""
    var prouptime:String = ""
    var v_new : UIView?
    var v_need : UIButton?
    var l_need : UILabel?
    var v_noed : UIView?
    var l_noed : UILabel?
    var tv_noed : UILabel?
    var v_uptime : UIView?
    var l_uptime : UILabel?
    var tv_uptime : UILabel?
    var v_con : UIView?
    var v_con1 : UIView?
    var v_con2 : UIView?
    var l_con : UILabel?
    var tv_con : UITextView?
    var v_his : UIView?
    var v_oled : UIButton?
    var l_oled : UILabel?
    //滚动
    var sv_his : UIScrollView?
    var v_his1 : UIView?
    var v_onoed1 : UIView?
    var l_onoed1 : UILabel?
    var tv_onoed1 : UILabel?
    var v_otime1 : UIView?
    var l_otime1 : UILabel?
    var tv_otime1 : UILabel?
    var v_o1con : UIView?
    var v_o1con1 : UIView?
    var v_o1con2 : UIView?
    var l_o1con : UILabel?
    var tv_o1con : UITextView?
    var v_his2 : UIView?
    var v_onoed2 : UIView?
    var l_onoed2 : UILabel?
    var tv_onoed2 : UILabel?
    var v_otime2 : UIView?
    var l_otime2 : UILabel?
    var tv_otime2 : UILabel?
    var v_o2con : UIView?
    var v_o2con1 : UIView?
    var v_o2con2 : UIView?
    var l_o2con : UILabel?
    var tv_o2con : UITextView?
    var v_his3 : UIView?
    var v_onoed3 : UIView?
    var l_onoed3 : UILabel?
    var tv_onoed3 : UILabel?
    var v_otime3 : UIView?
    var l_otime3 : UILabel?
    var tv_otime3 : UILabel?
    var v_o3con : UIView?
    var v_o3con1 : UIView?
    var v_o3con2 : UIView?
    var l_o3con : UILabel?
    var tv_o3con : UITextView?
    var hight:CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        //是否可以滚动
        sv_his?.isScrollEnabled = true
        //垂直方向反弹
        sv_his?.alwaysBounceVertical = true
        //垂直方向是否显示滚动条
        sv_his?.showsVerticalScrollIndicator = false
        provers = root?.proedit ?? ""
        prouptime = root?.prouptime ?? ""
        hight = root?.hight ?? 0.0
        view.backgroundColor = UIColorRGB_Alpha(R: 238.0, G: 238.0, B: 238.0, alpha: 1.0);
        //最新版本视图
        v_new = UIView(frame: CGRect(x:0, y: 0, width:screenWidth, height: hight-50-40))
        v_new?.backgroundColor=UIColorRGB_Alpha(R: 238.0, G: 238.0, B: 238.0, alpha: 1.0);
        view.addSubview(v_new!)
        //版本标签视图
        v_need = UIButton(frame: CGRect(x:0, y: 0, width:screenWidth, height: 40))
        v_need?.backgroundColor=UIColorRGB_Alpha(R: 50.0, G: 184.0, B: 208.0, alpha: 0.8);
        v_need?.clipsToBounds=true
        v_need?.layer.shadowColor = UIColor.gray.cgColor
        v_need?.layer.shadowOpacity = 1.0
        v_need?.layer.shadowOffset = CGSize(width: 0, height: 0)
        v_need?.layer.shadowRadius = 4
        v_need?.layer.masksToBounds = false
        v_new?.addSubview(v_need!)
        v_need?.addTarget(self, action: #selector(NewClick), for: UIControl.Event.touchUpInside)
        //最新版本标签
        l_need = UILabel(frame: CGRect(x:10, y: 5, width:screenWidth-20, height: 30))
        l_need?.font = UIFont.systemFont(ofSize: 18)
        l_need?.textColor = UIColor.black
        l_need?.numberOfLines = 0
        l_need?.lineBreakMode = NSLineBreakMode.byWordWrapping
        v_need?.addSubview(l_need!)
        l_need?.text = "最新版本"
        l_need?.textAlignment=NSTextAlignment.left
        //版本号视图
        v_noed = UIView(frame: CGRect(x:0, y: (v_need?.frame.size.height)!+2, width:screenWidth, height: 50))
        v_noed?.backgroundColor=UIColor.white
        v_new?.addSubview(v_noed!)
        //版本号标签
        l_noed = UILabel(frame: CGRect(x:15, y: 10, width:100, height: 30))
        l_noed?.font = UIFont.systemFont(ofSize: 15)
        l_noed?.textColor = UIColor.black
        l_noed?.numberOfLines = 0
        l_noed?.lineBreakMode = NSLineBreakMode.byWordWrapping
        v_noed?.addSubview(l_noed!)
        l_noed?.text = "版本号："
        l_noed?.textAlignment=NSTextAlignment.left
        //版本号
        tv_noed = UILabel(frame: CGRect(x:screenWidth-100-10, y: 10, width:100, height: 30))
        tv_noed?.font = UIFont.systemFont(ofSize: 15)
        tv_noed?.textColor = UIColor.black
        tv_noed?.numberOfLines = 0
        tv_noed?.lineBreakMode = NSLineBreakMode.byWordWrapping
        v_noed?.addSubview(tv_noed!)
        tv_noed?.text = provers
        tv_noed?.textAlignment=NSTextAlignment.right
        //更新时间标签视图
        v_uptime = UIView(frame: CGRect(x:0, y: (v_need?.frame.size.height)!+(v_noed?.frame.size.height)!+4, width:screenWidth, height: 50))
        v_uptime?.backgroundColor=UIColor.white
        v_new?.addSubview(v_uptime!)
        //更新时间标签
        l_uptime = UILabel(frame: CGRect(x:15, y: 10, width:100, height: 30))
        l_uptime?.font = UIFont.systemFont(ofSize: 15)
        l_uptime?.textColor = UIColor.black
        l_uptime?.numberOfLines = 0
        l_uptime?.lineBreakMode = NSLineBreakMode.byWordWrapping
        v_uptime?.addSubview(l_uptime!)
        l_uptime?.text = "更新日期："
        l_uptime?.textAlignment=NSTextAlignment.left
        //更新时间
        tv_uptime = UILabel(frame: CGRect(x:screenWidth-100-10, y: 10, width:100, height: 30))
        tv_uptime?.font = UIFont.systemFont(ofSize: 15)
        tv_uptime?.textColor = UIColor.black
        tv_uptime?.numberOfLines = 0
        tv_uptime?.lineBreakMode = NSLineBreakMode.byWordWrapping
        v_uptime?.addSubview(tv_uptime!)
        tv_uptime?.text = prouptime
        tv_uptime?.textAlignment=NSTextAlignment.right
        //更新内容视图
        v_con = UIView(frame: CGRect(x:0, y: (v_need?.frame.size.height)!+(v_noed?.frame.size.height)!+(v_uptime?.frame.size.height)!+6, width:screenWidth, height: 150))
        v_con?.backgroundColor=UIColor.white
        v_new?.addSubview(v_con!)
        //更新内容第一子视图
        v_con1 = UIView(frame: CGRect(x:0, y: 0, width:screenWidth, height: 50))
        v_con1?.backgroundColor=UIColor.white
        v_con?.addSubview(v_con1!)
        //更新内容标签
        l_con = UILabel(frame: CGRect(x:15, y: 10, width:100, height: 30))
        l_con?.font = UIFont.systemFont(ofSize: 15)
        l_con?.textColor = UIColor.black
        l_con?.numberOfLines = 0
        l_con?.lineBreakMode = NSLineBreakMode.byWordWrapping
        v_con1?.addSubview(l_con!)
        l_con?.text = "更新内容："
        l_con?.textAlignment=NSTextAlignment.left
        //更新内容第二子视图
        v_con2 = UIView(frame: CGRect(x:0, y: 50, width:screenWidth, height: 100))
        v_con2?.backgroundColor=UIColor.white
        v_con?.addSubview(v_con2!)
        //更新内容
        tv_con = UITextView(frame: CGRect(x:15, y:0, width: screenWidth-30, height:100))
        tv_con?.font = UIFont.systemFont(ofSize: 14)
        tv_con?.textColor = UIColor.gray
        tv_con?.isEditable = false
        v_con2?.addSubview(tv_con!)
        tv_con?.text = "1、目标网站改动、更新爬虫代码。解决因目标网站改动导致的爬取实效问题出现。"
        //历史视图
<<<<<<< HEAD
        v_his = UIView(frame: CGRect(x:0, y: hight-50-44, width:screenWidth, height: hight))
        v_his?.backgroundColor=UIColorRGB_Alpha(R: 238.0, G: 238.0, B: 238.0, alpha: 1.0);
        v_his?.backgroundColor = UIColor.white
=======
        v_his = UIView(frame: CGRect(x:0, y: hight-50-40, width:screenWidth, height: hight-50-40))
        v_his?.backgroundColor=UIColorRGB_Alpha(R: 238.0, G: 238.0, B: 238.0, alpha: 1.0);
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
        view.addSubview(v_his!)
        // Do any additional setup after loading the view.
        //历史版本标签视图
        v_oled = UIButton(frame: CGRect(x:0, y: 0, width:screenWidth, height: 40))
        v_oled?.backgroundColor=UIColor.white
        v_oled?.layer.shadowColor = UIColor.gray.cgColor
        v_oled?.layer.shadowOpacity = 1.0
        v_oled?.layer.shadowOffset = CGSize(width: 0, height: 0)
        v_oled?.layer.shadowRadius = 4
        v_oled?.layer.masksToBounds = false
        v_his?.addSubview(v_oled!)
        v_oled?.addTarget(self, action: #selector(HisClick), for: UIControl.Event.touchUpInside)
        //历史版本标签
        l_oled = UILabel(frame: CGRect(x:10, y: 5, width:screenWidth-20, height: 30))
        l_oled?.font = UIFont.systemFont(ofSize: 18)
        l_oled?.textColor = UIColor.black
        l_oled?.numberOfLines = 0
        l_oled?.lineBreakMode = NSLineBreakMode.byWordWrapping
        v_oled?.addSubview(l_oled!)
        l_oled?.text = "历史版本"
        l_oled?.textAlignment=NSTextAlignment.left
        //滚动视图
        sv_his = UIScrollView(frame: CGRect(x:0, y: 40, width:screenWidth, height: hight-50-40-40))
<<<<<<< HEAD
        sv_his?.backgroundColor=UIColor.white
=======
        sv_his?.backgroundColor=UIColorRGB_Alpha(R: 238.0, G: 238.0, B: 238.0, alpha: 1.0);
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
        v_his?.addSubview(sv_his!)
        //历史版本1视图
        v_his1 = UIView(frame: CGRect(x:0, y:0, width:screenWidth, height: 180))
        v_his1?.backgroundColor=UIColor.white
        sv_his?.addSubview(v_his1!)
        //版本号视图
        v_onoed1 = UIView(frame: CGRect(x:0, y: 0, width:screenWidth, height: 40))
        v_onoed1?.backgroundColor=UIColor.white
        v_his1?.addSubview(v_onoed1!)
        //版本号标签
<<<<<<< HEAD
        l_onoed1 = UILabel(frame: CGRect(x:15, y: 5, width:300, height: 30))
=======
        l_onoed1 = UILabel(frame: CGRect(x:15, y: 5, width:100, height: 30))
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
        l_onoed1?.font = UIFont.systemFont(ofSize: 15)
        l_onoed1?.textColor = UIColor.black
        l_onoed1?.numberOfLines = 0
        l_onoed1?.lineBreakMode = NSLineBreakMode.byWordWrapping
        v_onoed1?.addSubview(l_onoed1!)
<<<<<<< HEAD
        l_onoed1?.text = "暂无历史版本信息"
        l_onoed1?.textAlignment=NSTextAlignment.left
=======
        l_onoed1?.text = "版本号："
        l_onoed1?.textAlignment=NSTextAlignment.left
        //版本号
        tv_onoed1 = UILabel(frame: CGRect(x:screenWidth-100-10, y: 5, width:100, height: 30))
        tv_onoed1?.font = UIFont.systemFont(ofSize: 15)
        tv_onoed1?.textColor = UIColor.black
        tv_onoed1?.numberOfLines = 0
        tv_onoed1?.lineBreakMode = NSLineBreakMode.byWordWrapping
        v_onoed1?.addSubview(tv_onoed1!)
        tv_onoed1?.text = "v0.9"
        tv_onoed1?.textAlignment=NSTextAlignment.right
        //更新时间标签视图
        v_otime1 = UIView(frame: CGRect(x:0, y: (v_onoed1?.frame.size.height)!, width:screenWidth, height: 40))
        v_otime1?.backgroundColor=UIColor.white
        v_his1?.addSubview(v_otime1!)
        //更新时间标签
        l_otime1 = UILabel(frame: CGRect(x:15, y: 5, width:100, height: 30))
        l_otime1?.font = UIFont.systemFont(ofSize: 15)
        l_otime1?.textColor = UIColor.black
        l_otime1?.numberOfLines = 0
        l_otime1?.lineBreakMode = NSLineBreakMode.byWordWrapping
        v_otime1?.addSubview(l_otime1!)
        l_otime1?.text = "更新日期："
        l_otime1?.textAlignment=NSTextAlignment.left
        //更新时间
        tv_otime1 = UILabel(frame: CGRect(x:screenWidth-100-10, y: 5, width:100, height: 30))
        tv_otime1?.font = UIFont.systemFont(ofSize: 15)
        tv_otime1?.textColor = UIColor.black
        tv_otime1?.numberOfLines = 0
        tv_otime1?.lineBreakMode = NSLineBreakMode.byWordWrapping
        v_otime1?.addSubview(tv_otime1!)
        tv_otime1?.text = "2018-12-25"
        tv_otime1?.textAlignment=NSTextAlignment.right
        //更新内容视图
        v_o1con = UIView(frame: CGRect(x:0, y: (v_onoed1?.frame.size.height)!+(v_otime1?.frame.size.height)!, width:screenWidth, height: 100))
        v_o1con?.backgroundColor=UIColor.white
        v_his1?.addSubview(v_o1con!)
        //更新内容第一子视图
        v_o1con1 = UIView(frame: CGRect(x:0, y: 0, width:screenWidth, height: 40))
        v_o1con1?.backgroundColor=UIColor.white
        v_o1con?.addSubview(v_o1con1!)
        //更新内容标签
        l_o1con = UILabel(frame: CGRect(x:15, y: 5, width:100, height: 30))
        l_o1con?.font = UIFont.systemFont(ofSize: 15)
        l_o1con?.textColor = UIColor.black
        l_o1con?.numberOfLines = 0
        l_o1con?.lineBreakMode = NSLineBreakMode.byWordWrapping
        v_o1con1?.addSubview(l_o1con!)
        l_o1con?.text = "更新内容："
        l_o1con?.textAlignment=NSTextAlignment.left
        //更新内容第二子视图
        v_o1con2 = UIView(frame: CGRect(x:0, y: 40, width:screenWidth, height: 60))
        v_o1con2?.backgroundColor=UIColor.white
        v_o1con?.addSubview(v_o1con2!)
        //更新内容
        tv_o1con = UITextView(frame: CGRect(x:15, y:0, width: screenWidth-30, height:60))
        tv_o1con?.font = UIFont.systemFont(ofSize: 14)
        tv_o1con?.textColor = UIColor.gray
        tv_o1con?.isEditable = false
        v_o1con2?.addSubview(tv_o1con!)
        tv_o1con?.text = "1、更新爬虫代码，保证爬虫过程的稳定性提高。"
        //历史版本2视图
        v_his2 = UIView(frame: CGRect(x:0, y:(v_his1?.frame.size.height)!+5, width:screenWidth, height: 180))
        v_his2?.backgroundColor=UIColor.white
        sv_his?.addSubview(v_his2!)
        //版本号视图
        v_onoed2 = UIView(frame: CGRect(x:0, y: 0, width:screenWidth, height: 40))
        v_onoed2?.backgroundColor=UIColor.white
        v_his2?.addSubview(v_onoed2!)
        //版本号标签
        l_onoed2 = UILabel(frame: CGRect(x:15, y: 5, width:100, height: 30))
        l_onoed2?.font = UIFont.systemFont(ofSize: 15)
        l_onoed2?.textColor = UIColor.black
        l_onoed2?.numberOfLines = 0
        l_onoed2?.lineBreakMode = NSLineBreakMode.byWordWrapping
        v_onoed2?.addSubview(l_onoed2!)
        l_onoed2?.text = "版本号："
        l_onoed2?.textAlignment=NSTextAlignment.left
        //版本号
        tv_onoed2 = UILabel(frame: CGRect(x:screenWidth-100-10, y: 5, width:100, height: 30))
        tv_onoed2?.font = UIFont.systemFont(ofSize: 15)
        tv_onoed2?.textColor = UIColor.black
        tv_onoed2?.numberOfLines = 0
        tv_onoed2?.lineBreakMode = NSLineBreakMode.byWordWrapping
        v_onoed2?.addSubview(tv_onoed2!)
        tv_onoed2?.text = "v1.0"
        tv_onoed2?.textAlignment=NSTextAlignment.right
        //更新时间标签视图
        v_otime2 = UIView(frame: CGRect(x:0, y: (v_onoed2?.frame.size.height)!, width:screenWidth, height: 40))
        v_otime2?.backgroundColor=UIColor.white
        v_his2?.addSubview(v_otime2!)
        //更新时间标签
        l_otime2 = UILabel(frame: CGRect(x:15, y: 5, width:100, height: 30))
        l_otime2?.font = UIFont.systemFont(ofSize: 15)
        l_otime2?.textColor = UIColor.black
        l_otime2?.numberOfLines = 0
        l_otime2?.lineBreakMode = NSLineBreakMode.byWordWrapping
        v_otime2?.addSubview(l_otime2!)
        l_otime2?.text = "更新日期："
        l_otime2?.textAlignment=NSTextAlignment.left
        //更新时间
        tv_otime2 = UILabel(frame: CGRect(x:screenWidth-100-10, y: 5, width:100, height: 30))
        tv_otime2?.font = UIFont.systemFont(ofSize: 15)
        tv_otime2?.textColor = UIColor.black
        tv_otime2?.numberOfLines = 0
        tv_otime2?.lineBreakMode = NSLineBreakMode.byWordWrapping
        v_otime2?.addSubview(tv_otime2!)
        tv_otime2?.text = "2018-11-25"
        tv_otime2?.textAlignment=NSTextAlignment.right
        //更新内容视图
        v_o2con = UIView(frame: CGRect(x:0, y: (v_onoed2?.frame.size.height)!+(v_otime2?.frame.size.height)!, width:screenWidth, height: 100))
        v_o2con?.backgroundColor=UIColor.white
        v_his2?.addSubview(v_o2con!)
        //更新内容第一子视图
        v_o2con1 = UIView(frame: CGRect(x:0, y: 0, width:screenWidth, height: 40))
        v_o2con1?.backgroundColor=UIColor.white
        v_o2con?.addSubview(v_o2con1!)
        //更新内容标签
        l_o2con = UILabel(frame: CGRect(x:15, y: 5, width:100, height: 30))
        l_o2con?.font = UIFont.systemFont(ofSize: 15)
        l_o2con?.textColor = UIColor.black
        l_o2con?.numberOfLines = 0
        l_o2con?.lineBreakMode = NSLineBreakMode.byWordWrapping
        v_o2con1?.addSubview(l_o2con!)
        l_o2con?.text = "更新内容："
        l_o2con?.textAlignment=NSTextAlignment.left
        //更新内容第二子视图
        v_o2con2 = UIView(frame: CGRect(x:0, y: 40, width:screenWidth, height: 60))
        v_o2con2?.backgroundColor=UIColor.white
        v_o2con?.addSubview(v_o2con2!)
        //更新内容
        tv_o2con = UITextView(frame: CGRect(x:15, y:0, width: screenWidth-30, height:60))
        tv_o2con?.font = UIFont.systemFont(ofSize: 14)
        tv_o2con?.textColor = UIColor.gray
        tv_o2con?.isEditable = false
        v_o2con2?.addSubview(tv_o2con!)
        tv_o2con?.text = "1、更新应用描述的应用简介。"
        //历史版本3视图
        v_his3 = UIView(frame: CGRect(x:0, y:(v_his1?.frame.size.height)!+(v_his2?.frame.size.height)!+10, width:screenWidth, height: 180))
        v_his3?.backgroundColor=UIColor.white
        sv_his?.addSubview(v_his3!)
        //版本号视图
        v_onoed3 = UIView(frame: CGRect(x:0, y: 0, width:screenWidth, height: 40))
        v_onoed3?.backgroundColor=UIColor.white
        v_his3?.addSubview(v_onoed3!)
        //版本号标签
        l_onoed3 = UILabel(frame: CGRect(x:15, y: 5, width:100, height: 30))
        l_onoed3?.font = UIFont.systemFont(ofSize: 15)
        l_onoed3?.textColor = UIColor.black
        l_onoed3?.numberOfLines = 0
        l_onoed3?.lineBreakMode = NSLineBreakMode.byWordWrapping
        v_onoed3?.addSubview(l_onoed3!)
        l_onoed3?.text = "版本号："
        l_onoed3?.textAlignment=NSTextAlignment.left
        //版本号
        tv_onoed3 = UILabel(frame: CGRect(x:screenWidth-100-10, y: 5, width:100, height: 30))
        tv_onoed3?.font = UIFont.systemFont(ofSize: 15)
        tv_onoed3?.textColor = UIColor.black
        tv_onoed3?.numberOfLines = 0
        tv_onoed3?.lineBreakMode = NSLineBreakMode.byWordWrapping
        v_onoed3?.addSubview(tv_onoed3!)
        tv_onoed3?.text = "v0.8"
        tv_onoed3?.textAlignment=NSTextAlignment.right
        //更新时间标签视图
        v_otime3 = UIView(frame: CGRect(x:0, y: (v_onoed3?.frame.size.height)!, width:screenWidth, height: 40))
        v_otime3?.backgroundColor=UIColor.white
        v_his3?.addSubview(v_otime3!)
        //更新时间标签
        l_otime3 = UILabel(frame: CGRect(x:15, y: 5, width:100, height: 30))
        l_otime3?.font = UIFont.systemFont(ofSize: 15)
        l_otime3?.textColor = UIColor.black
        l_otime3?.numberOfLines = 0
        l_otime3?.lineBreakMode = NSLineBreakMode.byWordWrapping
        v_otime3?.addSubview(l_otime3!)
        l_otime3?.text = "更新日期："
        l_otime3?.textAlignment=NSTextAlignment.left
        //更新时间
        tv_otime3 = UILabel(frame: CGRect(x:screenWidth-100-10, y: 5, width:100, height: 30))
        tv_otime3?.font = UIFont.systemFont(ofSize: 15)
        tv_otime3?.textColor = UIColor.black
        tv_otime3?.numberOfLines = 0
        tv_otime3?.lineBreakMode = NSLineBreakMode.byWordWrapping
        v_otime3?.addSubview(tv_otime3!)
        tv_otime3?.text = "2018-11-35"
        tv_otime3?.textAlignment=NSTextAlignment.right
        //更新内容视图
        v_o3con = UIView(frame: CGRect(x:0, y: (v_onoed3?.frame.size.height)!+(v_otime3?.frame.size.height)!, width:screenWidth, height: 100))
        v_o3con?.backgroundColor=UIColor.white
        v_his3?.addSubview(v_o3con!)
        //更新内容第一子视图
        v_o3con1 = UIView(frame: CGRect(x:0, y: 0, width:screenWidth, height: 40))
        v_o3con1?.backgroundColor=UIColor.white
        v_o3con?.addSubview(v_o3con1!)
        //更新内容标签
        l_o3con = UILabel(frame: CGRect(x:15, y: 5, width:100, height: 30))
        l_o3con?.font = UIFont.systemFont(ofSize: 15)
        l_o3con?.textColor = UIColor.black
        l_o3con?.numberOfLines = 0
        l_o3con?.lineBreakMode = NSLineBreakMode.byWordWrapping
        v_o3con1?.addSubview(l_o3con!)
        l_o3con?.text = "更新内容："
        l_o3con?.textAlignment=NSTextAlignment.left
        //更新内容第二子视图
        v_o3con2 = UIView(frame: CGRect(x:0, y: 40, width:screenWidth, height: 60))
        v_o3con2?.backgroundColor=UIColor.white
        v_o3con?.addSubview(v_o3con2!)
        //更新内容
        tv_o3con = UITextView(frame: CGRect(x:15, y:0, width: screenWidth-30, height:60))
        tv_o3con?.font = UIFont.systemFont(ofSize: 14)
        tv_o3con?.textColor = UIColor.gray
        tv_o3con?.isEditable = false
        v_o3con2?.addSubview(tv_o3con!)
        tv_o3con?.text = "1、精确度提高，爬取流程简化。"
        sv_his?.contentSize = CGSize(width: screenWidth,
                                     height: (v_his1?.frame.size.height)!+(v_his2?.frame.size.height)!+(v_his3?.frame.size.height)!+15);

>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
    }
    @objc func HisClick(v_oled: UIView) {
        v_oled.backgroundColor=UIColorRGB_Alpha(R: 50.0, G: 184.0, B: 208.0, alpha: 0.8);
        v_need!.backgroundColor=UIColor.white
<<<<<<< HEAD
        UIView.animate(withDuration: 0.3) {
            self.v_his!.frame.origin.y = 40.0  // 获取坐标Y
        }
=======
        v_his!.frame.origin.y = 40.0  // 获取坐标Y
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
    }
    @objc func NewClick(v_need: UIView) {
        v_oled!.backgroundColor=UIColor.white
        v_need.backgroundColor=UIColorRGB_Alpha(R: 50.0, G: 184.0, B: 208.0, alpha: 0.8);
<<<<<<< HEAD
        UIView.animate(withDuration: 0.3) {
            self.v_his!.frame.origin.y = self.hight-50-40  // 获取坐标Y
        }
=======
        v_his!.frame.origin.y = hight-50-40  // 获取坐标Y
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func UIColorRGB_Alpha(R:CGFloat, G:CGFloat, B:CGFloat, alpha:CGFloat) -> UIColor
    {
        let color = UIColor.init(red: (R / 255.0), green: (G / 255.0), blue: (B / 255.0), alpha: alpha);
        return color;
    }
}
