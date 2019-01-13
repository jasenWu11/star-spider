//
//  ShopTableViewController.swift
//  XZ
//
//  Created by wjz on 2019/1/9.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit

class ShopTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var titles:[String] = ["微博热搜版","百度搜索次数排行版","爱奇艺点击率最高电影","携程网机票价格走向"]
    var contents:[String] = ["获取微博热搜版，研究大众兴趣","获取百度网搜索次数排行，分析用户需求","获取爱奇艺点击率最高电影,可以方便找到票房较高的电影，筛选避过烂片","获取携程网机票价格数据，分析走向"]
    var images:[String] = ["weibo","baidu","aiqiyi","xiecheng"]
    var price:[String] = ["¥81.04","¥126.5","¥130.5","¥90"]
    var pidss:[Int] = [2238241,2238242,2238245,2238243]
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    let TAG_CELL_LABEL = 1
    let TAG_CELL_BUTTON = 2
    var pids:Int = 0
    var tableView:UITableView?
    var root : ShoppagViewController?
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
        let identifier = "ShopCell"
        let cell = ShopTableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier) as! ShopTableViewCell
        cell.root = self
        cell.titleLabel?.text = titles[indexPath.row]
        cell.iconImage?.image = UIImage(named:images[indexPath.row])
        cell.subTitleLabel?.text = contents[indexPath.row]
        cell.pirceLabel?.text = price[indexPath.row]
        cell.subButton!.tag = pidss[indexPath.row]
        cell.shopcellView!.tag = pidss[indexPath.row]
        cell.tag = pidss[indexPath.row]
        pids = pidss[indexPath.row]
        return cell
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
}
