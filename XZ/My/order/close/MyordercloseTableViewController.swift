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
class MyordercloseTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UISearchBarDelegate{
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
    var searchBars:UISearchBar?
    var searchtext:String = ""
    var issear:Int = 0
    var ops:Int = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        //搜索框
        searchBars = UISearchBar(frame: CGRect(x:0, y: 0, width:screenWidth, height: 44))
        searchBars?.barStyle = .black
        searchBars?.showsCancelButton = true
        searchBars?.keyboardAppearance = .default
        searchBars?.delegate = self
        let bt_cancel = searchBars?.value(forKey: "cancelButton") as! UIButton
        bt_cancel.setTitle("Cancel", for: .normal)
        bt_cancel.setTitleColor(UIColor.white,for: .normal)
        let seartext = searchBars?.value(forKey: "searchField") as! UITextField
        seartext.textColor = UIColor.white
        searchBars?.tintColor = UIColor.blue
        //光标颜色
        searchBars?.subviews[0].subviews[1].tintColor = UIColor.white
        searchBars?.keyboardType = .default
        //        searchBars?.addTarget(self, action: #selector(composeBtnClick), for: UIControl.Event.touchUpInside)
        view.addSubview(searchBars!)
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
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "ShopCell")
        tableView?.separatorStyle = .none
        view.addSubview(self.tableView!)
        header.setRefreshingTarget(self, refreshingAction: #selector(Refresh))
        self.tableView!.mj_header = header
        Refresh()
        //上刷新相关设置
        footer.setRefreshingTarget(self, refreshingAction: #selector(MyorderTableViewController.footerLoad))
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
            let identifier = "MyappCell"
            let cell = MyordercloseTableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier) as! MyordercloseTableViewCell
            cell.root = self
            cell.tv_title?.text = titles[indexPath.row]
            cell.tv_etime?.text = etimes[indexPath.row]
            cell.tv_pstate?.text = pstatus[indexPath.row]
            cell.tv_oid?.text = "\(oidss[indexPath.row])"
            cell.tv_ctime?.text = ctimes[indexPath.row]
            cell.tv_price?.text = "\(prices[indexPath.row])元"
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
    func searchBar(_ searchBar:UISearchBar, textDidChange searchText:String) {
        
        //searchBars?.resignFirstResponder()
        searchtext = searchBars?.text! ?? ""
        print(searchtext)
        //print("searchtext")
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
        gettheOrders(index: 0)
        if (searchtext == "") {
            Refresh()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar:UISearchBar) {
        print("cancel")
        searchBars?.text = ""
        Refresh()
    }
    @objc func getMyOrders(index:Int)  {
        searchBars?.text = ""
        issear = 0
        let url = "https://www.xingzhu.club/XzTest/orders/selectOrderByUidAndPayStatus"
        let paras = ["userId":self.userid,"orderPaymentStatus":self.ops]
        print("用户ID\(self.userid)")
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            //print("jsonRequest:\(response.result)")
            if let data = response.result.value {
                let json = JSON(data)
                //print("结果:\(json)")
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
                        self.apybutton += ["支付"]
                    }
                    else if (orderPaymentStatus == 2){
                        oPStatus = "已支付"
                        self.apybutton += ["已支付"]
                    }
                    else if (orderPaymentStatus == 3){
                        oPStatus = "已关闭"
                        self.apybutton += ["已关闭"]
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
                self.indexs = jndex
            }
            self.reloadData()
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
        //print("上拉加载.")
        chongzhi = 1
        //生成并添加数据
        if(issear == 0){
            getMyOrders(index: indexs)
        }
        else{
            gettheOrders(index: indexs)
        }
        //        //重现加载表格数据
        //        self.tableView!.reloadData()
        //        //结束刷新
        //        self.tableView!.mj_footer.endRefreshing()
        
    }
    func reloadData(){
        //重现加载表格数据
        self.tableView!.reloadData()
        //结束刷新
        self.tableView!.mj_header.endRefreshing()
    }
    @objc func gettheOrders(index:Int)  {
        issear = 1
        let url = "https://www.xingzhu.club/XzTest/orders/getMyOrders"
        let paras = ["userId":self.userid]
        print("用户ID\(self.userid)")
        var searfor:String = self.searchtext
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            //print("jsonRequest:\(response.result)")
            if let data = response.result.value {
                let json = JSON(data)
                //print("结果:\(json)")
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
                    let productTitle: String = provinces[i]["productTitle"].string ?? ""
                    let stringResult = productTitle.contains(searfor)
                    print("包含图吗？\(stringResult)")
                    if(stringResult == true){
                        self.titles += [productTitle]
                        
                        let orderId: Int = provinces[i]["orderId"].int ?? 0
                        self.oidss += [orderId]
                        
                        let productId: Int = provinces[i]["productId"].int ?? 0
                        self.pidss += [productId]
                        
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
                            self.apybutton += ["支付"]
                        }
                        else if (orderPaymentStatus == 2){
                            oPStatus = "已支付"
                            self.apybutton += ["已支付"]
                        }
                        else if (orderPaymentStatus == 3){
                            oPStatus = "已关闭"
                            self.apybutton += ["已关闭"]
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
                self.indexs = jndex
            }
            self.reloadData()
        }
    }
}
