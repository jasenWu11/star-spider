//
//  MyordercloseTableViewController.swift
//  XZ
//
//  Created by wjz on 2019/3/19.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit
import UIKit
import Alamofire
import MJRefresh
class MyordercloseTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var titles:[String] = []
    var pstatus:[String] = []
    var ctimes:[String] = []
    var etimes:[String] = []
    var oidss:[Int] = []
    var prices:[Double] = []
    var pidss:[Int] = []
    var optimes:[String] = []
    var ostatus:[String] = []
    var apybutton:[String] = []
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    let TAG_CELL_LABEL = 1
    let TAG_CELL_BUTTON = 2
    var pids:Int = 0
    var tableView:UITableView?
    let header = MJRefreshNormalHeader()
    var userid:Int = 0
    var root : MyorderpagViewController?
    // 底部加载
    let footer = MJRefreshAutoNormalFooter()
    var indexs:Int = 0
    var maxcount:Int = 10
    var chongzhi:Int = 0
    var count:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        header.lastUpdatedTimeLabel.isHidden = true
        header.stateLabel.isHidden = true
        userid = UserDefaults.standard.object(forKey: "userId") as! Int
        //refreshItemData()
        let theheight = CGFloat((root?.quitheight)!)
        //创建表视图
        self.tableView = UITableView(frame: CGRect(x:0, y:44, width:screenWidth, height: screenHeight-50-44-theheight), style:.plain)
        //self.tableView = UITableView(frame: self.view.frame, style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        tableView?.separatorStyle = .none
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "ShopCell")
        view.addSubview(self.tableView!)
        header.setRefreshingTarget(self, refreshingAction: #selector(Refresh))
        self.tableView!.mj_header = header
        Refresh()
        //上刷新相关设置
        footer.setRefreshingTarget(self, refreshingAction: #selector(MyordercloseTableViewController.footerLoad))
        //是否自动加载（默认为true，即表格滑到底部就自动加载）
        footer.isAutomaticallyRefresh = false
        self.tableView!.mj_footer = footer
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let identifier = "MyappclosepayCell"
            let cell = MyordercloseTableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier) as! MyordercloseTableViewCell
            cell.root = self
            cell.tv_title?.text = titles[indexPath.row]
            cell.tv_etime?.text = etimes[indexPath.row]
            cell.tv_pstate?.text = pstatus[indexPath.row]
            cell.tv_oid?.text = "\(oidss[indexPath.row])"
            cell.tv_ctime?.text = ctimes[indexPath.row]
            cell.tv_price?.text = "\(prices[indexPath.row])"
            cell.tv_ptime?.text = optimes[indexPath.row]
            cell.bt_oper!.tag = indexPath.row
            cell.bt_dele!.tag = indexPath.row
            cell.bt_oper!.setTitle(apybutton[indexPath.row], for: UIControl.State.normal)
            return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        print(indexPath.row)
    }
    func headerres(){
        header.beginRefreshing()
    }
    @objc func Refresh(){
        self.oidss.removeAll()
        self.titles.removeAll()
        self.etimes.removeAll()
        self.ctimes.removeAll()
        self.prices.removeAll()
        self.pstatus.removeAll()
        self.pidss.removeAll()
        self.optimes.removeAll()
        self.ostatus.removeAll()
        self.apybutton.removeAll()
        getMyOrders(index: 0)
        if (chongzhi == 1) {
            self.tableView!.mj_footer.resetNoMoreData()
        }
    }
    @objc func getMyOrders(index:Int)  {
        let url = "https://www.xingzhu.club/XzTest/orders/getMyOrders"
        let paras = ["userId":self.userid]
        print("用户ID\(self.userid)")
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
                else{
                    var indexss = index
                    for i in 0..<100{
                        let orderId: Int = provinces[indexss]["orderId"].int ?? 0
                        
                        let productId: Int = provinces[indexss]["productId"].int ?? 0
                        
                        let productTitle: String = provinces[indexss]["productTitle"].string ?? ""
                        
                        
                        let orderEndTime: String = provinces[indexss]["orderEndTime"].string ?? ""
                        
                        
                        let orderCreateTime: String = provinces[indexss]["orderCreateTime"].string ?? ""
                        
                        
                        let orderPayTime: String = provinces[indexss]["orderPayTime"].string ?? ""
                        
                        
                        let productPriceMonth: Double = provinces[indexss]["productPriceMonth"].double ?? 0
                        
                        
                        let orderPaymentStatus: Int = provinces[indexss]["orderPaymentStatus"].int ?? 0
                        
                        let orderStatus: Int = provinces[indexss]["orderStatus"].int ?? 0
                        var oPStatus = ""
                        if (orderPaymentStatus == 3){
                            self.count += 3
                            oPStatus = "已关闭"
                            self.oidss += [orderId]
                            self.pidss += [productId]
                            self.titles += [productTitle]
                            self.etimes += [orderEndTime]
                            self.ctimes += [orderCreateTime]
                            self.optimes += [orderPayTime]
                            self.prices += [productPriceMonth]
                            self.apybutton += ["已关闭"]
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
                            self.pstatus += [oPStatus]
                        }
                        
                        indexss += 1
                        if(self.count == 10){
                            break
                        }
                    }
                    self.indexs = indexss
                    self.count = 0
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
    //底部上拉加载
    @objc func footerLoad(){
        print("上拉加载.")
        chongzhi = 1
        //生成并添加数据
        getMyOrders(index: indexs)
        
    }
}
