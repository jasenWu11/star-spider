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
class Shop1TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    var titles:[String] = []
    var contents:[String] = []
    var images:[UIImage?] = []
    var pricem:[Double] = []
    var prices:[Double] = []
    var pricey:[Double] = []
    var pidss:[Int] = []
    var heights:[CGFloat] = []
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
    var searchBars:UISearchBar?
    var searchtext:String = ""
    var dzView : UIView?
    var tv_dingzhi : UILabel?
    var bt_dz : UIButton?
    var widths:Int = 0
    var thetab:Int = 1
    // 底部加载
    let footer = MJRefreshAutoNormalFooter()
    var indexs:Int = 0
    var maxcount:Int = 10
    var chongzhi:Int = 0
    override func loadView() {
        super.loadView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //关闭导航栏半透明效果
        self.navigationController?.navigationBar.isTranslucent = false
        //隐藏时间
        //下拉刷新
        header.lastUpdatedTimeLabel.isHidden = false
        header.stateLabel.isHidden = false
        //refreshItemData()
        let theheight = CGFloat((root?.quitheight)!)
        //创建表视图
        self.tableView = UITableView(frame: CGRect(x:0, y:0, width:self.screenWidth, height: screenHeight-50-theheight), style:.plain)
        //self.tableView = UITableView(frame: self.view.frame, style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        tableView?.separatorStyle = .none
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "ShopCell")
        self.view.addSubview(self.tableView!)
        header.setRefreshingTarget(self, refreshingAction: #selector(Refresh))
        self.tableView!.mj_header = header
        //上刷新相关设置
        footer.setRefreshingTarget(self, refreshingAction: #selector(Shop1TableViewController.footerLoad))
        //是否自动加载（默认为true，即表格滑到底部就自动加载）
        footer.isAutomaticallyRefresh = false
        self.tableView!.mj_footer = footer
        //手动调用刷新效果
        header.beginRefreshing()
        //        titles = ["微博热搜版","爱奇艺点击率最高电影"]
        //        contents = root?.content1 ?? ["获取微博热搜版，研究大众兴趣","获取爱奇艺点击率最高电影,可以方便找到票房较高的电影，筛选避过烂片"]
        //        images = root?.image1 ?? ["weibo","aiqiyi"]
        //        pricem = root?.pricem1 ?? [81.04,130.5]
        //        pidss = root?.pid1 ?? [2238241,2238245]
        print("数据是\(titles)")
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("市场前台显示")
        
        // The rest of your code.
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
            let cell = Shop1TableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier) as! Shop1TableViewCell
            cell.layer.shouldRasterize = true
            cell.layer.rasterizationScale = UIScreen.main.scale
            cell.root = self
            cell.titleLabel?.text = titles[indexPath.row]
            cell.iconImage?.image = images[indexPath.row]
            cell.subTitleLabel?.text = contents[indexPath.row]
            widths = Int((cell.subTitleLabel?.frame.size.width)!)
            var theheight = cell.heightForView(text: "\(cell.subTitleLabel?.text)", font: UIFont.systemFont(ofSize: 14), width:  CGFloat(widths))
            heights += [theheight]
            cell.subTitleLabel?.frame.size.height = heights[indexPath.row]
            cell.pirceLabel?.text = "¥\(pricem[indexPath.row])"
            cell.subButton!.tag = indexPath.row
            cell.shopcellView!.tag = indexPath.row
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
    @objc func Refresh(){
        self.titles.removeAll()
        self.pidss.removeAll()
        self.contents.removeAll()
        self.images.removeAll()
        self.pricem.removeAll()
        self.prices.removeAll()
        self.pricey.removeAll()
        self.heights.removeAll()
        getAllProducts(index: 0)
        if (chongzhi == 1) {
            self.tableView!.mj_footer.resetNoMoreData()
        }
    }
    @objc func getAllProducts(index:Int)  {
        searchBars?.text = ""
        let url = "https://www.xingzhu.club/XzTest/products/getProductByTag"
        let paras = ["productTag":thetab]
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
                var jndex = index+10
                self.maxcount = provinces.count
                if (jndex>=provinces.count){
                    jndex = provinces.count
                    self.tableView!.mj_footer.endRefreshingWithNoMoreData()
                }
                for i in index..<jndex{
                    let productId: Int = provinces[i]["productId"].int ?? 0
                    self.pidss += [productId]
                    
                    let productTitle: String = provinces[i]["productTitle"].string ?? ""
                    self.titles += [productTitle]
                    
                    let productDes: String = provinces[i]["productDes"].string ?? ""
                    self.contents += [productDes]
                    
                    //                    var protitleheight = self.heightForView(text: productDes, font: UIFont.systemFont(ofSize: 14), width:  CGFloat(self.widths))
                    //                    self.heights += [Int(protitleheight)]
                    
                    let productPhoto: String = provinces[i]["productPhoto"].string ?? ""
                    let url = URL(string:productPhoto)
                    let data = try! Data(contentsOf: url!)
                    let smallImage = UIImage(data: data)
                    
                    self.images += [smallImage]
                    
                    let productpricemMonth: Double = provinces[i]["productPriceMonth"].double ?? 0
                    self.pricem += [productpricemMonth]
                    
                    let productPriceSeason: Double = provinces[i]["productPriceSeason"].double ?? 0
                    self.prices += [productPriceSeason]
                    
                    let productPriceYear: Double = provinces[i]["productPriceYear"].double ?? 0
                    self.pricey += [productPriceYear]
                }
                 self.indexs = jndex
            }
           self.reloadData()
        }
    }
    func reloadData(){
        //重现加载表格数据
        self.tableView!.reloadData()
        //结束刷新
        self.tableView!.mj_header.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @objc func cumaBtnClick(Button: UIButton) {
        
        root?.custom()
    }
    //底部上拉加载
    @objc func footerLoad(){
        //print("上拉加载.")
        chongzhi = 1
        //生成并添加数据
        getAllProducts(index: indexs)
        
    }
}
