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
    var showtitle:[String] = []
    var showimg:[String] = []
    var showurl:[String] = []
    var httpbefore:String = "https://fengfulai.xyz/#"
    var ppic:[String] = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1546428544571&di=aec9218dcffa1e52bd80d9bd046bd8ad&imgtype=0&src=http%3A%2F%2Fphotocdn.sohu.com%2F20150601%2Fmp17161050_1433123079696_1_th.png",
                         "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3668473071,2731513318&fm=26&gp=0.jpg",
                         "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1850075590,3068352838&fm=26&gp=0.jpg",
                         "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1546428801285&di=669cbde92e7431224a61735411e9f22f&imgtype=0&src=http%3A%2F%2Fwww.xmexpo.cn%2Fuploads%2Fallimg%2F180125%2F1Q91aG5_0.png",
                         "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1546428895544&di=edf4a9afdf17a53d702aef9fee17a639&imgtype=0&src=http%3A%2F%2Fphoto.16pic.com%2F00%2F61%2F24%2F16pic_6124483_b.jpg"]
    //图片轮播组件
    var sliderGallery : SliderGalleryController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        iv_xz?.image = UIImage(named:"logo")
        v_xzjj?.addSubview(iv_xz!)
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
        v_sjyjj?.addTarget(self, action: #selector(Operactions), for: UIControl.Event.touchUpInside)
        //图片
        iv_sjy = UIImageView(frame: CGRect(x:0, y: 0, width:(v_sjyjj?.frame.size.width)!, height: (v_sjyjj?.frame.size.height)!-30))
        iv_sjy?.layer.cornerRadius = 5.0
        iv_sjy?.layer.maskedCorners = [CACornerMask.layerMinXMinYCorner , CACornerMask.layerMaxXMinYCorner]
        iv_sjy?.layer.masksToBounds = true
        iv_sjy?.image = UIImage(named:"sjy")
        v_sjyjj?.addSubview(iv_sjy!)
        //文字
        lv_sjy = UILabel(frame: CGRect(x:0, y:(iv_sjy?.frame.size.height)!, width:(v_sjyjj?.frame.size.width)!, height: (v_sjyjj?.frame.size.height)!-(iv_sjy?.frame.size.height)!))
        lv_sjy?.font = UIFont.systemFont(ofSize: 14)
        lv_sjy?.textColor = UIColor.black
        lv_sjy?.text = "什么是数据源？"
        v_sjyjj?.addSubview(lv_sjy!)
        lv_sjy?.textAlignment=NSTextAlignment.center
        sv_home.contentSize = CGSize(width: screenWidth,
                                     height: (sliderGallery.view?.frame.size.height)!+(v_xzjj?.frame.size.height)!+(v_apijj?.frame.size.height)!+20);
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
        var ids : Int = 0
        
        if(index == 0){
            ids = 2238243
        }
        if(index == 1){
            ids = 2238242
        }
        if(index == 2){
            ids = 2238245
        }
        if(index == 3){
            ids = 2238241
        }
        if(index == 4){
            ids = 2238244
        }
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: APImessViewController())))
            as! APImessViewController
        controller.pid = ids
        self.present(controller, animated: true, completion: nil)
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
                if(message == "查询成功"){
                    let provinces = json["data"]
                    self.ppic.removeAll()
                    for i in 0..<provinces.count{
                        let advPic: String = provinces[i]["advPic"].string ?? ""
                        
                        self.ppic += [advPic]
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
                }
                
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
        self.present(controller, animated: true, completion: nil)
    }
}
