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
<<<<<<< HEAD
class MyAppTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
=======
class MyAppTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
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
<<<<<<< HEAD
    var endtime:[String] = []
    var xufeiPayStatus:[String] = []
=======
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
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
<<<<<<< HEAD
    var searchBars:UISearchBar?
    var searchtext:String = ""
    // 底部加载
    let footer = MJRefreshAutoNormalFooter()
    var indexs:Int = 0
    var maxcount:Int = 10
    var chongzhi:Int = 0
    var issear:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        //关闭导航栏半透明效果
        self.navigationController?.navigationBar.isTranslucent = false
        self.tableView?.separatorStyle = .none
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
       
        //下拉刷新
        header.lastUpdatedTimeLabel.isHidden = false
        header.stateLabel.isHidden = false
        let theheight = CGFloat((root?.quitheight)!)
        //创建表视图
        self.tableView = UITableView(frame: CGRect(x:0, y:44, width:screenWidth, height: screenHeight-50-44-theheight), style:.plain)
        //self.tableView = UITableView(frame: self.view.frame, style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        tableView?.separatorStyle = .none
        //上刷新相关设置
        footer.setRefreshingTarget(self, refreshingAction: #selector(MyAppTableViewController.footerLoad))
        //是否自动加载（默认为true，即表格滑到底部就自动加载）
        footer.isAutomaticallyRefresh = false
        self.tableView!.mj_footer = footer
        //下拉刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(Refresh))
        self.tableView!.mj_header = header
=======
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
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "ShopCell")
        view.addSubview(self.tableView!)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("我的应用前台显示")
<<<<<<< HEAD
        //手动调用刷新效果
        Refresh()
=======
        header.setRefreshingTarget(self, refreshingAction: #selector(getAllApps))
        self.tableView!.mj_header = header
        getAllApps()
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
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
<<<<<<< HEAD
            cell.tv_etime?.text = appPayStatus[indexPath.row]
            cell.tv_states?.setTitle(xufeiPayStatus[indexPath.row], for: .normal)
            cell.tv_states?.tag = indexPath.row
            cell.v_oper!.tag = indexPath.row
=======
            cell.tv_etime?.text = appStatus[indexPath.row]
            cell.tv_states?.text = appPayStatus[indexPath.row]
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
            cell.bt_oper!.tag = indexPath.row
            //cell.bt_dele!.tag = pidss[indexPath.row]
            return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        print(indexPath.row)
    }
<<<<<<< HEAD
    func headerres(){
        header.beginRefreshing()
    }
    @objc func Refresh(){
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
        self.endtime.removeAll()
        self.xufeiPayStatus.removeAll()
        getAllApps(index: 0)
        if (chongzhi == 1) {
            self.tableView!.mj_footer.resetNoMoreData()
        }
    }
    @objc func getAllApps(index:Int)  {
        issear = 0
        searchBars?.text = ""
        let now = Date()
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var savetime:String = "\(dformatter.string(from: now))"
=======
    @objc func getAllApps()  {
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
        
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
<<<<<<< HEAD
                var jndex = index+10
                self.maxcount = provinces.count
                if (jndex>=provinces.count){
                    jndex = provinces.count
                    self.tableView!.mj_footer.endRefreshingWithNoMoreData()
                }
                for i in index..<jndex{
=======
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
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
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
                    
<<<<<<< HEAD
                    let eTime: String = provinces[i]["appEndTime"].string ?? ""
                    self.endtime += [eTime]
                    
=======
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
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
<<<<<<< HEAD
                        
                        if eTime.compare(savetime) == .orderedAscending
                        {
                            print("已过期")
                            apStatus = "已过期"
                        }
                        else if eTime.compare(savetime) == .orderedDescending
                        {
                            print("未过期")
                            apStatus = "已支付"
                        }
                    }
                    self.appPayStatus += [apStatus]
                    
                    var xfStatus = ""
                    if (apaystatus == 1){
                        xfStatus = "购买"
                    }
                    else if (apaystatus == 2){
                        
                        if eTime.compare(savetime) == .orderedAscending
                        {
                            print("续费")
                            xfStatus = "续费"
                        }
                        else if eTime.compare(savetime) == .orderedDescending
                        {
                            print("续费")
                            xfStatus = "续费"
                        }
                    }
                    self.xufeiPayStatus += [xfStatus]
                    
=======
                        apStatus = "已支付"
                    }
                    self.appPayStatus += [apStatus]
                    
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
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
<<<<<<< HEAD
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
    func searchBar(_ searchBar:UISearchBar, textDidChange searchText:String) {
        
        //searchBars?.resignFirstResponder()
        searchtext = searchBars?.text! ?? ""
        print(searchtext)
        //print("searchtext")
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
        self.endtime.removeAll()
        self.xufeiPayStatus.removeAll()
        getApps(index: 0)
        if (searchtext == "") {
            Refresh()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar:UISearchBar) {
        print("cancel")
        searchBars?.text = ""
        Refresh()
    }
    @objc func getApps(index:Int) {
        issear = 1
        let now = Date()
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var savetime:String = "\(dformatter.string(from: now))"
        
        var userid:Int = UserDefaults.standard.object(forKey: "userId") as! Int
        let url = "https://www.xingzhu.club/XzTest/apps/getAppByContent"
        let paras = ["userId":userid,"content":self.searchtext] as [String : Any]
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
                    
                    let eTime: String = provinces[i]["appEndTime"].string ?? ""
                    self.endtime += [eTime]
                    
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
                        
                        if eTime.compare(savetime) == .orderedAscending
                        {
                            print("已过期")
                            apStatus = "已过期"
                        }
                        else if eTime.compare(savetime) == .orderedDescending
                        {
                            print("未过期")
                            apStatus = "已支付"
                        }
                    }
                    self.appPayStatus += [apStatus]
                    
                    var xfStatus = ""
                    if (apaystatus == 1){
                        xfStatus = "购买"
                    }
                    else if (apaystatus == 2){
                        
                        if eTime.compare(savetime) == .orderedAscending
                        {
                            print("续费")
                            xfStatus = "续费"
                        }
                        else if eTime.compare(savetime) == .orderedDescending
                        {
                            print("续费")
                            xfStatus = "续费"
                        }
                    }
                    self.xufeiPayStatus += [xfStatus]
                    
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
                self.indexs = jndex
            }
             self.reloadData()
        }
    }
    //底部上拉加载
    @objc func footerLoad(){
        //print("上拉加载.")
        chongzhi = 1
        //生成并添加数据
        if(issear == 0){
            getApps(index: indexs)
        }
        else{
            getAllApps(index: indexs)
=======
            }
             print("是否需要keyword\(self.iskeywords)")
            self.tableView!.reloadData()
            //结束刷新
            self.tableView!.mj_header.endRefreshing()
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
        }
    }
}
