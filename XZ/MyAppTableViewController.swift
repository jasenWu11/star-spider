//
//  ShopTableViewController.swift
//  XZ
//
//  Created by wjz on 2019/1/9.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit

class MyAppTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var titles:[String] = ["微博热搜版","百度搜索次数排行版","携程网机票价格走向","淘宝销售版","爱奇艺电影点击排行版","哔哩哔哩评论量排行","深度学习"]
    var types:[String] = ["API接口","API接口","数据","爬虫","API接口","爬虫","数据"]
    var ctimes:[String] = ["2018-10-19","2018-10-22","2018-11-02","2018-11-11","2018-11-12","2018-11-22","2018-11-30"]
    var states:[String] = ["未开始","已停止","已停止","暂停","未开始","正在操作","正在操作"]
    var counts:[String] = ["0","16","30","15","0","20","18"]
    var pidss:[Int] = [2238241,2238242,2238243,2238244,2238245,2238246,2238244]
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    let TAG_CELL_LABEL = 1
    let TAG_CELL_BUTTON = 2
    var pids:Int = 0
    var tableView:UITableView?
    var root : MyApppagViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        //创建表视图
        self.tableView = UITableView(frame: CGRect(x:0, y:5, width:screenWidth, height: screenHeight-123), style:.plain)
        //self.tableView = UITableView(frame: self.view.frame, style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "ShopCell")
        view.addSubview(self.tableView!)
    }
    // MARK: - Table view data source
    
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
            let identifier = "MyappCell"
            let cell = MyAppTableViewcell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier) as! MyAppTableViewcell
            cell.root = self
            cell.tv_title?.text = titles[indexPath.row]
            cell.tv_type?.text = types[indexPath.row]
            cell.tv_state?.text = states[indexPath.row]
            cell.tv_count?.text = counts[indexPath.row]
            cell.bt_oper!.tag = pidss[indexPath.row]
            cell.bt_dele!.tag = pidss[indexPath.row]
            return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        print(indexPath.row)
    }

}
