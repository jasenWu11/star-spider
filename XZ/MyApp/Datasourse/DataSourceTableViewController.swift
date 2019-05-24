//
//  DataSourceTableViewController.swift
//  XZ
//
//  Created by wjz on 2019/2/28.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
class DataSourceTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    var dsns:[String] = []
    var clns:[String] = []
    var images:[String] = []
    var dsnu:[Int] = []
    var dsss:[String] = []
    var dsct:[String] = []
    var dsut:[String] = []
    var pidss:[Int] = []
    var tp_sjy:[String] = []
    var type:Int = 0
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    let TAG_CELL_LABEL = 1
    let TAG_CELL_BUTTON = 2
    var pids:Int = 0
    var tableView:UITableView?
    var root : MyApppagViewController?
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    var searchBars:UISearchBar?
    var searchtext:String = ""
    // 底部加载
    let footer = MJRefreshAutoNormalFooter()
    var indexs:Int = 0
    var maxcount:Int = 10
    var chongzhi:Int = 0
    var issear:Int = 0
    var dzView : UIView?
    var tv_dingzhi : UILabel?
    var bt_dz : UIButton?
    override func loadView() {
        super.loadView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
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
        tp_sjy = ["datas","sjy1","sjy2","sjy3","sjy4","sjy5","sjy6","sjy7","sjy8","sjy9","sjy10"]
        //下拉刷新
        header.lastUpdatedTimeLabel.isHidden = false
        header.stateLabel.isHidden = false
        //refreshItemData()
        let theheight = CGFloat((root?.quitheight)!)
        //创建表视图
        self.tableView = UITableView(frame: CGRect(x:0, y:44, width:self.screenWidth, height: self.screenHeight-50-44-theheight), style:.plain)
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
        footer.setRefreshingTarget(self, refreshingAction: #selector(DataSourceTableViewController.footerLoad))
        //是否自动加载（默认为true，即表格滑到底部就自动加载）
        footer.isAutomaticallyRefresh = false
        self.tableView!.mj_footer = footer
        
        //        dsns = ["微博热搜版","爱奇艺点击率最高电影"]
        //        clns = root?.content1 ?? ["获取微博热搜版，研究大众兴趣","获取爱奇艺点击率最高电影,可以方便找到票房较高的电影，筛选避过烂片"]
        //        images = root?.image1 ?? ["weibo","aiqiyi"]
        //        dsnu = root?.dsnu1 ?? [81.04,130.5]
        //        pidss = root?.pid1 ?? [2238241,2238245]
        print("数据是\(dsns)")
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("数据源显示")
        
        // The rest of your code.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dsns.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            
            let identifier = "ShopCell"
            let cell = DataSourceTableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier) as! DataSourceTableViewCell
            cell.root = self
            cell.titleLabel?.text = dsns[indexPath.row]
//            let url = URL(string:images[indexPath.row])
//            let data = try! Data(clnsOf: url!)
//            let smallImage = UIImage(data: data)
//            cell.iconImage?.image = smallImage
            cell.tv_dsct?.text = dsct[indexPath.row]
            cell.tv_dsut?.text = dsut[indexPath.row]
            cell.tv_dsnu?.text = "\(dsnu[indexPath.row])"
            cell.tv_dsss?.text = dsss[indexPath.row]
            cell.subButton!.tag = pidss[indexPath.row]
            cell.subButton!.tag = indexPath.row
            cell.datasourceView!.tag = indexPath.row
            cell.tag = pidss[indexPath.row]
            cell.iconImage?.image = UIImage(named:tp_sjy[indexPath.row])
            pids = pidss[indexPath.row]
            return cell
    }
    func headerres(){
        header.beginRefreshing()
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
        self.dsns.removeAll()
        self.pidss.removeAll()
        self.clns.removeAll()
        self.images.removeAll()
        self.dsnu.removeAll()
        getAllDatasource(index:0)
        if (chongzhi == 1) {
            self.tableView!.mj_footer.resetNoMoreData()
        }
    }
    @objc func getAllDatasource(index:Int)  {
        issear = 0
        searchBars?.text = ""
        let url = "https://www.xingzhu.club/XzTest/datasource/getAllDataSource"
        var userid:Int = UserDefaults.standard.object(forKey: "userId") as! Int
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
                var jndex = index+10
                self.maxcount = provinces.count
                if (jndex>=provinces.count){
                    jndex = provinces.count
                    self.tableView!.mj_footer.endRefreshingWithNoMoreData()
                }
                for i in index..<jndex{
                    let productId: Int = provinces[i]["productId"].int ?? 0
                    self.pidss += [productId]
                    
                    let dataSourceName: String = provinces[i]["dataSourceName"].string ?? ""
                    self.dsns += [dataSourceName]
                    
                    let crawlerName: String = provinces[i]["crawlerName"].string ?? ""
                    self.clns += [crawlerName]
                    
                    let dataSourceCreateTime: String = provinces[i]["dataSourceCreateTime"].string ?? ""
                    self.dsct += [dataSourceCreateTime]
                    
                    let dataSourceUpdateTime: String = provinces[i]["dataSourceUpdateTime"].string ?? ""
                    self.dsut += [dataSourceUpdateTime]
                    
                    let productPhoto: String = provinces[i]["productPhoto"].string ?? ""
                    self.images += [productPhoto]
                    
                    let dataSourceNumbers: Int = provinces[i]["dataSourceNumbers"].int ?? 0
                    self.dsnu += [dataSourceNumbers]
                    
                    let dataSourceSize: Int = provinces[i]["dataSourceSize"].int ?? 0
                    var datassring:String = ""
                    if (dataSourceSize>1000000000){
                        var datass:Int = dataSourceSize/1000000000
                        datassring = "\(datass)GB"
                    }
                    else if (dataSourceSize<1000000000&&dataSourceSize>1000000){
                        var datass:Int = dataSourceSize/1000000
                        datassring = "\(datass)MB"
                    }
                    else if (dataSourceSize<1000000&&dataSourceSize>1000){
                        var datass:Int = dataSourceSize/1000
                        datassring = "\(datass)KB"
                    }
                    else if (dataSourceSize<1000){
                        var datass:Int = dataSourceSize
                        datassring = "\(datass)B"
                    }
                    self.dsss += [datassring]
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
    //初始化数据
    func refreshItemData() {
        dsns.append("微博热搜版")
        clns.append("获取微博热搜版，研究大众兴趣")
        images.append("https://xz-1256883494.cos.ap-guangzhou.myqcloud.com/products_img/weibo.png")
        dsnu.append(81)
        pidss.append(2238241)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // 搜索触发事件，点击虚拟键盘上的search按钮时触发此方法
    func searchBarSearchButtonClicked(_ searchBars: UISearchBar) {
        searchBars.resignFirstResponder()
        let searchtext:String = searchBars.text!
        print(searchtext)
    }
    override func touchesBegan(_ touches:Set<UITouch>, with event:UIEvent?) {
        
        searchBars?.resignFirstResponder()
        
    }
    func searchBar(_ searchBar:UISearchBar, textDidChange searchText:String) {
        
        //searchBars?.resignFirstResponder()
        searchtext = searchBars?.text! ?? ""
        print(searchtext)
        self.dsns.removeAll()
        self.pidss.removeAll()
        self.clns.removeAll()
        self.images.removeAll()
        self.dsnu.removeAll()
        getDatasource(index: 0)
        if (searchtext == "") {
            Refresh()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar:UISearchBar) {
        print("cancel")
        searchBars?.text = ""
        Refresh()
    }
    @objc func getDatasource(index:Int)  {
        issear = 1
        let url = "https://www.xingzhu.club/XzTest/datasource/getDataSourceByContent"
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        var userid:Int = UserDefaults.standard.object(forKey: "userId") as! Int
        let paras = ["userId":userid,"content":self.searchtext] as [String : Any]
        print("搜索\(self.searchtext)")
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
                    
                    let dataSourceName: String = provinces[i]["dataSourceName"].string ?? ""
                    self.dsns += [dataSourceName]
                    
                    let crawlerName: String = provinces[i]["crawlerName"].string ?? ""
                    self.clns += [crawlerName]
                    
                    let dataSourceCreateTime: String = provinces[i]["dataSourceCreateTime"].string ?? ""
                    self.dsct += [dataSourceCreateTime]
                    
                    let dataSourceUpdateTime: String = provinces[i]["dataSourceUpdateTime"].string ?? ""
                    self.dsut += [dataSourceUpdateTime]
                    
                    let productPhoto: String = provinces[i]["productPhoto"].string ?? ""
                    self.images += [productPhoto]
                    
                    let dataSourceNumbers: Int = provinces[i]["dataSourceNumbers"].int ?? 0
                    self.dsnu += [dataSourceNumbers]
                    
                    let dataSourceSize: Int = provinces[i]["dataSourceSize"].int ?? 0
                    var datassring:String = ""
                    if (dataSourceSize>1000000000){
                        var datass:Int = dataSourceSize/1000000000
                        datassring = "\(datass)GB"
                    }
                    else if (dataSourceSize<1000000000&&dataSourceSize>1000000){
                        var datass:Int = dataSourceSize/1000000
                        datassring = "\(datass)MB"
                    }
                    else if (dataSourceSize<1000000&&dataSourceSize>1000){
                        var datass:Int = dataSourceSize/1000
                        datassring = "\(datass)KB"
                    }
                    else if (dataSourceSize<1000){
                        var datass:Int = dataSourceSize
                        datassring = "\(datass)B"
                    }
                    self.dsss += [datassring]
                }
                self.indexs = jndex
            }
            self.reloadData()
        }
    }
    @objc func cumaBtnClick(Button: UIButton) {
        root?.performSegue(withIdentifier: "custommade", sender: "")
    }
    //底部上拉加载
    @objc func footerLoad(){
        //print("上拉加载.")
        chongzhi = 1
        //生成并添加数据
        if(issear == 0){
            getDatasource(index: indexs)
        }
        else{
            getAllDatasource(index: indexs)
        }
        
    }
}
