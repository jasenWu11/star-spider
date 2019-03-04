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
class MyorderTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var titles:[String] = []
    var pstatus:[String] = []
    var ctimes:[String] = []
    var etimes:[String] = []
    var oidss:[Int] = []
    var prices:[Double] = []
    var pidss:[Int] = []
    var optimes:[String] = []
    var ostatus:[String] = []
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    let TAG_CELL_LABEL = 1
    let TAG_CELL_BUTTON = 2
    var pids:Int = 0
    var tableView:UITableView?
    var root : MyApppagViewController?
    let header = MJRefreshNormalHeader()
    var userid:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        header.lastUpdatedTimeLabel.isHidden = true
        header.stateLabel.isHidden = true
        userid = UserDefaults.standard.object(forKey: "userId") as! Int
        //refreshItemData()
        //创建表视图
        self.tableView = UITableView(frame: CGRect(x:0, y:120, width:screenWidth, height: screenHeight-123), style:.plain)
        //self.tableView = UITableView(frame: self.view.frame, style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "ShopCell")
        view.addSubview(self.tableView!)
        header.setRefreshingTarget(self, refreshingAction: #selector(getAllProducts))
        self.tableView!.mj_header = header
        getAllProducts()

    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let identifier = "MyappCell"
            let cell = MyorderTableViewcell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier) as! MyorderTableViewcell
            cell.root = self
            cell.tv_title?.text = titles[indexPath.row]
            cell.tv_etime?.text = etimes[indexPath.row]
            cell.tv_pstate?.text = pstatus[indexPath.row]
            cell.tv_oid?.text = "\(oidss[indexPath.row])"
            cell.tv_ctime?.text = ctimes[indexPath.row]
            cell.tv_price?.text = "\(prices[indexPath.row])"
            cell.tv_ptime?.text = optimes[indexPath.row]
            cell.bt_oper!.tag = indexPath.row
            cell.bt_dele!.tag = oidss[indexPath.row]
            return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        print(indexPath.row)
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func getAllProducts()  {
        let url = "https://www.xingzhu.club/XzTest/orders/getMyOrders"
        let paras = ["userId":self.userid]
        print("用户ID\(self.userid)")
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("jsonRequest:\(response.result)")
            self.oidss.removeAll()
            self.titles.removeAll()
            self.etimes.removeAll()
            self.ctimes.removeAll()
            self.prices.removeAll()
            self.pstatus.removeAll()
            self.pidss.removeAll()
            self.optimes.removeAll()
            self.ostatus.removeAll()
            if let data = response.result.value {
                let json = JSON(data)
                print("结果:\(json)")
                var code: Int = json["code"].int!
                print("错误:\(code)")
                var message:String = json["message"].string!
                print("提示:\(message)")
                let provinces = json["data"]
                for i in 0..<provinces.count{
                    let orderId: Int = provinces[i]["orderId"].int ?? 0
                    self.oidss += [orderId]
                    let productId: Int = provinces[i]["productId"].int ?? 0
                    self.pidss += [productId]
                    let productTitle: String = provinces[i]["productTitle"].string ?? ""
                    self.titles += [productTitle]
                    
                    let orderEndTime: String = provinces[i]["orderEndTime"].string ?? ""
                    self.etimes += [orderEndTime]
                    
                    let orderCreateTime: String = provinces[i]["orderCreateTime"].string ?? ""
                    self.ctimes += [orderCreateTime]
                    
                    let orderPayTime: String = provinces[i]["orderPayTime"].string ?? ""
                    self.optimes += [orderPayTime]
                    
                    let productPriceMonth: Double = provinces[i]["productPriceMonth"].double ?? 0
                    self.prices += [productPriceMonth]
                    
                    let orderPaymentStatus: Int = provinces[i]["orderPaymentStatus"].int ?? 0
                    
                    var oPStatus = ""
                    if (orderPaymentStatus == 1){
                        oPStatus = "未支付"
                    }
                    else if (orderPaymentStatus == 2){
                        oPStatus = "已支付"
                    }
                    else if (orderPaymentStatus == 3){
                        oPStatus = "已关闭"
                    }
                    self.pstatus += [oPStatus]
                    
                    let orderStatus: Int = provinces[i]["orderStatus"].int ?? 0
                    
                    var oStatus = ""
                    if (orderStatus == 1){
                        oStatus = "暂停"
                    }
                    else if (orderStatus == 2){
                        oStatus = "进行中"
                    }
                    else if (orderStatus == 3){
                        oStatus = "已完成"
                    }
                    self.ostatus += [oStatus]
                }
            }
            //重现加载表格数据
            self.tableView!.reloadData()
            //结束刷新
            self.tableView!.mj_header.endRefreshing()
        }
    }
    //初始化数据
    func refreshItemData() {
        titles.append("微博热搜版")
        pstatus.append("1")
        ctimes.append("2018-10-19")
        etimes.append("2019-01-19")
        oidss.append(2238241)
        prices.append(18.8)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
