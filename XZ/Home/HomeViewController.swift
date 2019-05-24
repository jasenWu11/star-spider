//
//  HomeViewController.swift
//  XZ
//
//  Created by wjz on 2018/12/29.
//  Copyright © 2018年 wjz. All rights reserved.
//

import UIKit
import Alamofire
class HomeViewController: UIViewController , SliderGalleryControllerDelegate{
    //获取屏幕宽度
    @IBOutlet weak var sv_home: UIScrollView!
    let screenWidth =  UIScreen.main.bounds.size.width
    var v_xzjj:UIButton?
    var v_pcjj:UIButton?
    var v_apijj:UIButton?
    var v_sjyjj:UIButton?
    var iv_xz:UIImageView?
    var iv_pc:UIImageView?
    var iv_api:UIImageView?
    var iv_sjy:UIImageView?
    var lv_xz:UILabel?
    var lv_pc:UILabel?
    var lv_api:UILabel?
    var lv_sjy:UILabel?
    var sv_height:CGFloat = 0.0
    var showtitle:[String] = []
    var showimg:[String] = []
    var showurl:[String] = []
    var httpbefore:String = "https://fengfulai.xyz/#"
    var ppic:[String] = []
    var ppid:[Int] = [1,2,3,4,5]
    var theadvcount:Int = 5
    var l_rm:UILabel?
    var l_gd:UILabel?
    var v_tj:UIView?
    var v_tj1:UIButton?
    var v_tj2:UIButton?
    var v_tj3:UIButton?
    var iv_tj1:UIImageView?
    var iv_tj2:UIImageView?
    var iv_tj3:UIImageView?
    var l_bt1:UILabel?
    var l_bt2:UILabel?
    var l_bt3:UILabel?
    var titles:[String] = []
    var images:[UIImage?] = []
    var pidss:[Int] = []
    var l_jq:UILabel?
    var l_ck:UILabel?
    var v_jq:UIView?
    var v_jq1:UIButton?
    var v_jq2:UIButton?
    var v_jq3:UIButton?
    var atitles:[String] = []
    var crawlerName:[String] = []
    var iskeywords:[Int] = []
    var iskey:Int = 0
    var zappc:Int = 0
    //图片轮播组件
    var sliderGallery : SliderGalleryController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //关闭导航栏半透明效果
        self.navigationController?.navigationBar.isTranslucent = false
        getAllAdvs()
        getAllshow()
        //初始化图片轮播组件
        sliderGallery = SliderGalleryController()
        sliderGallery.delegate = self
        sliderGallery.view.frame = CGRect(x: 0, y: 0, width: screenWidth,
                                          height: (screenWidth)/16*11);
       
        //将图片轮播组件添加到当前视图
        self.addChild(sliderGallery)
        sv_home.addSubview(sliderGallery.view)
        //是否可以滚动
        sv_home.isScrollEnabled = true
        //垂直方向反弹
        sv_home.alwaysBounceVertical = true
        //垂直方向是否显示滚动条
        sv_home.showsVerticalScrollIndicator = false
        //添加组件的点击事件
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(HomeViewController.handleTapAction(_:)))
        sliderGallery.view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        sv_home.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        //星蛛简介视图
        v_xzjj = UIButton(frame: CGRect(x:5, y: (sliderGallery.view?.frame.size.height)!+5, width:(screenWidth-20)/2, height: (screenWidth-20)/2))
        v_xzjj?.backgroundColor=UIColor.white
        v_xzjj?.clipsToBounds=true
        v_xzjj?.layer.cornerRadius = 5
        v_xzjj?.layer.shadowColor = UIColor.gray.cgColor
        v_xzjj?.layer.shadowOpacity = 1.0
        v_xzjj?.layer.shadowOffset = CGSize(width: 0, height: 0)
        v_xzjj?.layer.shadowRadius = 4
        v_xzjj?.layer.masksToBounds = false
        sv_home.addSubview(v_xzjj!)
        v_xzjj?.tag = 0
        v_xzjj?.addTarget(self, action: #selector(Operactions), for: UIControl.Event.touchUpInside)
        //图片
        iv_xz = UIImageView(frame: CGRect(x:0, y: 0, width:(v_xzjj?.frame.size.width)!, height: (v_xzjj?.frame.size.height)!-30))
        iv_xz?.layer.cornerRadius = 5.0
        iv_xz?.layer.maskedCorners = [CACornerMask.layerMinXMinYCorner , CACornerMask.layerMaxXMinYCorner]
        iv_xz?.layer.masksToBounds = true
        iv_xz?.image = UIImage(named:"sjy")
        v_xzjj?.addSubview(iv_xz!)
        v_xzjj?.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        //文字
        lv_xz = UILabel(frame: CGRect(x:0, y:(iv_xz?.frame.size.height)!, width:(v_xzjj?.frame.size.width)!, height: (v_xzjj?.frame.size.height)!-(iv_xz?.frame.size.height)!))
        lv_xz?.font = UIFont.systemFont(ofSize: 14)
        lv_xz?.textColor = UIColor.black
        lv_xz?.text = "星蛛数据服务平台简介"
        v_xzjj?.addSubview(lv_xz!)
        lv_xz?.textAlignment=NSTextAlignment.center
        //爬虫简介视图
        v_pcjj = UIButton(frame: CGRect(x:(v_xzjj?.frame.size.width)!+15, y: (sliderGallery.view?.frame.size.height)!+5, width:(screenWidth-20)/2, height: (screenWidth-20)/2))
        v_pcjj?.backgroundColor=UIColor.white
        v_pcjj?.clipsToBounds=true
        v_pcjj?.layer.cornerRadius = 5
        v_pcjj?.layer.shadowColor = UIColor.gray.cgColor
        v_pcjj?.layer.shadowOpacity = 1.0
        v_pcjj?.layer.shadowOffset = CGSize(width: 0, height: 0)
        v_pcjj?.layer.shadowRadius = 4
        v_pcjj?.layer.masksToBounds = false
        sv_home.addSubview(v_pcjj!)
        v_pcjj?.tag = 1
        v_pcjj?.addTarget(self, action: #selector(Operactions), for: UIControl.Event.touchUpInside)
        //图片
        iv_pc = UIImageView(frame: CGRect(x:0, y: 0, width:(v_pcjj?.frame.size.width)!, height: (v_pcjj?.frame.size.height)!-30))
        iv_pc?.layer.cornerRadius = 5.0
        iv_pc?.layer.maskedCorners = [CACornerMask.layerMinXMinYCorner , CACornerMask.layerMaxXMinYCorner]
        iv_pc?.layer.masksToBounds = true
        iv_pc?.image = UIImage(named:"pach")
        v_pcjj?.addSubview(iv_pc!)
        v_pcjj?.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        //文字
        lv_pc = UILabel(frame: CGRect(x:0, y:(iv_pc?.frame.size.height)!, width:(v_pcjj?.frame.size.width)!, height: (v_pcjj?.frame.size.height)!-(iv_pc?.frame.size.height)!))
        lv_pc?.font = UIFont.systemFont(ofSize: 14)
        lv_pc?.textColor = UIColor.black
        lv_pc?.text = "什么是爬虫？"
        v_pcjj?.addSubview(lv_pc!)
        lv_pc?.textAlignment=NSTextAlignment.center
        //API简介视图
        v_apijj = UIButton(frame: CGRect(x:5, y: (sliderGallery.view?.frame.size.height)!+15+(v_xzjj?.frame.size.height)!, width:(screenWidth-20)/2, height: (screenWidth-20)/2))
        v_apijj?.backgroundColor=UIColor.white
        v_apijj?.clipsToBounds=true
        v_apijj?.layer.cornerRadius = 5
        v_apijj?.layer.shadowColor = UIColor.gray.cgColor
        v_apijj?.layer.shadowOpacity = 1.0
        v_apijj?.layer.shadowOffset = CGSize(width: 0, height: 0)
        v_apijj?.layer.shadowRadius = 4
        v_apijj?.layer.masksToBounds = false
        sv_home.addSubview(v_apijj!)
        v_apijj?.tag = 2
        v_apijj?.addTarget(self, action: #selector(Operactions), for: UIControl.Event.touchUpInside)
        //图片
        iv_api = UIImageView(frame: CGRect(x:0, y: 0, width:(v_apijj?.frame.size.width)!, height: (v_apijj?.frame.size.height)!-30))
        iv_api?.layer.cornerRadius = 5.0
        iv_api?.layer.maskedCorners = [CACornerMask.layerMinXMinYCorner , CACornerMask.layerMaxXMinYCorner]
        iv_api?.layer.masksToBounds = true
        iv_api?.image = UIImage(named:"API")
        v_apijj?.addSubview(iv_api!)
        v_apijj?.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        //文字
        lv_api = UILabel(frame: CGRect(x:0, y:(iv_api?.frame.size.height)!, width:(v_apijj?.frame.size.width)!, height: (v_apijj?.frame.size.height)!-(iv_api?.frame.size.height)!))
        lv_api?.font = UIFont.systemFont(ofSize: 14)
        lv_api?.textColor = UIColor.black
        lv_api?.text = "什么是API？"
        v_apijj?.addSubview(lv_api!)
        lv_api?.textAlignment=NSTextAlignment.center
        //SJY简介视图
        v_sjyjj = UIButton(frame: CGRect(x:(v_xzjj?.frame.size.width)!+15, y: (sliderGallery.view?.frame.size.height)!+15+(v_xzjj?.frame.size.height)!, width:(screenWidth-20)/2, height: (screenWidth-20)/2))
        v_sjyjj?.backgroundColor=UIColor.white
        v_sjyjj?.clipsToBounds=true
        v_sjyjj?.layer.cornerRadius = 5
        v_sjyjj?.layer.shadowColor = UIColor.gray.cgColor
        v_sjyjj?.layer.shadowOpacity = 1.0
        v_sjyjj?.layer.shadowOffset = CGSize(width: 0, height: 0)
        v_sjyjj?.layer.shadowRadius = 4
        v_sjyjj?.layer.masksToBounds = false
        sv_home.addSubview(v_sjyjj!)
        v_sjyjj?.tag = 3
        v_sjyjj?.addTarget(self, action: #selector(syjjAction), for: UIControl.Event.touchUpInside)
        //图片
        iv_sjy = UIImageView(frame: CGRect(x:0, y: 0, width:(v_sjyjj?.frame.size.width)!, height: (v_sjyjj?.frame.size.height)!-30))
        iv_sjy?.layer.cornerRadius = 5.0
        iv_sjy?.layer.maskedCorners = [CACornerMask.layerMinXMinYCorner , CACornerMask.layerMaxXMinYCorner]
        iv_sjy?.layer.masksToBounds = true
        iv_sjy?.image = UIImage(named:"logo")
        v_sjyjj?.addSubview(iv_sjy!)
        v_sjyjj?.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        //文字
        lv_sjy = UILabel(frame: CGRect(x:0, y:(iv_sjy?.frame.size.height)!, width:(v_sjyjj?.frame.size.width)!, height: (v_sjyjj?.frame.size.height)!-(iv_sjy?.frame.size.height)!))
        lv_sjy?.font = UIFont.systemFont(ofSize: 14)
        lv_sjy?.textColor = UIColor.black
        lv_sjy?.text = "使用教程"
        v_sjyjj?.addSubview(lv_sjy!)
        lv_sjy?.textAlignment=NSTextAlignment.center
        var theys = (sliderGallery.view?.frame.size.height)!+15+(v_xzjj?.frame.size.height)!+(v_apijj?.frame.size.height)!
        var thews = (sliderGallery.view?.frame.size.width)!
        sv_height = (sliderGallery.view?.frame.size.height)!+(v_xzjj?.frame.size.height)!+(v_apijj?.frame.size.height)!+20
        //热门推荐
        l_rm = UILabel(frame: CGRect(x:5, y: theys+15, width:120, height: 20))
        l_rm?.text = "热门推荐"
        l_rm?.textAlignment = .left
        sv_home.addSubview(l_rm!)
        //查看更多
        l_gd = UILabel(frame: CGRect(x:thews-125, y: theys+15, width:120, height: 20))
        l_gd?.text = "查看更多"
        l_gd?.textAlignment = .right
        l_gd?.textColor = UIColor.gray
        l_gd?.font = UIFont.systemFont(ofSize: 14)
        sv_home.addSubview(l_gd!)
        let lookclick = UITapGestureRecognizer(target: self, action: #selector(lookAction))
        l_gd?.addGestureRecognizer(lookclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        l_gd?.isUserInteractionEnabled = true
        sv_height += 40
        var vhei = (Int(thews)-10)/4+20
        var vheight = CGFloat(vhei)
        sv_height += vheight
        v_tj = UIView(frame: CGRect(x:5, y: theys+15+30, width:thews-10, height: vheight))
        v_tj?.backgroundColor = UIColor.white
        sv_home.addSubview(v_tj!)
        var rjsw = CGFloat(((v_tj?.frame.size.width)!-10)/3)
        var rjsh = (v_tj?.frame.size.height)!-20
        v_tj1 = UIButton(frame: CGRect(x:0, y: 0, width:rjsw, height: vheight))
        v_tj1?.backgroundColor = UIColor.white
        v_tj1?.addTarget(self, action: #selector(todeatil0), for: UIControl.Event.touchUpInside)
        v_tj?.addSubview(v_tj1!)
        
        iv_tj1 = UIImageView(frame: CGRect(x:0, y: 0, width:rjsw, height: rjsh))
        iv_tj1?.image = UIImage(named: "sjy")
        v_tj?.addSubview(iv_tj1!)
        l_bt1 = UILabel(frame: CGRect(x:0, y: rjsh, width:rjsw, height: 20))
        l_bt1?.textAlignment = .center
        l_bt1?.text = "哔哩哔哩搜索爬虫"
        l_bt1?.font = UIFont.systemFont(ofSize:12)
        v_tj?.addSubview(l_bt1!)
        
        v_tj2 = UIButton(frame: CGRect(x:rjsw+5, y: 0, width:rjsw, height: vheight))
        v_tj2?.backgroundColor = UIColor.white
        v_tj2?.addTarget(self, action: #selector(todeatil1), for: UIControl.Event.touchUpInside)
        v_tj?.addSubview(v_tj2!)
        iv_tj2 = UIImageView(frame: CGRect(x:0, y: 0, width:rjsw, height: rjsh))
        iv_tj2?.image = UIImage(named: "sjy")
        v_tj2?.addSubview(iv_tj2!)
        l_bt2 = UILabel(frame: CGRect(x:0, y: rjsh, width:rjsw, height: 20))
        l_bt2?.textAlignment = .center
        l_bt2?.text = "哔哩哔哩搜索爬虫"
        l_bt2?.font = UIFont.systemFont(ofSize:12)
        v_tj2?.addSubview(l_bt2!)
        
        v_tj3 = UIButton(frame: CGRect(x:rjsw+rjsw+10, y: 0, width:rjsw, height: vheight))
        v_tj3?.backgroundColor = UIColor.white
        v_tj3?.addTarget(self, action: #selector(todeatil2), for: UIControl.Event.touchUpInside)
        v_tj?.addSubview(v_tj3!)
        iv_tj3 = UIImageView(frame: CGRect(x:0, y: 0, width:rjsw, height: rjsh))
        iv_tj3?.image = UIImage(named: "sjy")
        v_tj3?.addSubview(iv_tj3!)
        l_bt3 = UILabel(frame: CGRect(x:0, y: rjsh, width:rjsw, height: 20))
        l_bt3?.textAlignment = .center
        l_bt3?.text = "哔哩哔哩搜索爬虫"
        l_bt3?.font = UIFont.systemFont(ofSize:12)
        v_tj3?.addSubview(l_bt3!)
        theys = sv_height+10
        //近期应用
        l_jq = UILabel(frame: CGRect(x:5, y: theys, width:120, height: 20))
        l_jq?.text = "近期应用"
        l_jq?.textAlignment = .left
        sv_home.addSubview(l_jq!)
        //查看更多
        l_ck = UILabel(frame: CGRect(x:thews-125, y: theys, width:120, height: 20))
        l_ck?.text = "查看更多"
        l_ck?.textAlignment = .right
        l_ck?.textColor = UIColor.gray
        l_ck?.font = UIFont.systemFont(ofSize: 14)
        sv_home.addSubview(l_ck!)
        let looksclick = UITapGestureRecognizer(target: self, action: #selector(looksAction))
        l_ck?.addGestureRecognizer(looksclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        l_ck?.isUserInteractionEnabled = true
        sv_height += 35
        var jqheight = vheight-20
        v_jq = UIView(frame: CGRect(x:5, y: sv_height, width:thews-10, height: jqheight))
        v_jq?.backgroundColor = UIColor.white
        sv_home.addSubview(v_jq!)
        v_jq1 = UIButton(frame: CGRect(x:0, y: 0, width:rjsw, height: jqheight))
        v_jq1?.backgroundColor = UIColor(red: 91.0/255.0, green: 84.0/255.0, blue: 145.0/255.0, alpha: 0.7)
        v_jq1?.setTitle("近期应用1", for: .normal)
        v_jq1?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        v_jq1?.titleLabel?.textColor = UIColor.black
        v_jq1?.clipsToBounds=true
        v_jq1?.layer.cornerRadius = 3
        v_jq1?.layer.shadowColor = UIColor.gray.cgColor
        v_jq1?.layer.shadowOpacity = 1.0
        v_jq1?.layer.shadowOffset = CGSize(width: 0, height: 0)
        v_jq1?.layer.shadowRadius = 2
        v_jq1?.layer.masksToBounds = false
        v_jq1?.addTarget(self, action: #selector(toapp0), for: UIControl.Event.touchUpInside)
        v_jq?.addSubview(v_jq1!)
        
        v_jq2 = UIButton(frame: CGRect(x:rjsw+5, y: 0, width:rjsw, height: jqheight))
        v_jq2?.backgroundColor = UIColor(red: 91.0/255.0, green: 84.0/255.0, blue: 145.0/255.0, alpha: 0.7)
        v_jq2?.setTitle("近期应用2", for: .normal)
        v_jq2?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        v_jq2?.titleLabel?.textColor = UIColor.black
        v_jq2?.clipsToBounds=true
        v_jq2?.layer.cornerRadius = 3
        v_jq2?.layer.shadowColor = UIColor.gray.cgColor
        v_jq2?.layer.shadowOpacity = 1.0
        v_jq2?.layer.shadowOffset = CGSize(width: 0, height: 0)
        v_jq2?.layer.shadowRadius = 2
        v_jq2?.layer.masksToBounds = false
        v_jq2?.addTarget(self, action: #selector(toapp1), for: UIControl.Event.touchUpInside)
        v_jq?.addSubview(v_jq2!)
        
        v_jq3 = UIButton(frame: CGRect(x:rjsw+rjsw+10, y: 0, width:rjsw, height: jqheight))
        v_jq3?.backgroundColor = UIColor(red: 91.0/255.0, green: 84.0/255.0, blue: 145.0/255.0, alpha: 0.7)
        v_jq3?.setTitle("近期应用3", for: .normal)
        v_jq3?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        v_jq3?.titleLabel?.textColor = UIColor.black
        v_jq3?.clipsToBounds=true
        v_jq3?.layer.cornerRadius = 3
        v_jq3?.layer.shadowColor = UIColor.gray.cgColor
        v_jq3?.layer.shadowOpacity = 1.0
        v_jq3?.layer.shadowOffset = CGSize(width: 0, height: 0)
        v_jq3?.layer.shadowRadius = 2
        v_jq2?.layer.masksToBounds = false
        v_jq3?.addTarget(self, action: #selector(toapp2), for: UIControl.Event.touchUpInside)
        v_jq?.addSubview(v_jq3!)
        sv_height += jqheight+10
        sv_home.contentSize = CGSize(width: screenWidth,
                                     height: sv_height);
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("主页显示")
        v_jq1?.isEnabled = false
        v_jq2?.isEnabled = false
        v_jq3?.isEnabled = false
        //手动调用刷新效果
        getAllProducts()
        getAllApps()
        // The rest of your code.
    }
    //图片轮播组件协议方法：获取内部scrollView尺寸
    func galleryScrollerViewSize() -> CGSize {
        return CGSize(width: screenWidth, height: (screenWidth)/16*11)
    }
    
    //图片轮播组件协议方法：获取数据集合
    func galleryDataSource() -> [String] {
        return self.ppic
    }
    
    //点击事件响应
    @objc func handleTapAction(_ tap:UITapGestureRecognizer)->Void{
        //获取图片索引值
        let index = sliderGallery.currentIndex
        //弹出索引信息

        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: APImessViewController())))
            as! APImessViewController
        controller.pid = ppid[index]
        controller.hidesBottomBarWhenPushed = true
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        self.hidesBottomBarWhenPushed = false
//        let alertController = UIAlertController(title: "您点击的图片索引是：",
//                                                message: "\(index)", preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func getAllAdvs()  {
        let url = "https://www.xingzhu.club/XzTest/advs/getAllAdvs"
        let paras = ["client":2]
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            //print("jsonRequest:\(response.result)")
            if let data = response.result.value {
                let json = JSON(data)
                print("结果:\(json)")
                var code: Int = json["code"].int!
                print("错误:\(code)")
                var message:String = json["message"].string!
                print("提示:\(message)")
                if(message == "查询成功"){
                    let provinces = json["data"]
                    self.ppic.removeAll()
                    self.ppid.removeAll()
                    self.theadvcount = provinces.count
                    for i in 0..<provinces.count{
                        let advPic: String = provinces[i]["advPic"].string ?? ""
                        
                        self.ppic += [advPic]
                        let productId: Int = provinces[i]["productId"].int ?? 0
                        
                        self.ppid += [productId]
                    }
                    
                    self.sliderGallery.reloadData()
                }
                
            }
        }
    }
    
    @objc func getAllshow()  {
        let url = "https://fengfulai.xyz/index.json"
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            print("jsonRequest:\(response.result)")
            if let data = response.result.value {
                let json = JSON(data)
                print("结果:\(json)")
                var code: Int = json["code"].int!
                print("错误:\(code)")
                var message:String = json["message"].string!
                print("提示:\(message)")
                if(message == "OK"){
                    let provinces = json["data"]
                    self.ppic.removeAll()
                    for i in 0..<provinces.count{
                        let title: String = provinces[i]["title"].string ?? ""
                        self.showtitle += [title]
                        let img: String = provinces[i]["img"].string ?? ""
                        self.showimg += [img]
                        let url: String = provinces[i]["url"].string ?? ""
                        self.showurl += [self.httpbefore+url]
                    }
                    print("网址为\(self.showurl)")
                    let url = URL(string:self.showimg[0])
                    if let data = try? Data(contentsOf: url!){
                        let smallImage = UIImage(data: data)
                        self.iv_xz?.image = smallImage
                        self.lv_xz?.text = self.showtitle[0]
                    }
                    
                    let url1 = URL(string:self.showimg[1])
                    if let data1 = try? Data(contentsOf: url1!){
                        let smallImage1 = UIImage(data: data1)
                        self.iv_pc?.image = smallImage1
                        self.lv_pc?.text = self.showtitle[1]
                    }
                    
                    let url2 = URL(string:self.showimg[2])
                    if let data2 = try? Data(contentsOf: url2!){
                        let smallImage2 = UIImage(data: data2)
                        self.iv_api?.image = smallImage2
                        self.lv_api?.text = self.showtitle[2]
                    }
                    
//                    let url3 = URL(string:self.showimg[3])
//                    if let data3 = try? Data(contentsOf: url3!){
//                        let smallImage3 = UIImage(data: data3)
//                        self.iv_sjy?.image = smallImage3
//                        self.lv_sjy?.text = self.showtitle[3]
//                    }
                }
                
            }
        }
    }
    func getAllProducts()  {
        self.titles.removeAll()
        self.pidss.removeAll()
        self.images.removeAll()
        let url = "https://www.xingzhu.club/XzTest/products/getAllProducts"
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            //print("jsonRequest:\(response.result)")
            if let data = response.result.value {
                let json = JSON(data)
                //print("结果:\(json)")
                var code: Int = json["code"].int!
                //print("错误:\(code)")
                var message:String = json["message"].string!
                //print("提示:\(message)")
                let provinces = json["data"]
                for i in 0..<provinces.count{
                    let productId: Int = provinces[i]["productId"].int ?? 0
                    self.pidss += [productId]
                    
                    let productTitle: String = provinces[i]["productTitle"].string ?? ""
                    self.titles += [productTitle]
    
                    
                    //                    var protitleheight = self.heightForView(text: productDes, font: UIFont.systemFont(ofSize: 14), width:  CGFloat(self.widths))
                    //                    self.heights += [Int(protitleheight)]
                    
                    let productPhoto: String = provinces[i]["productPhoto"].string ?? ""
                    let url = URL(string:productPhoto)
                    let data = try! Data(contentsOf: url!)
                    let smallImage = UIImage(data: data)
                    
                    self.images += [smallImage]
                }
                if(provinces.count>=3){
                    self.l_bt1?.text = self.titles[0]
                    self.l_bt2?.text = self.titles[1]
                    self.l_bt3?.text = self.titles[2]
                    self.iv_tj1?.image = self.images[0]
                    self.iv_tj2?.image = self.images[1]
                    self.iv_tj3?.image = self.images[2]
                }
                else if(provinces.count == 2){
                    self.l_bt1?.text = self.titles[0]
                    self.l_bt2?.text = self.titles[1]
                    self.iv_tj1?.image = self.images[0]
                    self.iv_tj2?.image = self.images[1]
                    self.v_tj3?.isHidden = true
                }
                else if(provinces.count == 1){
                    self.l_bt1?.text = self.titles[0]
                    self.iv_tj1?.image = self.images[0]
                    self.v_tj2?.isHidden = true
                    self.v_tj3?.isHidden = true
                }
                else if(provinces.count < 1){
                    self.v_tj1?.isHidden = true
                    self.v_tj2?.isHidden = true
                    self.v_tj3?.isHidden = true
                }
            }
        }
    }
    @objc func getAllApps()  {
        self.atitles.removeAll()
        self.crawlerName.removeAll()
        self.iskeywords.removeAll()
        self.zappc = 0
        let now = Date()
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var savetime:String = "\(dformatter.string(from: now))"
        
        var userid:Int = UserDefaults.standard.object(forKey: "userId") as! Int
        let url = "https://www.xingzhu.club/XzTest/apps/getAllApps"
        let paras = ["userId":userid]
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
                    let productTitle: String = provinces[i]["productTitle"].string ?? ""
                    let pParams: String = provinces[i]["productParams"].string ?? ""
                    if pParams.contains("keyword") {
                        self.iskey = 1
                    }else{
                        self.iskey = 0
                    }
                    let cName: String = provinces[i]["crawlerName"].string ?? ""
                    let apaystatus: Int = provinces[i]["appPayStatus"].int ?? 0
                    
                    var apStatus = ""
                    if (apaystatus == 2){
                        self.zappc += 1
                        apStatus = "已支付"
                        self.crawlerName += [cName]
                        self.atitles += [productTitle]
                        self.iskeywords += [self.iskey]
                    }
                }
                print("爬虫名有\(self.crawlerName)")
                print("关键字有\(self.iskeywords)")
                print("标题有\(self.atitles)")
                if(self.zappc>=3){
                    self.v_jq1?.setImage(UIImage(named: ""), for: .normal)
                    self.v_jq1?.setTitle(self.atitles[0], for: .normal)
                    self.v_jq2?.setTitle(self.atitles[1], for: .normal)
                    self.v_jq3?.setTitle(self.atitles[2], for: .normal)
                    self.v_jq2?.isHidden = false
                    self.v_jq3?.isHidden = false
                }
                if(self.zappc == 2){
                    self.v_jq1?.setImage(UIImage(named: ""), for: .normal)
                    self.v_jq1?.setTitle(self.atitles[0], for: .normal)
                    self.v_jq2?.setTitle(self.atitles[1], for: .normal)
                    self.v_jq3?.isHidden = true
                    self.v_jq2?.isHidden = false
                }
                if(self.zappc == 1){
                    self.v_jq1?.setImage(UIImage(named: ""), for: .normal)
                    self.v_jq1?.setTitle(self.atitles[0], for: .normal)
                    self.v_jq2?.isHidden = true
                    self.v_jq3?.isHidden = true
                }
                if(self.zappc == 0){
                    self.v_jq1?.setTitle("", for: .normal)
                    self.v_jq1?.setImage(UIImage(named: "addapp"), for: .normal)
                    self.v_jq2?.isHidden = true
                    self.v_jq3?.isHidden = true
                }
                self.v_jq1?.isEnabled = true
                self.v_jq2?.isEnabled = true
                self.v_jq3?.isEnabled = true
            }
        }
    }
    @objc func Operactions(subButton: UIButton) {
        var tourl:String = showurl[subButton.tag]
        var showname:String = showtitle[subButton.tag]
        print("跳转到\(tourl)")
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: ToWebViewController())))
            as! ToWebViewController
        controller.theurl = tourl
        controller.thetitle = showname
//        let transition = CATransition()
//        transition.duration = 0.6
//        transition.type = CATransitionType.reveal
//        transition.subtype = CATransitionSubtype.fromRight
//        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
//        view.window!.layer.add(transition, forKey: kCATransition)
        controller.hidesBottomBarWhenPushed = true
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    @objc func syjjAction() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: UsetutorialViewController())))
            as! UsetutorialViewController
        controller.hidesBottomBarWhenPushed = true
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    @objc func todeatil0() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: APImessViewController())))
            as! APImessViewController
        controller.pid = self.pidss[0]
        controller.datatitles = self.titles[0]
        controller.hidesBottomBarWhenPushed = true
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        self.hidesBottomBarWhenPushed = false
        
    }
    @objc func todeatil1() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: APImessViewController())))
                    as! APImessViewController
        controller.pid = self.pidss[1]
        controller.datatitles = self.titles[1]
        controller.hidesBottomBarWhenPushed = true
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    @objc func todeatil2() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: APImessViewController())))
                    as! APImessViewController
        controller.pid = self.pidss[3]
        controller.datatitles = self.titles[3]
        controller.hidesBottomBarWhenPushed = true
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    @objc func lookAction(){
        let tabbarVC : MainViewController = self.tabBarController as! MainViewController
        tabbarVC.selectedIndex = 1
    }
    @objc func looksAction(){
        let tabbarVC : MainViewController = self.tabBarController as! MainViewController
        tabbarVC.selectedIndex = 2
    }
    @objc func toapp0() {
        if(self.zappc == 0){
            lookAction()
        }else{
            let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: OperateViewController())))
                as! OperateViewController
            controller.crawlername = crawlerName[0]
            controller.iskey = iskeywords[0]
            controller.Ntitle = atitles[0]
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
            self.hidesBottomBarWhenPushed = false
        }
        
    }
    @objc func toapp1() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: OperateViewController())))
            as! OperateViewController
        controller.crawlername = crawlerName[1]
        controller.iskey = iskeywords[1]
        controller.Ntitle = atitles[1]
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    @objc func toapp2() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: OperateViewController())))
            as! OperateViewController
        controller.crawlername = crawlerName[2]
        controller.iskey = iskeywords[2]
        controller.Ntitle = atitles[2]
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
}
