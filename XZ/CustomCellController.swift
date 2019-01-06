//
//  CustomCellController.swift
//  XZ
//
//  Created by wjz on 2019/1/2.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit

class CustomCellController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "CustomCell"
        let cell = CustomTableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier)
        cell.setValueForCell()
        return cell
    }
}
