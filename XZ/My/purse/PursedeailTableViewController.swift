//
//  PursedeailTableViewController.swift
//  XZ
//
//  Created by wjz on 2019/2/22.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
class PursedeailTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var rechargeId:[Int] = []
    var rechargeTime:[String] = []
    var rechargerMoney:[Double] = []
    //    var states:[String] = ["未开始","已停止","已停止","暂停","未开始","正在操作","正在操作"]
    //    var counts:[String] = ["0","16","30","15","0","20","18"]
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    let TAG_CELL_LABEL = 1
    let TAG_CELL_BUTTON = 2
    var pids:Int = 0
    var tableView:UITableView?
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.separatorStyle = .none
        //下拉刷新
        header.lastUpdatedTimeLabel.isHidden = true
        header.stateLabel.isHidden = true
        //创建表视图
        self.tableView = UITableView(frame: CGRect(x:0, y:64, width:screenWidth, height: screenHeight-64), style:.plain)
        //self.tableView = UITableView(frame: self.view.frame, style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "ShopCell")
        view.addSubview(self.tableView!)
        header.setRefreshingTarget(self, refreshingAction: #selector(getRechargeRecords))
        self.tableView!.mj_header = header
        getRechargeRecords()
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rechargeId.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let identifier = "MyappCell"
            let cell = pursedeailTableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier) as! pursedeailTableViewCell
            cell.root = self
            cell.tv_rids?.text = "\(rechargeId[indexPath.row])"
            cell.tv_times?.text = rechargeTime[indexPath.row]
            cell.tv_mons?.text = "+\(rechargerMoney[indexPath.row])"
            //cell.bt_dele!.tag = pidss[indexPath.row]
            return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        print(indexPath.row)
    }
    //充值记录
    @objc func getRechargeRecords()  {
        
        var userid:Int = UserDefaults.standard.object(forKey: "userId") as! Int
        let url = "https://www.xingzhu.club/XzTest/recharges/getRechargeRecords"
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
                self.rechargeId.removeAll()
                self.rechargeTime.removeAll()
                self.rechargerMoney.removeAll()
                for i in 0..<provinces.count{
                    let rid: Int = provinces[i]["rechargeId"].int ?? 0
                    self.rechargeId += [rid]
                    
                    let rmo: Double = provinces[i]["rechargerMoney"].double ?? 0.0
                    self.rechargerMoney += [rmo]
                    
                    let rct: String = provinces[i]["rechargeTime"].string ?? ""
                    self.rechargeTime += [rct]
                }
            }
            self.tableView!.reloadData()
            //结束刷新
            self.tableView!.mj_header.endRefreshing()
        }
    }
}
