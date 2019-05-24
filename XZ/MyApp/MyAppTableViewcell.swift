//
//  ShopTableViewCell.swift
//  XZ
//
//  Created by wjz on 2019/1/9.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit
import Alamofire
class MyAppTableViewcell: UITableViewCell {
    
    var tableView:UITableView?
    var v_oper: UIButton?
    var tv_stime: UILabel?
    var tv_title: UILabel?
    var tv_etime: UILabel?
    var tv_state: UILabel?
    var tv_count: UILabel?
    var bt_oper : UIButton?
    var bt_dele : UIButton?
    var tv_stimes: UILabel?
    var tv_etimes: UILabel?
    var tv_states: UIButton?
    var tv_counts: UILabel?
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    var root : MyAppTableViewController?
    var tzroot : ShoppagViewController?
    var pid:Int = 5
    var pids:Int = 5
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    @objc func Operactions(subButton: UIButton) {
        print("支付状态\(root?.appPayStatus)")
        let appPayStatus:String = (root?.appPayStatus[subButton.tag])!
        var crawlernames : String = (root?.crawlerName[subButton.tag])!
        var iskey : Int = (root?.iskeywords[subButton.tag])!
        var pidss : Int = (root?.pidss[subButton.tag])!
        var endtimes : String = (root?.endtime[subButton.tag])!
        var Ntitle:String = (root?.titles[subButton.tag])!
        root?.root?.Ntitle = Ntitle
        root?.root?.iskey = iskey
        root?.root?.crawlername = crawlernames
        print("支付状态\(appPayStatus)")
        print("产品编号\(pids)")
        print("是否需要keyword\(iskey)")
        if(appPayStatus == "已支付"){
            root?.root?.operDetailView()
        }
        else{
            let alertController = UIAlertController(title: "提示", message: "该应用使用天数不够，是否前往购买？",preferredStyle: .alert)
            let cancelAction1 = UIAlertAction(title: "确定", style: .destructive, handler: {
                action in
                self.payok(thepid: pidss,theendtime:endtimes)
            })
            let cancelAction2 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alertController.addAction(cancelAction1)
            alertController.addAction(cancelAction2)
            root?.present(alertController, animated: true, completion: nil)
        }
    }
    func payok(thepid:Int,theendtime:String){
        root?.root?.pids = thepid
        root?.root?.etimes = theendtime
        root?.root?.MyOrder()
    }
    func Deleactions(appids:Int,appnames:String) {
        print("确定删除应用ID为\(appids)的应用\(appnames)吗？")
        let alertController = UIAlertController(title: "提示", message: "是否删除应用\"\(appnames)\"？",preferredStyle: .alert)
        let cancelAction1 = UIAlertAction(title: "确定", style: .destructive, handler: {
            action in
            self.deleteok(appid: appids)
        })
        let cancelAction2 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction1)
        alertController.addAction(cancelAction2)
        root?.present(alertController, animated: true, completion: nil)
    }
    func deleteok(appid:Int){
        
        var userid:Int = UserDefaults.standard.object(forKey: "userId") as! Int
        let url = "https://www.xingzhu.club/XzTest/apps/deleteApp"
        let paras = ["appId":appid]
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
                let alertController = UIAlertController(title: "\(message)",
                    message: nil, preferredStyle: .alert)
                //显示提示框
                self.root?.present(alertController, animated: true, completion: nil)
                //两秒钟后自动消失
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.root?.presentedViewController?.dismiss(animated: false, completion: nil)
                }
                self.root?.Refresh()
            }
        }
        
    }
    @objc func BuyClick(subButton: UIButton) {
        let optionMenuController = UIAlertController(title: nil, message: "选择支付方式", preferredStyle: .actionSheet)
        
        let AlipayAction = UIAlertAction(title: "支付宝", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.pid = subButton.tag
            let alertController = UIAlertController(title: "使用支付宝支付购买商品\(self.pid)",
                message: nil, preferredStyle: .alert)
            //显示提示框
            self.root?.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                self.root?.presentedViewController?.dismiss(animated: false, completion: nil)
            }
        })
        
        let WechatAction = UIAlertAction(title: "微信", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.pid = subButton.tag
            let alertController = UIAlertController(title: "使用微信支付购买商品\(self.pid)",
                message: nil, preferredStyle: .alert)
            //显示提示框
            self.root?.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                self.root?.presentedViewController?.dismiss(animated: false, completion: nil)
            }
        })
        
        let cancelAction = UIAlertAction(title: "取消", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        optionMenuController.addAction(AlipayAction)
        optionMenuController.addAction(WechatAction)
        optionMenuController.addAction(cancelAction)
        
        root?.present(optionMenuController, animated: true, completion: nil)
    }
    func setUpUI(){
        //视图
        v_oper = UIButton(frame: CGRect(x:5, y: 5, width:screenWidth-10, height: 155))
        v_oper?.backgroundColor=UIColor.white
        v_oper?.clipsToBounds=true
        v_oper?.layer.cornerRadius = 8
        v_oper?.layer.shadowColor = UIColor.gray.cgColor
        v_oper?.layer.shadowOpacity = 1.0
        v_oper?.layer.shadowOffset = CGSize(width: 0, height: 0)
        v_oper?.layer.shadowRadius = 4
        v_oper?.layer.masksToBounds = false
        self.addSubview(v_oper!)
        v_oper?.isUserInteractionEnabled = true
        let longGress = UILongPressGestureRecognizer()
        longGress.addTarget(self, action: #selector(longGressGestrue(longGress:)))
        v_oper?.addGestureRecognizer(longGress)
        
        // 大标题
        tv_title = UILabel(frame: CGRect(x:10, y: 10, width:screenWidth-10, height: 20))
        tv_stime?.font = UIFont.systemFont(ofSize: 16)
        tv_stime?.textColor = UIColor.black
        v_oper?.addSubview(tv_title!)
        //创建时间说明
        tv_stimes = UILabel(frame: CGRect(x:15, y:52, width: 80, height:20))
        tv_stimes?.font = UIFont.systemFont(ofSize: 14)
        tv_stimes?.textColor = UIColor.gray
        tv_stimes?.text = "开始时间："
        v_oper?.addSubview(tv_stimes!)
        // 创建时间
        tv_stime = UILabel(frame: CGRect(x:90, y:52, width: 200, height:20))
        tv_stime?.font = UIFont.systemFont(ofSize: 14)
        tv_stime?.textColor = UIColor.gray
        v_oper?.addSubview(tv_stime!)
        // 结束时间说明
        tv_etimes = UILabel(frame: CGRect(x:15, y:80, width:80, height: 20))
        tv_etimes?.font = UIFont.systemFont(ofSize: 14)
        tv_etimes?.textColor = UIColor.gray
        tv_etimes?.text = "支付状态："
        v_oper?.addSubview(tv_etimes!)
        // 结束时间
        tv_etime = UILabel(frame: CGRect(x:90, y:80, width:200, height: 20))
        tv_etime?.font = UIFont.systemFont(ofSize: 14)
        tv_etime?.textColor = UIColor.gray
        v_oper?.addSubview(tv_etime!)
        // 状态
        tv_states = UIButton(frame: CGRect(x:screenWidth-80, y:30, width:60, height: 60))
        tv_states?.setTitleColor(UIColor.black, for: .normal)
        tv_states?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        tv_states?.setTitle("状态", for: .normal)
        tv_states?.layer.cornerRadius = 30.0
        tv_states?.layer.borderWidth = 0.5
        tv_states?.layer.masksToBounds = true
        v_oper?.addSubview(tv_states!)
        tv_states?.addTarget(self, action: #selector(xufeiAction), for: UIControl.Event.touchUpInside)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        tv_states?.isUserInteractionEnabled = true
//        tv_state = UILabel(frame: CGRect(x:50, y:85, width:100, height: 20))
//        tv_state?.font = UIFont.systemFont(ofSize: 14)
//        tv_state?.textColor = UIColor.black
//        v_oper?.addSubview(tv_state!)
//        // 统计
//        tv_counts = UILabel(frame: CGRect(x:10, y:110, width:60, height: 20))
//        tv_counts?.font = UIFont.systemFont(ofSize: 14)
//        tv_counts?.textColor = UIColor.black
//        tv_counts?.text = "统计量："
//        v_oper?.addSubview(tv_counts!)
//
//        tv_count = UILabel(frame: CGRect(x:65, y:110, width:100, height: 20))
//        tv_count?.font = UIFont.systemFont(ofSize: 14)
//        tv_count?.textColor = UIColor.black
//        v_oper?.addSubview(tv_count!)
        // 操作按钮
        bt_oper = UIButton(frame: CGRect(x:0, y:113, width:screenWidth-10, height: 42))
        bt_oper?.setTitle("操作", for: UIControl.State.normal)
        bt_oper?.setTitleColor(UIColor.black, for: UIControl.State.normal)
        bt_oper?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        bt_oper?.backgroundColor = UIColor.white
        bt_oper?.layer.cornerRadius = 8.0
        bt_oper?.layer.borderWidth = 0.1
        bt_oper?.layer.maskedCorners = [CACornerMask.layerMinXMaxYCorner , CACornerMask.layerMaxXMaxYCorner]
        bt_oper?.layer.masksToBounds = true
        bt_oper?.addTarget(self, action: #selector(Operactions), for: UIControl.Event.touchUpInside)
        v_oper?.addSubview(bt_oper!)
        
//        // 删除按钮
//        bt_dele = UIButton(frame: CGRect(x:screenWidth-70-15, y:((145)/2)+10, width:70, height: 30))
//        bt_dele?.setTitle("删除", for: UIControl.State.normal)
//        bt_dele?.setTitleColor(UIColor.white, for: UIControl.State.normal)
//        bt_dele?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        bt_dele?.backgroundColor = UIColor.red
//        bt_dele?.addTarget(self, action: #selector(Deleactions), for: UIControl.Event.touchUpInside)
//        self.addSubview(bt_dele!)
        
    }
    
    // 给cell赋值，项目中一般使用model，我这里直接写死了
    //    func setValueForCell(){
    //
    //        rows = rows+1
    //        iconImage?.image = UIImage(named:"weibo")
    //        titleLabel?.text = "大大大大的标题"
    //        subTitleLabel?.text = "副副副副的标题"
    //    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    @objc private func longGressGestrue(longGress:UILongPressGestureRecognizer){
        
          if longGress.state == UIGestureRecognizer.State.began {
            
            var appid : Int = (root?.appId[(v_oper?.tag)!])!
            var appname : String = (root?.titles[(v_oper?.tag)!])!
           Deleactions(appids: appid, appnames: appname)
          }
//            else if longGress.state == UIGestureRecognizer.State.possible{
//
//                                    print("possible")
//
//                            }else if longGress.state == UIGestureRecognizer.State.changed{
//
//                                    print("changed")
//
//                            }else if longGress.state == UIGestureRecognizer.State.possible{
//
//                                    print("possible")
//
//                            }else if longGress.state == UIGestureRecognizer.State.ended{
//
//                                    print("ended")
//
//                            }else{
//
//                                    print("cancelled")
//
//                            }
        
   }
    @objc func xufeiAction(subButton: UIButton){
        print("支付状态\(root?.appPayStatus)")
        let xufeiPayStatus:String = (root?.xufeiPayStatus[subButton.tag])!
        var crawlernames : String = (root?.crawlerName[subButton.tag])!
        var iskey : Int = (root?.iskeywords[subButton.tag])!
        var pidss : Int = (root?.pidss[subButton.tag])!
        var Ntitle:String = (root?.titles[subButton.tag])!
        var endtimes : String = (root?.endtime[subButton.tag])!
        root?.root?.Ntitle = Ntitle
        root?.root?.iskey = iskey
        root?.root?.crawlername = crawlernames
        print("支付状态\(xufeiPayStatus)")
        print("产品编号\(pids)")
        print("是否需要keyword\(iskey)")
        if(xufeiPayStatus == "续费"){
            let alertController = UIAlertController(title: "提示", message: "你已支付该应用，是否续费？",preferredStyle: .alert)
            let cancelAction1 = UIAlertAction(title: "确定", style: .destructive, handler: {
                action in
                self.payok(thepid: pidss, theendtime: endtimes)
            })
            let cancelAction2 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alertController.addAction(cancelAction1)
            alertController.addAction(cancelAction2)
            root?.present(alertController, animated: true, completion: nil)
        }
        if(xufeiPayStatus == "购买"){
            let alertController = UIAlertController(title: "提示", message: "该应用使用天数不够，是否前往购买？",preferredStyle: .alert)
            let cancelAction1 = UIAlertAction(title: "确定", style: .destructive, handler: {
                action in
                self.payok(thepid: pidss, theendtime: endtimes)
            })
            let cancelAction2 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alertController.addAction(cancelAction1)
            alertController.addAction(cancelAction2)
            root?.present(alertController, animated: true, completion: nil)
        }
    }
}
