//
//  MycellViewController.swift
//  XZ
//
//  Created by wjz on 2019/1/3.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit

class ShopcellViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var segcon: UISegmentedControl!
    let TAG_CELL_LABEL = 1
    let TAG_CELL_BUTTON = 2
    var titles:[String] = ["微博热搜版","百度搜索次数排行版","携程网机票价格走向"]
    var contents:[String] = ["获取微博热搜版，研究大众兴趣","获取百度网搜索次数排行，分析用户需求","获取携程网机票价格数据，分析走向"]
    var images:[String] = ["weibo","baidu","xiecheng"]
    var pidss:[Int] = [13,11,10]
    var tableView:UITableView?
    var iconImage: UIImageView?
    var titleLabel: UILabel?
    var subTitleLabel: UILabel?
    var subButton : UIButton?
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    override func loadView() {
        super.loadView()
    }
    @IBAction func Xuanxiang(_ sender: Any) {
        switch segcon.selectedSegmentIndex{
        case 0:
            titles = ["微博热搜版","百度搜索次数排行版","携程网机票价格走向"]
            contents = ["获取微博热搜版，研究大众兴趣","获取百度网搜索次数排行，分析用户需求","获取携程网机票价格数据，分析走向"]
            images = ["weibo","baidu","xiecheng"]
            pidss = [13,11,10]
            Setup()
        case 1:
            titles = ["微博热搜版","携程网机票价格走向"]
            contents = ["获取微博热搜版，研究大众兴趣","获取携程网机票价格数据，分析走向"]
            images = ["weibo","xiecheng"]
            pidss = [13,10]
            Setup()
        case 2:
            titles = ["百度搜索次数排行版","携程网机票价格走向"]
            contents = ["获取百度网搜索次数排行，分析用户需求","获取携程网机票价格数据，分析走向"]
            images = ["baidu","xiecheng"]
            pidss = [11,10]
            Setup()
        case 3:
            titles = ["携程网机票价格走向"]
            contents = ["获取携程网机票价格数据，分析走向"]
            images = ["xiecheng"]
            pidss = [10]
            Setup()
        default:
            break
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Setup()
    }
    func Setup() {
        
        //创建表视图
        self.tableView = UITableView(frame: CGRect(x:0, y:148, width:screenWidth, height: screenHeight), style:.plain)
        //self.tableView = UITableView(frame: self.view.frame, style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
        self.view.addSubview(self.tableView!)
    }
    //在本例中，只有一个分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    @objc func composeBtnClick(subButton: UIButton) {
        print(subButton.tag)
        var pids:Int = subButton.tag
        self.performSegue(withIdentifier: "ShowDetailView", sender: pids)
    }
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            //为了提供表格显示性能，已创建完成的单元需重复使用
            let identify:String = "cell1"
            //同一形式的单元格重复使用，在声明时已注册
            let cell = tableView.dequeueReusableCell(withIdentifier: identify,
                                                     for: indexPath) as UITableViewCell
            cell.accessoryType = .none
            iconImage = UIImageView(frame: CGRect(x:15, y: 10, width:100, height: 75))
            iconImage?.image = UIImage(named:images[indexPath.row])
            cell.addSubview(iconImage!)
            // 大标题
            titleLabel = UILabel(frame: CGRect(x:(iconImage?.frame.size.width)!+25, y:10, width: 130, height:30))
            titleLabel?.font = UIFont.systemFont(ofSize: 16)
            titleLabel?.textColor = UIColor.black
            titleLabel?.text = titles[indexPath.row]
            cell.addSubview(titleLabel!)
            
            // 副标题
            subTitleLabel = UILabel(frame: CGRect(x:(iconImage?.frame.size.width)!+25, y:(titleLabel?.frame.size.height)!+35, width:150, height: 30))
            subTitleLabel?.font = UIFont.systemFont(ofSize: 14)
            subTitleLabel?.textColor = UIColor.gray
            subTitleLabel?.text = contents[indexPath.row]
            cell.addSubview(subTitleLabel!)
            // 按钮
            subButton = UIButton(frame: CGRect(x:screenWidth-46-15, y:((95-46)/2), width:46, height: 46))
            subButton?.setTitle("详情", for: UIControl.State.normal)
            subButton?.setTitleColor(UIColor.blue, for: UIControl.State.normal)
            subButton?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            subButton?.layer.cornerRadius=23
                                            subButton?.layer.masksToBounds=true
                                            subButton?.layer.borderColor = UIColor(red: 140/255, green:124/255, blue:221/255, alpha:1).cgColor
                                            subButton?.layer.borderWidth=1
             subButton!.tag = pidss[indexPath.row]
            subButton?.addTarget(self, action: #selector(composeBtnClick), for: UIControl.Event.touchUpInside)
            cell.addSubview(subButton!)
            return cell
    }
    
//    // UITableViewDelegate 方法，处理列表项的选中事件
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.tableView!.deselectRow(at: indexPath, animated: true)
//        let itemString = self.titles[indexPath.row]
//
//        self.performSegue(withIdentifier: "ShowDetailView", sender: itemString)
//    }
    
    //在这个方法中给新页面传递参数
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailView"{
            let controller = segue.destination as! APImessViewController
            controller.pid = (sender as? Int)!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
