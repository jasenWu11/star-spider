//
//  CustomCellController.swift
//  XZ
//
//  Created by wjz on 2019/1/2.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit

class CustomCellController: UITableViewController {
    var titles:[String] = ["微博热搜版","百度搜索次数排行版","携程网机票价格走向","淘宝销售版","爱奇艺电影点击排行版","哔哩哔哩评论量排行","深度学习"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "CustomCell"
        let cell = CustomTableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier) as! CustomTableViewCell
        cell.root = self
        cell.titleLabel?.text = titles[indexPath.row]
        //cell.setValueForCell()
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
