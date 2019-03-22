//
//  messagereadTableViewController.swift
//  XZ
//
//  Created by wjz on 2019/3/20.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
class messagereadTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var titles:[String] = []
    var contents:[String] = []
    var midss:[Int] = []
    var omtimes:[String] = []
    var mstatus:[String] = []
    var noid:[String] = []
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    let TAG_CELL_LABEL = 1
    let TAG_CELL_BUTTON = 2
    var pids:Int = 0
    var tableView:UITableView?
    var root : messagepagViewcontroller?
    let header = MJRefreshNormalHeader()
    var userid:Int = 0
    // 底部加载
    let footer = MJRefreshAutoNormalFooter()
    var indexs:Int = 0
    var maxcount:Int = 20
    var chongzhi:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let handLeftRight = UISwipeGestureRecognizer(target: self, action: #selector(funLeftRight))
        //handLeftRight.direction = .left //支持向左
        self.view.addGestureRecognizer(handLeftRight)
        
        header.lastUpdatedTimeLabel.isHidden = true
        header.stateLabel.isHidden = true
        userid = UserDefaults.standard.object(forKey: "userId") as! Int
        //refreshItemData()
        //创建表视图
        self.tableView = UITableView(frame: CGRect(x:0, y:0, width:screenWidth, height: screenHeight-123), style:.plain)
        //self.tableView = UITableView(frame: self.view.frame, style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        tableView?.separatorStyle = .none
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "messCell")
        view.addSubview(self.tableView!)
        header.setRefreshingTarget(self, refreshingAction: #selector(Refresh))
        self.tableView!.mj_header = header
        Refresh()
        
        //上刷新相关设置
        footer.setRefreshingTarget(self, refreshingAction: #selector(messagereadTableViewController.footerLoad))
        //是否自动加载（默认为true，即表格滑到底部就自动加载）
        footer.isAutomaticallyRefresh = false
        self.tableView!.mj_footer = footer
    }
    func headerres(){
        header.beginRefreshing()
    }
    @objc func Refresh(){
        self.noid.removeAll()
        self.midss.removeAll()
        self.titles.removeAll()
        self.contents.removeAll()
        self.omtimes.removeAll()
        self.mstatus.removeAll()
        getMyNotices(index: 0)
        if (chongzhi == 1) {
            self.tableView!.mj_footer.resetNoMoreData()
        }
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let identifier = "MessagereadCell"
            let cell = messagereadTableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier) as! messagereadTableViewCell
            cell.root = self
            cell.tv_title?.text = titles[indexPath.row]
            //cell.tv_content?.text = contents[indexPath.row]
            cell.tv_states?.text = mstatus[indexPath.row]
            cell.tv_mid?.text = noid[indexPath.row]
            cell.tv_mtime?.text = omtimes[indexPath.row]
            cell.v_mess!.tag = indexPath.row
            return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        print(indexPath.row)
    }
    @objc func getMyNotices(index:Int)  {
        let url = "https://www.xingzhu.club/XzTest/notices/getMyNotices"
        let paras = ["userId":self.userid]
        print("用户ID\(self.userid)")
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("jsonRequest:\(response.result)")
            
            if let data = response.result.value {
                let json = JSON(data)
                //print("结果:\(json)")
                var code: Int = json["code"].int!
                print("错误:\(code)")
                var message:String = json["message"].string!
                print("提示:\(message)")
                let provinces = json["data"]
                var jndex = index+20
                self.maxcount = provinces.count
                print("所有的数量\(self.maxcount),现在的数量\(jndex)")
                if (jndex>=self.maxcount){
                    jndex = self.maxcount
                    self.tableView!.mj_footer.endRefreshingWithNoMoreData()
                }
                for i in index..<jndex{
                    self.noid += ["\(i+1)"]
                    
                    let noticeId: Int = provinces[i]["noticeId"].int ?? 0
                    
                    let noticeTitle: String = provinces[i]["noticeTitle"].string ?? ""
                    
                    let sendTime: String = provinces[i]["sendTime"].string ?? ""
                    
                    let noticeContent: String = provinces[i]["noticeContent"].string ?? ""
                    
                    let sendStatus: Int = provinces[i]["sendStatus"].int ?? 0
                    
                    var mstatus = ""
                    if (sendStatus == 1){
                        mstatus = "已读"
                        self.midss += [noticeId]
                        
                        self.titles += [noticeTitle]
                        
                        self.omtimes += [sendTime]
                        
                        self.contents += [noticeContent]
                        
                        self.mstatus += [mstatus]
                    }
                    
                }
                self.indexs = jndex
                self.reloadmess()
            }
            
        }
        
    }
    func reloadmess(){
        //重现加载表格数据
        self.tableView!.reloadData()
        //结束刷新
        self.tableView!.mj_header.endRefreshing()
        self.tableView!.mj_footer.endRefreshing()
    }
    //初始化数据
    func refreshItemData() {
        titles.append("微博热搜版")
        contents.append("1")
        midss.append(2238241)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @objc func funLeftRight(sender: UIPanGestureRecognizer){
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false, completion: nil)
    }
    //底部上拉加载
    @objc func footerLoad(){
        //print("上拉加载.")
        chongzhi = 1
        //生成并添加数据
        getMyNotices(index:indexs)
        
    }
}
