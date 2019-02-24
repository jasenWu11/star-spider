//
//  ShopTableViewCell.swift
//  XZ
//
//  Created by wjz on 2019/1/9.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit

class ShopTableViewCell: UITableViewCell {

    var iconImage     : UIImageView?
    var titleLabel    : UILabel?
    var subTitleLabel : UILabel?
    var pirceLabel : UILabel?
    var subButton : UIButton?
    let screenWidth =  UIScreen.main.bounds.size.width
    var rows:Int = 0
    var shopcellView : UIButton?
    var root : ShopTableViewController?
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
    @objc func composeBtnClick(shopcellView: UILabel) {
        print(shopcellView.tag)
        pids = shopcellView.tag
        root?.root?.performSegue(withIdentifier: "deatil", sender: pids)
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
        shopcellView = UIButton(frame: CGRect(x:5, y: 5, width:screenWidth-10, height: 130))
        shopcellView?.backgroundColor=UIColor.white
        shopcellView?.clipsToBounds=true
        shopcellView?.layer.cornerRadius = 10
        shopcellView?.layer.shadowColor = UIColor.gray.cgColor
        shopcellView?.layer.shadowOpacity = 1.0
        shopcellView?.layer.shadowOffset = CGSize(width: 0, height: 0)
        shopcellView?.layer.shadowRadius = 4
        shopcellView?.layer.masksToBounds = false
        shopcellView?.addTarget(self, action: #selector(composeBtnClick), for: UIControl.Event.touchUpInside)
        self.addSubview(shopcellView!)
        // 图片
        iconImage = UIImageView(frame: CGRect(x:0, y: 0, width:130, height: 130))
        iconImage?.layer.cornerRadius = 10.0
        iconImage?.layer.maskedCorners = [CACornerMask.layerMinXMinYCorner , CACornerMask.layerMinXMaxYCorner]
        iconImage?.layer.masksToBounds = true
        shopcellView?.addSubview(iconImage!)
        
        // 大标题
        titleLabel = UILabel(frame: CGRect(x:(iconImage?.frame.size.width)!+25, y:10, width: self.frame.size.width-(iconImage?.frame.size.width)!+20, height:30))
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        titleLabel?.textColor = UIColor.black
        titleLabel?.numberOfLines = 0
        titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        shopcellView?.addSubview(titleLabel!)
        
        // 简介
        subTitleLabel = UILabel(frame: CGRect(x:(iconImage?.frame.size.width)!+25, y:(titleLabel?.frame.size.height)!, width:self.frame.size.width-(iconImage?.frame.size.width)!+20, height: 30))
        subTitleLabel?.font = UIFont.systemFont(ofSize: 14)
        subTitleLabel?.textColor = UIColor.gray
        shopcellView?.addSubview(subTitleLabel!)
        //价格
        pirceLabel = UILabel(frame: CGRect(x:(iconImage?.frame.size.width)!+25, y:(iconImage?.frame.size.height)!-40, width:60, height: 30))
        pirceLabel?.font = UIFont.systemFont(ofSize: 15)
        pirceLabel?.textColor = UIColor.black
        shopcellView?.addSubview(pirceLabel!)
        // 按钮
        subButton = UIButton(frame: CGRect(x:screenWidth-80-25, y:(iconImage?.frame.size.height)!-40, width:80, height: 25))
        subButton?.setTitle("购买", for: UIControl.State.normal)
        subButton?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        subButton?.backgroundColor = UIColor.black
        subButton?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        subButton?.addTarget(self, action: #selector(BuyClick), for: UIControl.Event.touchUpInside)
        //subButton!.tag = pid
        shopcellView?.addSubview(subButton!)
        
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
