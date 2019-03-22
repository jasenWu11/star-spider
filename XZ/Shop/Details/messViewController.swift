//
//  messViewController.swift
//  XZ
//
//  Created by wjz on 2019/1/24.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit
import Alamofire
class messViewController: UIViewController {
    var root : APImessViewController?
    var proView : UIView?
    var proPhoto : UIImageView?
    var protitle : UILabel?
    var prodes : UILabel?
    var versView : UIView?
    var verslabel : UILabel?
    var version : UILabel?
    var uptimelabel : UILabel?
    var uptime : UILabel?
    var renqilabel : UILabel?
    var renqi : UILabel?
    var qixianlabel : UILabel?
    var qixian : UILabel?
    var priceView : UIView?
    var pricelabel : UILabel?
    var tv_price : UILabel?
    var bt_dycs : UIButton?
    var jingaoView : UIView?
    var tv_jg : UITextView?
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    var pids:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColorRGB_Alpha(R: 238.0, G: 238.0, B: 238.0, alpha: 1.0);
        //商品视图
        proView = UIView(frame: CGRect(x:0, y: 0, width:screenWidth, height: screenWidth*3/4))
        proView?.backgroundColor=UIColor.white
        proView?.clipsToBounds=true
        proView?.layer.shadowColor = UIColor.gray.cgColor
        proView?.layer.shadowOpacity = 1.0
        proView?.layer.shadowOffset = CGSize(width: 0, height: 0)
        proView?.layer.shadowRadius = 4
        proView?.layer.masksToBounds = false
        view.addSubview(proView!)
        //图片
        proPhoto = UIImageView(frame: CGRect(x:0, y: 0, width:screenWidth, height: screenWidth*3/4))
        proView?.addSubview(proPhoto!)
        proPhoto?.image = UIImage(named:"weibo")
        
        //版本视图
        versView = UIView(frame: CGRect(x:0, y: (proView?.frame.size.height)!+5, width:screenWidth
            , height: 175))
        versView?.backgroundColor=UIColor.white
        versView?.clipsToBounds=true
        versView?.layer.shadowColor = UIColor.gray.cgColor
        versView?.layer.shadowOpacity = 1.0
        versView?.layer.shadowOffset = CGSize(width: 0, height: 0)
        versView?.layer.shadowRadius = 4
        versView?.layer.masksToBounds = false
        view.addSubview(versView!)
        let versViewWidth =  (UIScreen.main.bounds.size.width)/2
        let versViewHeight =  ((versView?.frame.size.height)!)/2
        //标题
        protitle = UILabel(frame: CGRect(x:10, y:10, width: versViewWidth+10, height:50))
        protitle?.font = UIFont.systemFont(ofSize: 16)
        protitle?.textColor = UIColor.black
        protitle?.numberOfLines=0
        protitle?.lineBreakMode = NSLineBreakMode.byWordWrapping
        versView?.addSubview(protitle!)
        protitle?.textAlignment=NSTextAlignment.left
        //价格内容
        tv_price = UILabel(frame: CGRect(x:versViewWidth+20, y:10, width: versViewWidth-30, height:20))
        tv_price?.font = UIFont.systemFont(ofSize: 16)
        tv_price?.textColor = UIColorRGB_Alpha(R: 0.0, G: 140.0, B: 255.0, alpha: 1.0);
        tv_price?.numberOfLines = 0
        tv_price?.lineBreakMode = NSLineBreakMode.byWordWrapping
        versView?.addSubview(tv_price!)
        tv_price?.adjustsFontSizeToFitWidth=true
        tv_price?.textAlignment = .right
        tv_price?.text = "28.8"
        //描述
        prodes = UILabel(frame: CGRect(x:10, y:(protitle?.frame.size.height)!+15, width: screenWidth-20, height:50))
        prodes?.font = UIFont.systemFont(ofSize: 16)
        prodes?.textColor = UIColor.black
        prodes?.numberOfLines=0
        prodes?.lineBreakMode = NSLineBreakMode.byWordWrapping
        prodes?.textAlignment = .left
        versView?.addSubview(prodes!)
        //版本号
        verslabel = UILabel(frame: CGRect(x:10, y:(protitle?.frame.size.height)!+(prodes?.frame.size.height)!+20, width: 45, height:20))
        verslabel?.font = UIFont.systemFont(ofSize: 14)
        verslabel?.textColor = UIColor.black
        verslabel?.numberOfLines = 0
        verslabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        versView?.addSubview(verslabel!)
        verslabel?.adjustsFontSizeToFitWidth=true
        verslabel?.text = "版本："
        //版本号数字
        version = UILabel(frame: CGRect(x:(verslabel?.frame.size.width)!+15, y:(protitle?.frame.size.height)!+(prodes?.frame.size.height)!+20, width: versViewWidth-60-20, height:20))
        version?.font = UIFont.systemFont(ofSize: 14)
        version?.textColor = UIColor.black
        version?.numberOfLines = 0
        version?.lineBreakMode = NSLineBreakMode.byWordWrapping
        versView?.addSubview(version!)
        version?.adjustsFontSizeToFitWidth=true
        version?.text = "v1.3(4)"
        //更新时间标签
        uptimelabel = UILabel(frame: CGRect(x:versViewWidth-10, y:(protitle?.frame.size.height)!+(prodes?.frame.size.height)!+20, width: 75, height:20))
        uptimelabel?.font = UIFont.systemFont(ofSize: 14)
        uptimelabel?.textColor = UIColor.black
        uptimelabel?.numberOfLines = 0
        uptimelabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        versView?.addSubview(uptimelabel!)
        uptimelabel?.adjustsFontSizeToFitWidth=true
        uptimelabel?.text = "更新时间："
        //更新时间
        uptime = UILabel(frame: CGRect(x:versViewWidth+(uptimelabel?.frame.size.width)!-10, y:(protitle?.frame.size.height)!+(prodes?.frame.size.height)!+20, width: versViewWidth-75-10, height:20))
        uptime?.font = UIFont.systemFont(ofSize: 14)
        uptime?.textColor = UIColor.black
        uptime?.numberOfLines = 0
        uptime?.lineBreakMode = NSLineBreakMode.byWordWrapping
        versView?.addSubview(uptime!)
        uptime?.adjustsFontSizeToFitWidth=true
        uptime?.text = "2018-09-11"
        
        //人气
        renqilabel = UILabel(frame: CGRect(x:10, y:(protitle?.frame.size.height)!+(prodes?.frame.size.height)!+(verslabel?.frame.size.height)!+25, width: 45, height:20))
        renqilabel?.font = UIFont.systemFont(ofSize: 14)
        renqilabel?.textColor = UIColor.black
        renqilabel?.numberOfLines = 0
        renqilabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        versView?.addSubview(renqilabel!)
        renqilabel?.adjustsFontSizeToFitWidth=true
        renqilabel?.text = "人气："
        //人气内容
        renqi = UILabel(frame: CGRect(x:(verslabel?.frame.size.width)!+15, y:(protitle?.frame.size.height)!+(prodes?.frame.size.height)!+(verslabel?.frame.size.height)!+25, width: versViewWidth-60-20, height:20))
        renqi?.font = UIFont.systemFont(ofSize: 14)
        renqi?.textColor = UIColor.black
        renqi?.numberOfLines = 0
        renqi?.lineBreakMode = NSLineBreakMode.byWordWrapping
        versView?.addSubview(renqi!)
        renqi?.adjustsFontSizeToFitWidth=true
        renqi?.text = "4998"
        //有限期限
        qixianlabel = UILabel(frame: CGRect(x:versViewWidth-10, y:(protitle?.frame.size.height)!+(prodes?.frame.size.height)!+(verslabel?.frame.size.height)!+25, width: 75, height:20))
        qixianlabel?.font = UIFont.systemFont(ofSize: 14)
        qixianlabel?.textColor = UIColor.black
        qixianlabel?.numberOfLines = 0
        qixianlabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        versView?.addSubview(qixianlabel!)
        qixianlabel?.adjustsFontSizeToFitWidth=true
        qixianlabel?.text = "有限期限："
        //期限内容
        qixian = UILabel(frame: CGRect(x:versViewWidth+(uptimelabel?.frame.size.width)!-10, y:(protitle?.frame.size.height)!+(prodes?.frame.size.height)!+(verslabel?.frame.size.height)!+25, width: versViewWidth-75-10, height:20))
        qixian?.font = UIFont.systemFont(ofSize: 14)
        qixian?.textColor = UIColor.black
        qixian?.numberOfLines = 0
        qixian?.lineBreakMode = NSLineBreakMode.byWordWrapping
        versView?.addSubview(qixian!)
        qixian?.adjustsFontSizeToFitWidth=true
        qixian?.text = "一个月"
//        //价格视图
//        priceView = UIView(frame: CGRect(x:0, y: (proView?.frame.size.height)!+(versView?.frame.size.height)!+25, width:screenWidth
//            , height: 55))
//        priceView?.backgroundColor=UIColor.white
//        priceView?.clipsToBounds=true
//        priceView?.layer.shadowColor = UIColor.gray.cgColor
//        priceView?.layer.shadowOpacity = 1.0
//        priceView?.layer.shadowOffset = CGSize(width: 0, height: 0)
//        priceView?.layer.shadowRadius = 4
//        priceView?.layer.masksToBounds = false
//        view.addSubview(priceView!)
//
//        //调用次数按钮
//        bt_dycs = UIButton(frame: CGRect(x:screenWidth-130, y:0, width:130, height: (priceView?.frame.size.height)!))
//        bt_dycs?.setTitle("购买调用次数", for: UIControl.State.normal)
//        bt_dycs?.setTitleColor(UIColor.white, for: UIControl.State.normal)
//        bt_dycs?.backgroundColor = UIColorRGB_Alpha(R: 0.0, G: 140.0, B: 255.0, alpha: 1.0);
//        bt_dycs?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//        bt_dycs?.addTarget(self, action: #selector(gmcsBtnClick), for: UIControl.Event.touchUpInside)
//        //subButton!.tag = pid
//        priceView?.addSubview(bt_dycs!)
        //警告视图
        jingaoView = UIView(frame: CGRect(x:0, y: (proView?.frame.size.height)!+(versView?.frame.size.height)!+10, width:screenWidth
            , height: 50))
        jingaoView?.backgroundColor=UIColor.white
        jingaoView?.clipsToBounds=true
        jingaoView?.layer.shadowColor = UIColor.gray.cgColor
        jingaoView?.layer.shadowOpacity = 1.0
        jingaoView?.layer.shadowOffset = CGSize(width: 0, height: 0)
        jingaoView?.layer.shadowRadius = 4
        jingaoView?.layer.masksToBounds = false
        view.addSubview(jingaoView!)
        //警告内容
        tv_jg = UITextView(frame: CGRect(x:15, y:0, width: screenWidth-30, height:50))
        tv_jg?.font = UIFont.systemFont(ofSize: 14)
        tv_jg?.textColor = UIColor.gray
        tv_jg?.isEditable = false
        jingaoView?.addSubview(tv_jg!)
        tv_jg?.text = "API来源于用户发布，如有侵犯您的隐私权或版权，请联系我们！"
        getProducts()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func gmcsBtnClick(shopcellView: UILabel) {
        print("购买了\(shopcellView.tag)多少次")
    }
    /// 设置颜色与透明度（RGB：0.0~255.0；alpha：0.0~1.0） 示例：UIColorRGB_Alpha(100.0, 100.0, 20.0, 1.0)
    func UIColorRGB_Alpha(R:CGFloat, G:CGFloat, B:CGFloat, alpha:CGFloat) -> UIColor
    {
        let color = UIColor.init(red: (R / 255.0), green: (G / 255.0), blue: (B / 255.0), alpha: alpha);
        return color;
    }
    @objc func getProducts()  {
        let url = "https://www.xingzhu.club/XzTest/products/getProductById"
        let paras = ["productId":self.pids]
        print("商品ID\(self.pids)")
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
                let promess = json["data"]
                let protitle: String = promess["productTitle"].string ?? ""
                let prodes: String = promess["productDes"].string ?? ""
                let prophoto: String = promess["productPhoto"].string ?? ""
                let proutime: String = promess["productUpdateTime"].string ?? ""
                let proplice: Double = promess["productPriceMonth"].double ?? 0.0000
                let proatime: String = promess["productAddedTime"].string ?? ""
                let provers: String = promess["productVersion"].string ?? ""
                let propopu: Int = promess["productPopularity"].int ?? 0
                self.protitle?.text = "\(protitle)"
                var protitleheight = self.heightForView(text: "\(self.protitle?.text)", font: UIFont.systemFont(ofSize: 16), width:  self.screenWidth-20 ,wheres:"protitle")
                self.protitle?.frame.size.height = protitleheight
                
                self.prodes?.text = "简介: \(prodes)"
                var theheight = self.heightForView(text: "\(self.prodes?.text)", font: UIFont.systemFont(ofSize: 16), width:  self.screenWidth-20,wheres:"prodes")
                self.prodes?.frame.size.height = theheight
                self.uptime?.text = proutime
                 var proplices = "\(proplice)"
                self.tv_price?.text = "价格：\(proplices) 每月"
                self.version?.text = provers
                self.root?.proedit = provers
                self.root?.prouptime = proutime
                var propopus = "\(propopu)"
                self.renqi?.text = propopus
                print("图片路径\(prophoto)")
                if(prophoto != ""){
                    let url = URL(string:prophoto)
                    let data = try! Data(contentsOf: url!)
                    let smallImage = UIImage(data: data)
                    self.proPhoto?.image = smallImage
                }
            }
        }
    }
    //label自适应高度
    func heightForView(text:String, font:UIFont, width:CGFloat,wheres:String) -> CGFloat{
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        print("返回的\(label.frame.height)")
        if(wheres == "protitle"){
            var they = 50-label.frame.height
            prodes?.frame.origin.y -= they
            verslabel?.frame.origin.y -= they
            version?.frame.origin.y -= they
            uptimelabel?.frame.origin.y -= they
            uptime?.frame.origin.y -= they
            renqilabel?.frame.origin.y -= they
            renqi?.frame.origin.y -= they
            qixianlabel?.frame.origin.y -= they
            qixian?.frame.origin.y -= they
            versView?.frame.size.height -= they
            jingaoView?.frame.origin.y -= they
        }
        if (wheres == "prodes") {
            var they = 50-label.frame.height
            verslabel?.frame.origin.y -= they
            version?.frame.origin.y -= they
            uptimelabel?.frame.origin.y -= they
            uptime?.frame.origin.y -= they
            renqilabel?.frame.origin.y -= they
            renqi?.frame.origin.y -= they
            qixianlabel?.frame.origin.y -= they
            qixian?.frame.origin.y -= they
            versView?.frame.size.height -= they
            jingaoView?.frame.origin.y -= they
        }
        
        return label.frame.height
    }
}


