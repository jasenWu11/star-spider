//
//  MycellViewController.swift
//  XZ
//
//  Created by wjz on 2019/1/3.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit

class MyAppcellViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var segcon: UISegmentedControl!
    //    @IBOutlet weak var segcon: UISegmentedControl!
    let TAG_CELL_LABEL = 1
    let TAG_CELL_BUTTON = 2
    var titles:[String] = ["微博热搜版","百度搜索次数排行版","携程网机票价格走向","淘宝销售版","爱奇艺电影点击排行版","哔哩哔哩评论量排行","深度学习"]
    var types:[String] = ["API接口","API接口","数据","爬虫","API接口","爬虫","机器学习"]
    var ctimes:[String] = ["2018-10-19","2018-10-22","2018-11-02","2018-11-11","2018-11-12","2018-11-22","2018-11-30"]
    var states:[String] = ["未开始","已停止","已停止","暂停","未开始","正在操作","正在操作"]
    var counts:[String] = ["0","16","30","15","0","20","18"]
    var pidss:[Int] = [2238241,2238242,2238243,2238244,2238245,2238246,2238244]
    var tableView:UITableView?
    var tv_type: UILabel?
    var tv_title: UILabel?
    var tv_ctime: UILabel?
    var tv_state: UILabel?
    var tv_count: UILabel?
    var bt_oper : UIButton?
    var bt_dele : UIButton?
    var tv_types: UILabel?
    var tv_ctimes: UILabel?
    var tv_states: UILabel?
    var tv_counts: UILabel?
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    override func loadView() {
        super.loadView()
    }
    @IBAction func Xuanxiang(_ sender: Any) {
        switch segcon.selectedSegmentIndex{
        case 0:
            titles = ["微博热搜版","百度搜索次数排行版","携程网机票价格走向","淘宝销售版","爱奇艺电影点击排行版","哔哩哔哩评论量排行","深度学习"]
            types = ["API接口","API接口","数据","爬虫","API接口","爬虫","机器学习"]
            ctimes = ["2018-10-19","2018-10-22","2018-11-02","2018-11-11","2018-11-12","2018-11-22","2018-11-30"]
            states = ["未开始","已停止","已停止","暂停","未开始","正在操作","正在操作"]
            counts = ["0","16","30","15","0","20","18"]
            pidss = [2238241,2238242,2238243,2238244,2238245,2238246,2238244]
            Setup()
        case 1:
            titles = ["微博热搜版","百度搜索次数排行版","爱奇艺电影点击排行版"]
            types = ["API接口","API接口","API接口"]
            ctimes = ["2018-10-19","2018-10-22","2018-11-12"]
            states = ["未开始","已停止","未开始"]
            counts = ["0","16","0"]
            pidss = [2238241,2238242,2238245]
            Setup()
        case 2:
            titles = ["携程网机票价格走向"]
            types = ["数据"]
            ctimes = ["2018-11-02"]
            states = ["已停止"]
            counts = ["30"]
            pidss = [2238243]
            Setup()
        case 3:
            titles = ["淘宝销售版","哔哩哔哩评论量排行"]
            types = ["爬虫","爬虫"]
            ctimes = ["2018-11-11","2018-11-22"]
            states = ["暂停","正在操作"]
            counts = ["15","20"]
            pidss = [2238244,2238246]
            Setup()
        case 4:
            titles = ["深度学习"]
            types = ["机器学习"]
            ctimes = ["2018-11-30"]
            states = ["正在操作"]
            counts = ["18"]
            pidss = [2238244]
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
        self.tableView = UITableView(frame: CGRect(x:0, y:93, width:screenWidth, height: screenHeight), style:.plain)
        //self.tableView = UITableView(frame: self.view.frame, style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "myappcell")
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
        return 145
    }
    @objc func Operactions(subButton: UIButton) {
        var pids:Int = 0
        pids = subButton.tag
        self.performSegue(withIdentifier: "operDetailView", sender: pids)
    }
    @objc func Deleactions(subButton: UIButton) {
        print(subButton.tag)
        let alertController = UIAlertController(title: "提示", message: "是否删除该应用？",preferredStyle: .alert)
        let cancelAction1 = UIAlertAction(title: "确定", style: .default, handler: {
            action in
            self.deleteok()
        })
        let cancelAction2 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction1)
        alertController.addAction(cancelAction2)
        self.present(alertController, animated: true, completion: nil)
    }
    func deleteok(){
        let alertController = UIAlertController(title: "删除成功!",
                                                message: nil, preferredStyle: .alert)
        //显示提示框
        self.present(alertController, animated: true, completion: nil)
        //两秒钟后自动消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.presentedViewController?.dismiss(animated: false, completion: nil)
        }
    }
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            //为了提供表格显示性能，已创建完成的单元需重复使用
            let identify:String = "myappcell"
            //同一形式的单元格重复使用，在声明时已注册
            let cell = tableView.dequeueReusableCell(withIdentifier: identify,
                                                     for: indexPath) as UITableViewCell
            cell.accessoryType = .none
            // 大标题
            tv_title = UILabel(frame: CGRect(x:10, y: 10, width:screenWidth-10, height: 20))
            tv_title?.text = titles[indexPath.row]
            tv_type?.font = UIFont.systemFont(ofSize: 16)
            tv_type?.textColor = UIColor.black
            cell.addSubview(tv_title!)
            //类型说明
            tv_types = UILabel(frame: CGRect(x:10, y:35, width: 80, height:20))
            tv_types?.font = UIFont.systemFont(ofSize: 14)
            tv_types?.textColor = UIColor.black
            tv_types?.text = "应用类型："
            cell.addSubview(tv_types!)
            // 类型
            tv_type = UILabel(frame: CGRect(x:85, y:35, width: 100, height:20))
            tv_type?.font = UIFont.systemFont(ofSize: 14)
            tv_type?.textColor = UIColor.black
            tv_type?.text = types[indexPath.row]
            cell.addSubview(tv_type!)
            // 创建时间
            tv_ctimes = UILabel(frame: CGRect(x:10, y:60, width:80, height: 20))
            tv_ctimes?.font = UIFont.systemFont(ofSize: 14)
            tv_ctimes?.textColor = UIColor.black
            tv_ctimes?.text = "操作时间："
            cell.addSubview(tv_ctimes!)
            
            tv_ctime = UILabel(frame: CGRect(x:85, y:60, width:100, height: 20))
            tv_ctime?.font = UIFont.systemFont(ofSize: 14)
            tv_ctime?.textColor = UIColor.black
            tv_ctime?.text = ctimes[indexPath.row]
            cell.addSubview(tv_ctime!)
            // 状态
            tv_states = UILabel(frame: CGRect(x:10, y:85, width:45, height: 20))
            tv_states?.font = UIFont.systemFont(ofSize: 14)
            tv_states?.textColor = UIColor.black
            tv_states?.text = "状态："
            cell.addSubview(tv_states!)
            
            tv_state = UILabel(frame: CGRect(x:50, y:85, width:100, height: 20))
            tv_state?.font = UIFont.systemFont(ofSize: 14)
            tv_state?.textColor = UIColor.black
            tv_state?.text = states[indexPath.row]
            cell.addSubview(tv_state!)
            // 统计
            tv_counts = UILabel(frame: CGRect(x:10, y:110, width:60, height: 20))
            tv_counts?.font = UIFont.systemFont(ofSize: 14)
            tv_counts?.textColor = UIColor.black
            tv_counts?.text = "统计量："
            cell.addSubview(tv_counts!)
            
            tv_count = UILabel(frame: CGRect(x:65, y:110, width:100, height: 20))
            tv_count?.font = UIFont.systemFont(ofSize: 14)
            tv_count?.textColor = UIColor.black
            tv_count?.text = counts[indexPath.row]
            cell.addSubview(tv_count!)
            // 操作按钮
            bt_oper = UIButton(frame: CGRect(x:screenWidth-70-15, y:((145)/2-30)-10, width:70, height: 30))
            bt_oper?.setTitle("操作", for: UIControl.State.normal)
            bt_oper?.setTitleColor(UIColor.white, for: UIControl.State.normal)
            bt_oper?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            bt_oper?.backgroundColor = UIColor.blue
            bt_oper!.tag = pidss[indexPath.row]
            bt_oper?.addTarget(self, action: #selector(Operactions), for: UIControl.Event.touchUpInside)
            cell.addSubview(bt_oper!)
            // 删除按钮
            bt_dele = UIButton(frame: CGRect(x:screenWidth-70-15, y:((145)/2)+10, width:70, height: 30))
            bt_dele?.setTitle("删除", for: UIControl.State.normal)
            bt_dele?.setTitleColor(UIColor.white, for: UIControl.State.normal)
            bt_dele?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            bt_dele?.backgroundColor = UIColor.red
            bt_dele!.tag = indexPath.row
            bt_dele?.addTarget(self, action: #selector(Deleactions), for: UIControl.Event.touchUpInside)
            cell.addSubview(bt_dele!)
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
        if segue.identifier == "operDetailView"{
            let controller = segue.destination as! OperViewController
            controller.pid = (sender as? Int)!
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
