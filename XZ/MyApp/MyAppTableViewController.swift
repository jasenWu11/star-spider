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
class MyAppTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var titles:[String] = []
    var ctimes:[String] = []
    var etimes:[String] = []
    var pidss:[Int] = []
    var productParams:[String] = []
    var appId:[Int] = []
    var crawlerName:[String] = []
    var appStatus:[String] = []
    var appPayStatus:[String] = []
    var productType:[String] = []
    var iskeywords:[Int] = []
    var iskey:Int = 0
//    var states:[String] = ["未开始","已停止","已停止","暂停","未开始","正在操作","正在操作"]
//    var counts:[String] = ["0","16","30","15","0","20","18"]
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    let TAG_CELL_LABEL = 1
    let TAG_CELL_BUTTON = 2
    var pids:Int = 0
    var tableView:UITableView?
    var root : MyApppagViewController?
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.separatorStyle = .none
        //下拉刷新
        header.lastUpdatedTimeLabel.isHidden = true
        header.stateLabel.isHidden = true
        //创建表视图
        self.tableView = UITableView(frame: CGRect(x:0, y:0, width:screenWidth, height: screenHeight-123), style:.plain)
        //self.tableView = UITableView(frame: self.view.frame, style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "ShopCell")
        view.addSubview(self.tableView!)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("我的应用前台显示")
        header.setRefreshingTarget(self, refreshingAction: #selector(getAllApps))
        self.tableView!.mj_header = header
        getAllApps()
        // The rest of your code.
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let identifier = "MyappCell"
            let cell = MyAppTableViewcell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier) as! MyAppTableViewcell
            cell.root = self
            cell.tv_title?.text = titles[indexPath.row]
            cell.tv_stime?.text = ctimes[indexPath.row]
            cell.tv_etime?.text = appStatus[indexPath.row]
            cell.tv_states?.text = appPayStatus[indexPath.row]
            cell.v_oper!.tag = indexPath.row
            cell.bt_oper!.tag = indexPath.row
            //cell.bt_dele!.tag = pidss[indexPath.row]
            return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        print(indexPath.row)
    }
    @objc func getAllApps()  {
        
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
                self.titles.removeAll()
                self.ctimes.removeAll()
                self.etimes.removeAll()
                self.pidss.removeAll()
                self.productParams.removeAll()
                self.appId.removeAll()
                self.crawlerName.removeAll()
                self.appStatus.removeAll()
                self.appPayStatus.removeAll()
                self.productType.removeAll()
                self.iskeywords.removeAll()
                for i in 0..<provinces.count{
                    let appIds: Int = provinces[i]["appId"].int ?? 0
                    self.appId += [appIds]
                    
                    let productId: Int = provinces[i]["productId"].int ?? 0
                    self.pidss += [productId]
                    
                    let productTitle: String = provinces[i]["productTitle"].string ?? ""
                    self.titles += [productTitle]
                    
                    let appCTime: String = provinces[i]["appCreateTime"].string ?? ""
                    self.ctimes += [appCTime]
                   
                    let pParams: String = provinces[i]["productParams"].string ?? ""
                    self.productParams += [pParams]
                    
                    if pParams.contains("keyword") {
                        self.iskey = 1
                    }else{
                        self.iskey = 0
                    }
                    self.iskeywords += [self.iskey]
                    
                    let cName: String = provinces[i]["crawlerName"].string ?? ""
                    self.crawlerName += [cName]
                    
                    let appstatus: Int = provinces[i]["appStatus"].int ?? 0
                    
                    var aStatus = ""
                    if (appstatus == 1){
                        aStatus = "未启动"
                    }
                    else if (appstatus == 2){
                        aStatus = "运行"
                    }
                    else if (appstatus == 3){
                        aStatus = "已停止"
                    }
                    self.appStatus += [aStatus]
                    
                    let apaystatus: Int = provinces[i]["appPayStatus"].int ?? 0
                    
                    var apStatus = ""
                    if (apaystatus == 1){
                        apStatus = "未支付"
                    }
                    else if (apaystatus == 2){
                        apStatus = "已支付"
                    }
                    self.appPayStatus += [apStatus]
                    
                    let producttype: Int = provinces[i]["productType"].int ?? 0
                    
                    var ptype = ""
                    if (producttype == 1){
                        ptype = "爬虫"
                    }
                    else if (producttype == 2){
                        ptype = "数据"
                    }
                    else if (producttype == 3){
                        ptype = "API"
                    }
                    self.productType += [ptype]
                }
            }
             print("是否需要keyword\(self.iskeywords)")
            self.tableView!.reloadData()
            //结束刷新
            self.tableView!.mj_header.endRefreshing()
        }
    }
}
