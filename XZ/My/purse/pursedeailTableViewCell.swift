//
//  pursedeailTableViewCell.swift
//  XZ
//
//  Created by wjz on 2019/2/22.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit

class pursedeailTableViewCell: UITableViewCell {
    
    var tableView:UITableView?
<<<<<<< HEAD:XZ/My/purse/pursedeailTableViewCell.swift
    var tv_pursed : UIView?
    var tv_times : UILabel?
    var tv_rids : UILabel?
    var tv_mons : UILabel?
    var tv_rcr : UILabel?
=======
    var tv_pursed: UIView?
    var tv_times: UILabel?
    var tv_rids: UILabel?
    var tv_mons: UILabel?
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413:XZ/My/purse/pursedeailTableViewCell.swift
    var tv_state: UILabel?
    var tv_count: UILabel?
    var bt_oper : UIButton?
    var bt_dele : UIButton?
<<<<<<< HEAD:XZ/My/purse/pursedeailTableViewCell.swift
    var tv_timess : UILabel?
    var tv_monss : UILabel?
    var tv_states : UILabel?
    var tv_counts : UILabel?
    var v_fenge : UIView?
=======
    var tv_timess: UILabel?
    var tv_monss: UILabel?
    var tv_states: UILabel?
    var tv_counts: UILabel?
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413:XZ/My/purse/pursedeailTableViewCell.swift
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    var root : PursedeailTableViewController?
    var pid:Int = 5
    var pids:Int = 5
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
//    @objc func Operactions(subButton: UIButton) {
//        print("支付状态\(root?.appPayStatus)")
//        let appPayStatus:String = (root?.appPayStatus[subButton.tag])!
//        var crawlername : String = (root?.crawlerName[subButton.tag])!
//        var iskey : Int = (root?.iskeywords[subButton.tag])!
//        root?.root?.iskey = iskey
//        print("支付状态\(appPayStatus)")
//        print("产品编号\(pids)")
//        print("是否需要keyword\(iskey)")
//        if(appPayStatus == "已支付"){
//            root?.root?.performSegue(withIdentifier: "operDetailView", sender: crawlername)
//        }
//        else{
//            let alertController = UIAlertController(title: "提示", message: "该应用未支付，是否前往支付订单？",preferredStyle: .alert)
//            let cancelAction1 = UIAlertAction(title: "确定", style: .destructive, handler: {
//                action in
//                self.payok()
//            })
//            let cancelAction2 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
//            alertController.addAction(cancelAction1)
//            alertController.addAction(cancelAction2)
//            root?.present(alertController, animated: true, completion: nil)
//        }
//    }
//    func payok(){
//        root?.root?.performSegue(withIdentifier: "MyOrder", sender: pids)
//    }
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
<<<<<<< HEAD:XZ/My/purse/pursedeailTableViewCell.swift
        tv_pursed = UIView(frame: CGRect(x:0, y: 0, width:screenWidth, height: 70))
        tv_pursed?.backgroundColor=UIColor.white
        tv_pursed?.clipsToBounds=true
        self.addSubview(tv_pursed!)
        // 充值ID
        tv_rids = UILabel(frame: CGRect(x:10, y: 10, width:50, height: 50))
        tv_rids?.font = UIFont.systemFont(ofSize: 16)
        tv_rids?.textColor = UIColor.black
        tv_rids?.layer.cornerRadius = 25
        tv_rids?.layer.borderWidth = 0.5
        tv_rids?.layer.masksToBounds = true
        tv_rids?.textAlignment=NSTextAlignment.center
        tv_pursed?.addSubview(tv_rids!)
        //账单描述
        tv_rcr = UILabel(frame: CGRect(x:70, y:10, width: 200, height:30))
        tv_rcr?.font = UIFont.systemFont(ofSize: 16)
        tv_rcr?.textColor = UIColor.black
        tv_rcr?.textAlignment = .left
        tv_pursed?.addSubview(tv_rcr!)
        // 创建时间
        tv_times = UILabel(frame: CGRect(x:70, y:40, width: 200, height:20))
        tv_times?.font = UIFont.systemFont(ofSize: 13)
        tv_times?.textColor = UIColor.gray
        tv_times?.textAlignment = .left
        tv_pursed?.addSubview(tv_times!)
        // 价格
        tv_mons = UILabel(frame: CGRect(x:screenWidth-100, y:10, width:80, height: 30))
        tv_mons?.font = UIFont.systemFont(ofSize: 16)
        tv_mons?.textColor = UIColor.black
        tv_mons?.textAlignment = .right
        tv_pursed?.addSubview(tv_mons!)
        // 分隔线
        v_fenge = UILabel(frame: CGRect(x:70, y:70, width:screenWidth-70, height: 0.7))
        v_fenge?.backgroundColor = UIColor.gray
        self.addSubview(v_fenge!)
=======
        tv_pursed = UIView(frame: CGRect(x:5, y: 5, width:screenWidth-10, height: 50))
        tv_pursed?.backgroundColor=UIColor.white
        tv_pursed?.clipsToBounds=true
        tv_pursed?.layer.cornerRadius = 5
        tv_pursed?.layer.shadowColor = UIColor.gray.cgColor
        tv_pursed?.layer.shadowOpacity = 1.0
        tv_pursed?.layer.shadowOffset = CGSize(width: 0, height: 0)
        tv_pursed?.layer.shadowRadius = 4
        tv_pursed?.layer.masksToBounds = false
        self.addSubview(tv_pursed!)
        // 大标题
        tv_rids = UILabel(frame: CGRect(x:20, y: 10, width:50, height: 30))
        tv_rids?.font = UIFont.systemFont(ofSize: 20)
        tv_rids?.textColor = UIColor.black
        tv_pursed?.addSubview(tv_rids!)
        // 创建时间
        tv_times = UILabel(frame: CGRect(x:(screenWidth-210)/2, y:10, width: 200, height:30))
        tv_times?.font = UIFont.systemFont(ofSize: 20)
        tv_times?.textColor = UIColor.black
        tv_times?.textAlignment = .center
        tv_pursed?.addSubview(tv_times!)
        // 结束时间
        tv_mons = UILabel(frame: CGRect(x:screenWidth-100, y:10, width:80, height: 30))
        tv_mons?.font = UIFont.systemFont(ofSize: 20)
        tv_mons?.textColor = UIColor.black
        tv_mons?.textAlignment = .right
        tv_pursed?.addSubview(tv_mons!)
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413:XZ/My/purse/pursedeailTableViewCell.swift
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
