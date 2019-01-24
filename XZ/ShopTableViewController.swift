//
//  ShopTableViewController.swift
//  XZ
//
//  Created by wjz on 2019/1/9.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
class ShopTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var titles:[String] = []
    var contents:[String] = []
    var images:[String] = []
    var price:[Double] = []
    var pidss:[Int] = []
    var type:Int = 0
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    let TAG_CELL_LABEL = 1
    let TAG_CELL_BUTTON = 2
    var pids:Int = 0
    var tableView:UITableView?
    var root : ShoppagViewController?
    // 顶部刷新
    let header = MJRefreshNormalHeader()
   
    override func loadView() {
        super.loadView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //隐藏时间
        header.lastUpdatedTimeLabel.isHidden = true
       header.stateLabel.isHidden = true
        //refreshItemData()
        //创建表视图
        self.tableView = UITableView(frame: CGRect(x:0, y:5, width:self.screenWidth, height: self.screenHeight-123), style:.plain)
        //self.tableView = UITableView(frame: self.view.frame, style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "ShopCell")
        self.view.addSubview(self.tableView!)
        header.setRefreshingTarget(self, refreshingAction: #selector(getAllProducts))
        self.tableView!.mj_header = header
        getAllProducts()
//        titles = ["微博热搜版","爱奇艺点击率最高电影"]
//        contents = root?.content1 ?? ["获取微博热搜版，研究大众兴趣","获取爱奇艺点击率最高电影,可以方便找到票房较高的电影，筛选避过烂片"]
//        images = root?.image1 ?? ["weibo","aiqiyi"]
//        price = root?.price1 ?? [81.04,130.5]
//        pidss = root?.pid1 ?? [2238241,2238245]
       print("数据是\(titles)")
      
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
        
        
        let identifier = "ShopCell"
        let cell = ShopTableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier) as! ShopTableViewCell
        cell.root = self
        cell.titleLabel?.text = titles[indexPath.row]
        let url = URL(string:images[indexPath.row])
        let data = try! Data(contentsOf: url!)
        let smallImage = UIImage(data: data)
        cell.iconImage?.image = smallImage
        cell.subTitleLabel?.text = contents[indexPath.row]
        cell.pirceLabel?.text = "¥\(price[indexPath.row])"
        cell.subButton!.tag = pidss[indexPath.row]
        cell.shopcellView!.tag = pidss[indexPath.row]
        cell.tag = pidss[indexPath.row]
        pids = pidss[indexPath.row]
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        print(indexPath.row)
    }
//    在这个方法中给新页面传递参数
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print("接收")
//        if segue.identifier == "deatil"{
//            let controller = segue.destination as! APImessViewController
//            controller.pid = (sender as? Int)!
//        }
//    }
    @objc func getAllProducts()  {
        let url = "https://www.xingzhu.club/XzTest/products/getAllProducts"
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            print("jsonRequest:\(response.result)")
            self.titles = []
            self.pidss = []
            self.contents = []
            self.images = []
            self.price = []
            if let data = response.result.value {
                let json = JSON(data)
                print("结果:\(json)")
                var code: Int = json["code"].int!
                print("错误:\(code)")
                var message:String = json["message"].string!
                print("提示:\(message)")
                let provinces = json["data"]
                for i in 0..<provinces.count{
                    let productId: Int = provinces[i]["productId"].int ?? 0
                    self.pidss += [productId]

                    let productTitle: String = provinces[i]["productTitle"].string ?? ""
                    self.titles += [productTitle]

                    let productDes: String = provinces[i]["productDes"].string ?? ""
                    self.contents += [productDes]

                    let productPhoto: String = provinces[i]["productPhoto"].string ?? ""
                    self.images += [productPhoto]

                    let productPriceMonth: Double = provinces[i]["productPriceMonth"].double ?? 0
                    self.price += [productPriceMonth]
                }
            }
            print("标题是\(self.titles)")
            print("图片是\(self.images)")
            //重现加载表格数据
            self.tableView!.reloadData()
            //结束刷新
            self.tableView!.mj_header.endRefreshing()
        }
    }
    //初始化数据
    func refreshItemData() {
        titles.append("微博热搜版")
        contents.append("获取微博热搜版，研究大众兴趣")
        images.append("https://xz-1256883494.cos.ap-guangzhou.myqcloud.com/products_img/weibo.png")
        price.append(81.04)
        pidss.append(2238241)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
