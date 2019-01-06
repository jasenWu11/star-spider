//
//  MytableView.swift
//  XZ
//
//  Created by wjz on 2019/1/3.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit

class MytableView: UITableView ,UITableViewDataSource{
    let TAG_CELL_LABEL = 1
    let TAG_CELL_BUTTON = 2
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    @objc func composeBtnClick(subButton: UIButton) {
        print(subButton.tag)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Mycell")
        var label = cell!.viewWithTag(TAG_CELL_LABEL) as! UILabel
        var button = cell!.viewWithTag(TAG_CELL_BUTTON) as! UIButton
        label.text = "我的tableView"
        button.setTitle("详情", for: UIControl.State.normal)
        button.tag = indexPath.row
        button.addTarget(self, action: #selector(composeBtnClick), for: UIControl.Event.touchUpInside)
        return cell as! UITableViewCell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
