//
//  ShopTableViewCell.swift
//  XZ
//
//  Created by wjz on 2019/1/9.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit
import Alamofire
class Shop3TableViewCell: UITableViewCell{
    var iconImage     : UIImageView?
    var titleLabel    : UILabel?
    var subTitleLabel : UILabel?
    var pirceLabel : UILabel?
    var subButton : UIButton?
    let screenWidth =  UIScreen.main.bounds.size.width
    var rows:Int = 0
    var shopcellView : UIButton?
    var root : Shop3TableViewController?
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
        var pid = (root?.pidss[shopcellView.tag])!
        var ntitle:String = (root?.titles[shopcellView.tag])!
        root?.root?.pids = pid
        root?.root?.Ntitle = ntitle
        root?.root?.todeatil()
    }
    @objc func BuyClick(subButton: UIButton) {
        var pid = (root?.pidss[subButton.tag])!
        var proname:String = (root?.titles[subButton.tag])!
        let alertController = UIAlertController(title: "提示", message: "是否获取应用\"\(proname)\"？",preferredStyle: .alert)
        let cancelAction1 = UIAlertAction(title: "确定", style: .destructive, handler: {
            action in
            self.createApp(pids: pid)
        })
        let cancelAction2 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction1)
        alertController.addAction(cancelAction2)
        root?.present(alertController, animated: true, completion: nil)
    }
    func createApp(pids:Int) {
        var userid:Int = UserDefaults.standard.object(forKey: "userId") as! Int
        let url = "https://www.xingzhu.club/XzTest/apps/createApp"
        let paras = ["productId":pids,"userId":userid]
        print("商品ID\(pids),用户\(userid)")
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("jsonRequest:\(response.result)")
            
            if let data = response.result.value {
                let json = JSON(data)
                print("结果:\(json)")
                var code: Int = json["code"].int!
                print("错误:\(code)")
                var message:String = json["message"].string!
                print("创建应用提示:\(message)")
                let alertController = UIAlertController(title: message,
                                                        message: nil, preferredStyle: .alert)
                //显示提示框
                self.root?.present(alertController, animated: true, completion: nil)
                //两秒钟后自动消失
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                    self.root?.presentedViewController?.dismiss(animated: false, completion: nil)
                }
            }
        }
        
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
        titleLabel = UILabel(frame: CGRect(x:(iconImage?.frame.size.width)!+25, y:10, width: self.frame.size.width-(iconImage?.frame.size.width)!+20, height:20))
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        titleLabel?.textColor = UIColor.black
        titleLabel?.numberOfLines=0
        titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel?.textAlignment = .left
        shopcellView?.addSubview(titleLabel!)
        
        // 简介
        subTitleLabel = UILabel(frame: CGRect(x:(iconImage?.frame.size.width)!+25, y:(titleLabel?.frame.size.height)!+15, width:self.frame.size.width-(iconImage?.frame.size.width)!+10, height: 30))
        subTitleLabel?.font = UIFont.systemFont(ofSize: 14)
        subTitleLabel?.textColor = UIColor.gray
        subTitleLabel?.numberOfLines=0
        subTitleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        subTitleLabel?.textAlignment = .left
        shopcellView?.addSubview(subTitleLabel!)
        //价格
        pirceLabel = UILabel(frame: CGRect(x:(iconImage?.frame.size.width)!+25, y:(iconImage?.frame.size.height)!-30, width:60, height: 20))
        pirceLabel?.font = UIFont.systemFont(ofSize: 15)
        pirceLabel?.textColor = UIColor.black
        shopcellView?.addSubview(pirceLabel!)
        // 按钮
        subButton = UIButton(frame: CGRect(x:screenWidth-80-25, y:(iconImage?.frame.size.height)!-35, width:80, height: 25))
        subButton?.setTitle("获取应用", for: UIControl.State.normal)
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
    //label自适应高度
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        var theheight:CGFloat = 0.0
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        print("高度是\(label.frame.height)")
        if(label.frame.height>50.5){
            theheight = 50.5
        }else{
            theheight = label.frame.height
        }
        return theheight
    }
}
