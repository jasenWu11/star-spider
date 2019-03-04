//
//  messageTableViewController.swift
//  XZ
//
//  Created by wjz on 2019/3/2.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
class messageTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var titles:[String] = []
    var contents:[String] = []
    var midss:[Int] = []
    var omtimes:[String] = []
    var mstatus:[String] = []
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
        self.tableView = UITableView(frame: CGRect(x:0, y:64, width:screenWidth, height: screenHeight-64), style:.plain)
        //self.tableView = UITableView(frame: self.view.frame, style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "ShopCell")
        view.addSubview(self.tableView!)
        header.setRefreshingTarget(self, refreshingAction: #selector(getMyNotices))
        self.tableView!.mj_header = header
        getMyNotices()
        
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
            let identifier = "MyappCell"
            let cell = messageTableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier) as! messageTableViewCell
            cell.root = self
            cell.tv_title?.text = titles[indexPath.row]
            //cell.tv_content?.text = contents[indexPath.row]
            cell.tv_states?.text = mstatus[indexPath.row]
            cell.tv_mid?.text = "\(midss[indexPath.row])"
            cell.tv_mtime?.text = omtimes[indexPath.row]
            cell.v_mess!.tag = indexPath.row
            return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        print(indexPath.row)
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func getMyNotices()  {
        let url = "https://www.xingzhu.club/XzTest/notices/getMyNotices"
        let paras = ["userId":self.userid]
        print("用户ID\(self.userid)")
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("jsonRequest:\(response.result)")
            self.midss.removeAll()
            self.titles.removeAll()
            self.contents.removeAll()
            self.omtimes.removeAll()
            self.mstatus.removeAll()
            if let data = response.result.value {
                let json = JSON(data)
                print("结果:\(json)")
                var code: Int = json["code"].int!
                print("错误:\(code)")
                var message:String = json["message"].string!
                print("提示:\(message)")
                let provinces = json["data"]
                for i in 0..<provinces.count{
                    let noticeId: Int = provinces[i]["noticeId"].int ?? 0
                    self.midss += [noticeId]
                    
                    let noticeTitle: String = provinces[i]["noticeTitle"].string ?? ""
                    self.titles += [noticeTitle]
                    
                    let sendTime: String = provinces[i]["sendTime"].string ?? ""
                    self.omtimes += [sendTime]
                    
                    let noticeContent: String = provinces[i]["noticeContent"].string ?? ""
                    self.contents += [noticeContent]
                    
                    let sendStatus: Int = provinces[i]["sendStatus"].int ?? 0
                    
                    var mstatus = ""
                    if (sendStatus == 0){
                        mstatus = "未读"
                    }
                    else if (sendStatus == 1){
                        mstatus = "已读"
                    }
                    self.mstatus += [mstatus]
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
        contents.append("1")
        midss.append(2238241)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
