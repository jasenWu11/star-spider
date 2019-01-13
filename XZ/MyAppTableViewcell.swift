//
//  ShopTableViewCell.swift
//  XZ
//
//  Created by wjz on 2019/1/9.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit

class MyAppTableViewcell: UITableViewCell {
    
    var tableView:UITableView?
    var tv_type: UILabel?
    var tv_title: UILabel?
    var tv_ctime: UILabel?
    var tv_state: UILabel?
    var tv_count: UILabel?
    var bt_oper : UIButton?
    var bt_dele : UIButton?
    var tv_types: UILabel?
    var tv_ctimes: UILabel?
    var tv_states: UILabel?
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
        var pids:Int = 0
        pids = subButton.tag
        root?.root?.performSegue(withIdentifier: "operDetailView", sender: pids)
    }
    @objc func Deleactions(subButton: UIButton) {
        print(subButton.tag)
        let alertController = UIAlertController(title: "提示", message: "是否删除该应用？",preferredStyle: .alert)
        let cancelAction1 = UIAlertAction(title: "确定", style: .default, handler: {
            action in
            self.deleteok()
        })
        let cancelAction2 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction1)
        alertController.addAction(cancelAction2)
        root?.present(alertController, animated: true, completion: nil)
    }
    func deleteok(){
        let alertController = UIAlertController(title: "删除成功!",
                                                message: nil, preferredStyle: .alert)
        //显示提示框
        root?.present(alertController, animated: true, completion: nil)
        //两秒钟后自动消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.root?.presentedViewController?.dismiss(animated: false, completion: nil)
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
        // 大标题
        tv_title = UILabel(frame: CGRect(x:10, y: 10, width:screenWidth-10, height: 20))
        tv_type?.font = UIFont.systemFont(ofSize: 16)
        tv_type?.textColor = UIColor.black
        self.addSubview(tv_title!)
        //类型说明
        tv_types = UILabel(frame: CGRect(x:10, y:35, width: 80, height:20))
        tv_types?.font = UIFont.systemFont(ofSize: 14)
        tv_types?.textColor = UIColor.black
        tv_types?.text = "应用类型："
        self.addSubview(tv_types!)
        // 类型
        tv_type = UILabel(frame: CGRect(x:85, y:35, width: 100, height:20))
        tv_type?.font = UIFont.systemFont(ofSize: 14)
        tv_type?.textColor = UIColor.black
        self.addSubview(tv_type!)
        // 创建时间
        tv_ctimes = UILabel(frame: CGRect(x:10, y:60, width:80, height: 20))
        tv_ctimes?.font = UIFont.systemFont(ofSize: 14)
        tv_ctimes?.textColor = UIColor.black
        tv_ctimes?.text = "操作时间："
        self.addSubview(tv_ctimes!)
        
        tv_ctime = UILabel(frame: CGRect(x:85, y:60, width:100, height: 20))
        tv_ctime?.font = UIFont.systemFont(ofSize: 14)
        tv_ctime?.textColor = UIColor.black
        self.addSubview(tv_ctime!)
        // 状态
        tv_states = UILabel(frame: CGRect(x:10, y:85, width:45, height: 20))
        tv_states?.font = UIFont.systemFont(ofSize: 14)
        tv_states?.textColor = UIColor.black
        tv_states?.text = "状态："
        self.addSubview(tv_states!)
        
        tv_state = UILabel(frame: CGRect(x:50, y:85, width:100, height: 20))
        tv_state?.font = UIFont.systemFont(ofSize: 14)
        tv_state?.textColor = UIColor.black
        self.addSubview(tv_state!)
        // 统计
        tv_counts = UILabel(frame: CGRect(x:10, y:110, width:60, height: 20))
        tv_counts?.font = UIFont.systemFont(ofSize: 14)
        tv_counts?.textColor = UIColor.black
        tv_counts?.text = "统计量："
        self.addSubview(tv_counts!)
        
        tv_count = UILabel(frame: CGRect(x:65, y:110, width:100, height: 20))
        tv_count?.font = UIFont.systemFont(ofSize: 14)
        tv_count?.textColor = UIColor.black
        self.addSubview(tv_count!)
        // 操作按钮
        bt_oper = UIButton(frame: CGRect(x:screenWidth-70-15, y:((145)/2-30)-10, width:70, height: 30))
        bt_oper?.setTitle("操作", for: UIControl.State.normal)
        bt_oper?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        bt_oper?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        bt_oper?.backgroundColor = UIColor.blue
        bt_oper?.addTarget(self, action: #selector(Operactions), for: UIControl.Event.touchUpInside)
        self.addSubview(bt_oper!)
        // 删除按钮
        bt_dele = UIButton(frame: CGRect(x:screenWidth-70-15, y:((145)/2)+10, width:70, height: 30))
        bt_dele?.setTitle("删除", for: UIControl.State.normal)
        bt_dele?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        bt_dele?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        bt_dele?.backgroundColor = UIColor.red
        bt_dele?.addTarget(self, action: #selector(Deleactions), for: UIControl.Event.touchUpInside)
        self.addSubview(bt_dele!)
        
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
    
}
