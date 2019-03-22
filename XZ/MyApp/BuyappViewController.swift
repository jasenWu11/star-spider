//
//  BuyappViewController.swift
//  XZ
//
//  Created by wjz on 2019/3/1.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit
import Alamofire
class BuyappViewController: UIViewController {
    @IBOutlet weak var tv_proname: UILabel!
    @IBOutlet weak var bt_tobuy: UIButton!
    @IBOutlet weak var v_price: UIView!
    @IBOutlet weak var bt_mo: UIButton!
    @IBOutlet weak var bt_se: UIButton!
    @IBOutlet weak var bt_ye: UIButton!
    var btwidth =  UIScreen.main.bounds.size.width
    var btheight =  UIScreen.main.bounds.size.width
    var prices :Double = 0.0
    var pids :Int = 0
    var type:Int = 0
    var l_tm : UILabel?
    var l_ts : UILabel?
    var l_ty : UILabel?
    var p_tm : UILabel?
    var p_ts : UILabel?
    var p_ty : UILabel?
    var yuer : Double = 0.0;
    var proname:String = ""
    var pircem:Double = 0.0
    var pircese:Double = 0.0
    var pricey:Double = 0.0
    var userid:Int = 0
    var ifhasPayPwd : String = "没有设置支付密码"
    override func viewDidLoad() {
        super.viewDidLoad()
        ifHasPayPwd()
        userid = UserDefaults.standard.object(forKey: "userId") as! Int
        getProducts()
        bt_tobuy?.clipsToBounds=true
        bt_tobuy?.layer.cornerRadius = 20
        bt_tobuy?.layer.shadowColor = UIColor.gray.cgColor
        bt_tobuy?.layer.shadowOpacity = 1.0
        bt_tobuy?.layer.shadowOffset = CGSize(width: 0, height: 0)
        bt_tobuy?.layer.shadowRadius = 4
        bt_tobuy?.layer.masksToBounds = false
        bt_tobuy?.backgroundColor = UIColorRGB_Alpha(R: 91.0, G: 84.0, B: 145.0, alpha: 0.8);
        
        btwidth =  (bt_mo?.frame.size.width)!
        btheight =  (bt_se?.frame.size.height)!
        
        bt_mo.backgroundColor = UIColor.white
        bt_mo?.addTarget(self, action: #selector(moBtnClick), for: UIControl.Event.touchUpInside)
        bt_se.backgroundColor = UIColor.white
        bt_ye.backgroundColor = UIColor.white
        
        bt_mo?.clipsToBounds=true
        bt_mo?.layer.cornerRadius = 5
        bt_mo?.layer.masksToBounds = false
        bt_mo?.layer.borderWidth = 1
        bt_mo?.layer.borderColor = UIColor.gray.cgColor
        
        bt_se?.clipsToBounds=true
        bt_se?.layer.cornerRadius = 5
        bt_se?.layer.masksToBounds = false
        bt_se?.layer.borderWidth = 1
        bt_se?.addTarget(self, action: #selector(seBtnClick), for: UIControl.Event.touchUpInside)
        bt_se?.layer.borderColor = UIColor.gray.cgColor
        
        bt_ye?.clipsToBounds=true
        bt_ye?.layer.cornerRadius = 5
        bt_ye?.layer.masksToBounds = false
        bt_ye?.layer.borderWidth = 1
        bt_ye?.layer.borderColor = UIColor.gray.cgColor
        bt_ye?.addTarget(self, action: #selector(yeBtnClick), for: UIControl.Event.touchUpInside)
        
        l_tm = UILabel(frame: CGRect(x:10, y:20, width: btwidth-20, height:20))
        l_tm?.font = UIFont.systemFont(ofSize: 12)
        l_tm?.textColor = UIColor.black
        l_tm?.numberOfLines = 0
        l_tm?.lineBreakMode = NSLineBreakMode.byWordWrapping
        bt_mo?.addSubview(l_tm!)
        l_tm?.textAlignment = .center
        l_tm?.text = "1个月"
        
        p_tm = UILabel(frame: CGRect(x:10, y:(btheight-40)/2, width: btwidth-20, height:40))
        p_tm?.font = UIFont.systemFont(ofSize: 18)
        p_tm?.textColor = UIColor.red
        p_tm?.numberOfLines = 0
        p_tm?.lineBreakMode = NSLineBreakMode.byWordWrapping
        bt_mo?.addSubview(p_tm!)
        p_tm?.textAlignment = .center
        p_tm?.text = "30"
        
        l_ts = UILabel(frame: CGRect(x:10, y:20, width: btwidth-20, height:20))
        l_ts?.font = UIFont.systemFont(ofSize: 12)
        l_ts?.textColor = UIColor.black
        l_ts?.numberOfLines = 0
        l_ts?.lineBreakMode = NSLineBreakMode.byWordWrapping
        bt_se?.addSubview(l_ts!)
        l_ts?.textAlignment = .center
        l_ts?.text = "1个季度"
        
        p_ts = UILabel(frame: CGRect(x:10, y:(btheight-40)/2, width: btwidth-20, height:40))
        p_ts?.font = UIFont.systemFont(ofSize: 18)
        p_ts?.textColor = UIColor.red
        p_ts?.numberOfLines = 0
        p_ts?.lineBreakMode = NSLineBreakMode.byWordWrapping
        bt_se?.addSubview(p_ts!)
        p_ts?.textAlignment = .center
        p_ts?.text = "90"
        
        l_ty = UILabel(frame: CGRect(x:10, y:20, width: btwidth-20, height:20))
        l_ty?.font = UIFont.systemFont(ofSize: 12)
        l_ty?.textColor = UIColor.black
        l_ty?.numberOfLines = 0
        l_ty?.lineBreakMode = NSLineBreakMode.byWordWrapping
        bt_ye?.addSubview(l_ty!)
        l_ty?.textAlignment = .center
        l_ty?.text = "1年"
        
        p_ty = UILabel(frame: CGRect(x:10, y:(btheight-40)/2, width: btwidth-20, height:40))
        p_ty?.font = UIFont.systemFont(ofSize: 18)
        p_ty?.textColor = UIColor.red
        p_ty?.numberOfLines = 0
        p_ty?.lineBreakMode = NSLineBreakMode.byWordWrapping
        bt_ye?.addSubview(p_ty!)
        p_ty?.textAlignment = .center
        p_ty?.text = "300"
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func touch(sender: UIButton){
        //重置点击机制
        bt_mo.isSelected = false
        
        bt_se.isSelected = false
        
        bt_ye.isSelected = false
        
        bt_mo.backgroundColor = UIColor.white
        bt_se.backgroundColor = UIColor.white
        bt_ye.backgroundColor = UIColor.white
        
        bt_mo?.layer.borderColor = UIColor.gray.cgColor
        bt_se?.layer.borderColor = UIColor.gray.cgColor
        bt_ye?.layer.borderColor = UIColor.gray.cgColor
        sender.isSelected = true
        
        sender.backgroundColor = UIColor(red: 91.0/255.0, green: 84.0/255.0, blue: 145.0/255.0, alpha: 0.7)
        sender.layer.borderColor = UIColor(red: 250.0/255.0, green: 245.0/255.0, blue: 219.0/255.0, alpha: 1.0).cgColor
    }
    @IBAction func tobuy(_ sender: Any) {
        if(bt_mo.isSelected == true){
            prices = pircem
            type = 1
            Xiadan()
        }
        else if(bt_se.isSelected == true){
            
            prices = pircese
            type = 2
            Xiadan()
        }
        else if(bt_ye.isSelected == true){
            
            prices = pricey
            type = 3
            Xiadan()
        }
        else{
            showMsgbox(_message: "请选择购买天数")
        }
        print("最终价格为\(prices)")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func moBtnClick(shopcellView: UILabel) {
        l_tm?.textColor = UIColor.white
        l_ts?.textColor = UIColor.black
        l_ty?.textColor = UIColor.black
    }
    @objc func seBtnClick(shopcellView: UILabel) {
        l_tm?.textColor = UIColor.black
        l_ts?.textColor = UIColor.white
        l_ty?.textColor = UIColor.black
    }
    @objc func yeBtnClick(shopcellView: UILabel) {
        l_tm?.textColor = UIColor.black
        l_ts?.textColor = UIColor.black
        l_ty?.textColor = UIColor.white
    }
    func UIColorRGB_Alpha(R:CGFloat, G:CGFloat, B:CGFloat, alpha:CGFloat) -> UIColor
    {
        let color = UIColor.init(red: (R / 255.0), green: (G / 255.0), blue: (B / 255.0), alpha: alpha);
        return color;
    }
    func showMsgbox(_message: String, _title: String = "提示"){
        
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func getProducts()  {
        let url = "https://www.xingzhu.club/XzTest/products/getProductById"
        print("产品ID\(self.pids)")
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        let paras = ["productId":self.pids]
        print("搜索\(self.pids)")
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
                let provinces = json["data"]
                for i in 0..<provinces.count{
                    let productTitle: String = provinces["productTitle"].string ?? ""
                    self.proname = productTitle
                    
                    let productpricemMonth: Double = provinces["productPriceMonth"].double ?? 0
                    self.pircem = productpricemMonth
                    
                    let productPriceSeason: Double = provinces["productPriceSeason"].double ?? 0
                    self.pircese = productPriceSeason
                    
                    let productPriceYear: Double = provinces["productPriceYear"].double ?? 0
                    self.pricey = productPriceYear
                }
                self.tv_proname.text = self.proname
                self.p_tm?.text = "¥\(self.pircem)"
                self.p_ts?.text = "¥\(self.pircese)"
                self.p_ty?.text = "¥\(self.pricey)"
            }
            print("季度是\(self.prices)")
            print("年是\(self.pricey)")
        }
    }
    func Xiadan() {
        
                let url = "https://www.xingzhu.club/XzTest/orders/postOrder"
        let paras = ["productId":self.pids,"userId":self.userid,"orderSpec":self.type]
                print("商品ID\(self.pids),用户\(self.userid),规格\(self.type)")
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
                        if (message == "创建订单成功！") {
                           let ordermess = json["data"]
                            let orderId: Int = ordermess["orderId"].int ?? 0
                            let productId: Int = ordermess["productId"].int ?? 0
                            let prices: Double = ordermess["productPriceMonth"].double ?? 0
                            self.toPay(oids: orderId, pids: productId, price: prices)
                        }
                        else{
                            let alertController = UIAlertController(title: "\(message)",
                                message: nil, preferredStyle: .alert)
                            //显示提示框
                            self.present(alertController, animated: true, completion: nil)
                            //两秒钟后自动消失
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                                self.presentedViewController?.dismiss(animated: false, completion: nil)
                            }
                        }
                    }
                }
        
    }
    func toPay(oids:Int,pids:Int,price:Double){
        if(ifhasPayPwd == "没有设置支付密码"){
            let alertController = UIAlertController(title: "提示", message: "您未设置支付密码，请先设置",preferredStyle: .alert)
            let cancelAction1 = UIAlertAction(title: "确定", style: .destructive, handler: {
                action in
                self.gettopay()
            })
            let cancelAction2 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alertController.addAction(cancelAction1)
            alertController.addAction(cancelAction2)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            WMPasswordView.show(type: WMPwdType.payPwd, amount: price) { [weak self] pwd in
                self?.payok(orderids: oids, productids: pids, prices: price, ppass: pwd)
            }
        }
        
    }
    func payok(orderids:Int,productids:Int,prices:Double,ppass:String){
        var userid:Int = UserDefaults.standard.object(forKey: "userId") as! Int
        let url = "https://www.xingzhu.club/XzTest/orders/payOrder"
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        let paras = ["userId":userid,"orderId":orderids,"productId":productids,"productPriceMonth":prices,"payType":0,"userPayPassword":ppass] as [String : Any]
        print("订单ID\(orderids)")
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("jsonRequest:\(response.result)")
            var request : String = "\(response.result)"
            if let data = response.result.value {
                let json = JSON(data)
                print("结果:\(json)")
                let code: Int = json["code"].int!
                print("错误:\(code)")
                var message:String = json["message"].string!
                print("message\(message)")
                let alertController = UIAlertController(title: "\(message)",
                    message: nil, preferredStyle: .alert)
                //显示提示框
                self.present(alertController, animated: true, completion: nil)
                //两秒钟后自动消失
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.presentedViewController?.dismiss(animated: false, completion: nil)
                }
                if(message == "订单支付成功！"){
                    if UserDefaults.standard.object(forKey: "userBalance") != nil {
                        self.yuer = UserDefaults.standard.object(forKey: "userBalance") as! Double
                    }
                    UserDefaults.standard.set(self.yuer-prices, forKey: "userBalance")
                    self.back((Any).self)
                }
            }

        }
    }
    func ifHasPayPwd(){
        var userid:Int = UserDefaults.standard.object(forKey: "userId") as! Int
        let url = "https://www.xingzhu.club/XzTest/users/ifHasPayPwd"
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        let paras = ["userId":userid]
        print("用户ID\(userid)")
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("jsonRequest:\(response.result)")
            var request : String = "\(response.result)"
            if let data = response.result.value {
                let json = JSON(data)
                print("结果:\(json)")
                let code: Int = json["code"].int!
                print("错误:\(code)")
                var message:String = json["message"].string!
                print("message\(message)")
                if (message == "用户已设置支付密码"){
                    self.ifhasPayPwd = "已设置支付密码"
                }else{
                    self.ifhasPayPwd = "没有设置支付密码"
                }
            }
        }
    }
    func gettopay(){
       self.performSegue(withIdentifier: "setpaypass", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "setpaypass"{
            let controller = segue.destination as! SetpaypassViewController
            controller.ntitle = "设置支付密码"
            
        }
    }
}
