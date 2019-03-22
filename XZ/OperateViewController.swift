//
//  ViewController.swift
//  hangge_1090
//
//  Created by hangge on 2016/11/19.
//  Copyright © 2016年 hangge.com. All rights reserved.
//

import UIKit
import Alamofire
class OperateViewController: UIViewController, UICollectionGridViewSortDelegate {
    
    @IBOutlet weak var ni_title: UINavigationItem!
    @IBOutlet weak var bt_com: UIButton!
    @IBOutlet weak var tf_data: UITextField!
    @IBOutlet weak var l_key: UILabel!
    var iskey:Int = 0
    var crawlername:String = ""
    var Ntitle:String = ""
    var userid:Int = 0
    var gridViewController: UICollectionGridViewController!
    var columns:[String] = ["编号","客户", "消费金额", "消费次数", "满意度","搞笑"]
    var columd:[String] = ["编号","客户", "消费金额", "消费次数", "满意度","搞笑"]
    var row1:[String] = ["No.01","hangge", "100", "8", "60%","11"]
    var row2:[String] = ["No.02","张三", "223", "16", "81%","12"]
    var row3:[String] = ["No.03","李四", "143", "25", "93%","11"]
    var row4:[String] = ["No.04","王五", "75", "2", "53%","12"]
    var row5:[String] = ["No.05","韩梅梅", "43", "12", "33%","11"]
    var row6:[String] = ["No.06","李雷", "33", "27", "45%","12"]
    var row7:[String] = ["No.07","王大力", "33", "22", "15%","11"]
    var row8:[String] = ["No.08","蝙蝠侠", "100", "8", "60%","11"]
    var row9:[String] = ["No.09","超人", "223", "16", "81%","12"]
    var rows:[[String]] = []
    var row:[String] = []
    var therow : [Any] = []
    var therows : [[Any]]! = []
    var pid:Int = 0
    var qdata:String = ""
    var field1:String = ""
    var field2:String = ""
    var field3:String = ""
    var field4:String = ""
    var field5:String = ""
    var field6:String = ""
    var field7:String = ""
    var field8:String = ""
    var field9:String = ""
    var phoitem:Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        ni_title.title = Ntitle
        if(iskey == 0){
            l_key.isHidden = true
            tf_data.isHidden = true
        }
        userid = UserDefaults.standard.object(forKey: "userId") as! Int
        bt_com?.backgroundColor=UIColorRGB_Alpha(R: 91.0, G: 84.0, B: 145.0, alpha: 0.8);
        bt_com?.clipsToBounds=true
        bt_com?.layer.shadowColor = UIColor.gray.cgColor
        bt_com?.layer.shadowOpacity = 1.0
        bt_com?.layer.shadowOffset = CGSize(width: 0, height: 0)
        bt_com?.layer.shadowRadius = 4
        bt_com?.layer.masksToBounds = false
        gridViewController = UICollectionGridViewController()
        
        view.addSubview(self.gridViewController.view)
    }
    
    override func viewDidLayoutSubviews() {
        gridViewController.view.frame = CGRect(x:0, y:100, width:view.frame.width,
                                               height:view.frame.height-120)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //表格排序函数
    func sort(colIndex: Int, asc: Bool, rows: [[Any]]) -> [[Any]] {
        let sortedRows = rows.sorted { (firstRow: [Any], secondRow: [Any])
            -> Bool in
            let firstRowValue = firstRow[colIndex] as! String
            let secondRowValue = secondRow[colIndex] as! String
            if colIndex == 0 || colIndex == 1 {
                //首例、姓名使用字典排序法
                if asc {
                    return firstRowValue < secondRowValue
                }
                return firstRowValue > secondRowValue
            } else if colIndex == 2 || colIndex == 3 {
                //中间两列使用数字排序
                if asc {
                    return Int(firstRowValue)! < Int(secondRowValue)!
                }
                return Int(firstRowValue)! > Int(secondRowValue)!
            }
            //最后一列数据先去掉百分号，再转成数字比较
            let firstRowValuePercent = Int(firstRowValue.substring(to:
                firstRowValue.index(before: firstRowValue.endIndex)))!
            let secondRowValuePercent = Int(secondRowValue.substring(to:
                secondRowValue.index(before: secondRowValue.endIndex)))!
            if asc {
                return firstRowValuePercent < secondRowValuePercent
            }
            return firstRowValuePercent > secondRowValuePercent
        }
        return sortedRows
    }
    func UIColorRGB_Alpha(R:CGFloat, G:CGFloat, B:CGFloat, alpha:CGFloat) -> UIColor
    {
        let color = UIColor.init(red: (R / 255.0), green: (G / 255.0), blue: (B / 255.0), alpha: alpha);
        return color;
    }
    @IBAction func DataRequet(_ sender: Any) {
        if(tf_data.text == ""&&iskey == 1){
            self.gridViewController.showMsgbox(_message: "请输入需爬取数据内容")
        }
        else{
            self.columns.removeAll()
            self.rows.removeAll()
            self.gridViewController.removeRow()
            self.qdata = tf_data.text!
            if(crawlername == "bilibili_beauty"){
                self.columd = ["序号","视频链接","视频名","视频av号","视频时长","播放量","up主","上传日期"]
                self.columns = ["序号","视频名"]
                self.field1 = "视频链接"
                self.field2 = "视频名"
                self.field3 = "视频av号"
                self.field4 = "视频时长"
                self.field5 = "播放量"
                self.field6 = "up主"
                self.field7 = "上传日期"
            }
            else if(crawlername == "douban_new_movie"){
                self.columd = ["序号","电影链接","电影名称","电影评分"]
                self.columns = ["序号","电影名称"]
                self.field1 = "电影链接"
                self.field2 = "电影名称"
                self.field3 = "电影评分"
            }
            else if(crawlername == "douban_top250"){
                self.columd = ["序号","电影链接","电影名称","电影评分"]
                self.columns = ["序号","电影名称"]
                self.field1 = "电影链接"
                self.field2 = "电影名称"
                self.field3 = "电影评分"
            }
            else if(crawlername == "tencent_video"){
                self.columd = ["序号","视频链接","视频名称","视频作者","视频简介"]
                self.columns = ["序号","视频名称"]
                self.field2 = "视频名称"
                self.field3 = "视频作者"
                self.field4 = "视频简介"
            }
            else if(crawlername == "weibo"){
                self.columd = ["序号","链接","微博名","评论文本","图片"]
                self.columns = ["序号","微博名"]
                self.field2 = "微博名"
                self.field3 = "评论文本"
                self.field4 = "图片"
            }
            else if(crawlername == "amazon_phone"){
                self.columd = ["序号","链接","标题","价格","图片","品牌"]
                self.columns = ["序号","标题"]
                self.field1 = "链接"
                self.field2 = "标题"
                self.field3 = "价格"
                self.field4 = "图片"
                self.field5 = "品牌"
            }
            else if(crawlername == "bilibili_all_video"){
                self.columns = ["序号","视频链接","视频名","视频av号","作者","播放量","视频简介","视频时长"]
                self.columd = ["序号","视频名"]
                self.field1 = "视频链接"
                self.field2 = "视频名"
                self.field3 = "视频av号"
                self.field4 = "作者"
                self.field5 = "播放量"
                self.field6 = "视频简介"
                self.field7 = "视频时长"
            }
            else if(crawlername == "dangdang_book"){
                self.columns = ["序号","链接","书名","作者以及译者","价格","简介"]
                self.columd = ["序号","书名"]
                self.field1 = "链接"
                self.field2 = "书名"
                self.field3 = "作者以及译者"
                self.field4 = "价格"
                self.field5 = "简介"
            }
            ///循环查找当前数组中是否已经添加过该元素
            
            for index in 0..<columd.count
                
            {
                
                var item : String = columd[index]
                
                //print("遍历数组1：\(item)")
                let stringResult = item.contains("图")
                print("\(index)包含图吗？\(stringResult)")
                if(stringResult == true){
                    phoitem = index
                }
            }
            
            let url = "https://www.xingzhu.club/XzTest/spiders/crawlers"
            let paras = ["crawlerName":self.crawlername,"keyword":self.qdata,"max_page":8,"page_info_number":30,"userId":self.userid] as [String : Any]
            print("开始爬取--爬虫名\(self.crawlername)，关键字\(self.qdata)")
            // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
            Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                //print("jsonRequest:\(response.result)")
                if let data = response.result.value {
                    let json = JSON(data)
                    //print("结果:\(json)")
                    var code: Int = json["code"].int!
                    print("错误:\(code)")
                    var message:String = json["message"].string!
                    print("提示:\(message)")
                    let datamess = json["data"]
                    print("数据量\(datamess.count)")
                    if(datamess.count>0){
                        for index in 0...datamess.count-1 {
                            var num = "NO.\(index+1)"
                            var row1 = datamess[index][self.field1].string ?? "无此数据"
                            var row1s : String = self.Spacequit(Stringvalue: row1)
                            var row2 = datamess[index][self.field2].string ?? "无此数据"
                            var row2s : String = self.Spacequit(Stringvalue: row2)
                            var row3 = datamess[index][self.field3].string ?? "无此数据"
                            var row3s : String = self.Spacequit(Stringvalue: row3)
                            var row4 = datamess[index][self.field4].string ?? "无此数据"
                            var row4s : String = self.Spacequit(Stringvalue: row4)
                            var row5 = datamess[index][self.field5].string ?? "无此数据"
                            var row5s : String = self.Spacequit(Stringvalue: row5)
                            var row6 = datamess[index][self.field6].string ?? "无此数据"
                            var row6s : String = self.Spacequit(Stringvalue: row6)
                            var row7 = datamess[index][self.field7].string ?? "无此数据"
                            var row7s : String = self.Spacequit(Stringvalue: row7)
                            var row8 = datamess[index][self.field8].string ?? "无此数据"
                            var row8s : String = self.Spacequit(Stringvalue: row8)
                            var row9 = datamess[index][self.field9].string ?? "无此数据"
                            var row9s : String = self.Spacequit(Stringvalue: row9)
                            self.row += [num]
                            self.therow += [num]
                            if(row1s != "无此数据"){
                                self.row += [row1s]
                            }
                            if(row2s != "无此数据"){
                                self.row += [row2s]
                                self.therow += [row2s]
                            }
                            if(row3s != "无此数据"){
                                self.row += [row3s]
                            }
                            if(row4s != "无此数据"){
                                self.row += [row4s]
                            }
                            if(row5s != "无此数据"){
                                self.row += [row5s]
                            }
                            if(row6s != "无此数据"){
                                self.row += [row6s]
                            }
                            if(row7s != "无此数据"){
                                self.row += [row7s]
                            }
                            if(row8s != "无此数据"){
                                self.row += [row8s]
                            }
                            if(row9s != "无此数据"){
                                self.row += [row9s]
                            }
                            self.rows += [self.row]
                            self.row.removeAll()
                            
                            self.therows += [self.therow]
                            self.therow.removeAll()
                        }
                        self.gridViewController.setColumns(columns: self.columns)
                        self.gridViewController.setColumd(columd: self.columd)
                        self.gridViewController.setRow(row: self.rows)
                        self.gridViewController.setPhoto(photoindex: self.phoitem)
                        //print("数据表格是\(self.rows)")
                        for arrayItem in self.therows {
                            self.gridViewController.addRow(row: arrayItem)
                        }
                        self.gridViewController.sortDelegate = self
                    }
                    else{
                        self.gridViewController.showMsgbox(_message: "爬取数据量为0，请确认需爬取内容后重新爬取")
                    }
                }
            }
        }
        
    }
    func Spacequit(Stringvalue:String)->String{
        //去掉无用字符
        let stringquit = Stringvalue.trimmingCharacters(in: NSCharacterSet(charactersIn: "   /") as CharacterSet)
        //去掉首位空格和换行
        let spacequit = stringquit.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        return spacequit
    }
}

