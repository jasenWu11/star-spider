//
//  ViewController.swift
//  hangge_1090
//
//  Created by hangge on 2016/11/19.
//  Copyright © 2016年 hangge.com. All rights reserved.
//

import UIKit
import Alamofire
class  : UIViewController, UICollectionGridViewSortDelegate {
    
    @IBOutlet weak var bt_com: UIButton!
    @IBOutlet weak var tf_data: UITextField!
    var gridViewController: UICollectionGridViewController!
    var columns:[String] = ["编号","客户", "消费金额", "消费次数", "满意度","搞笑"]
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
    var pid:Int = 0
    var qdata:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if(tf_data.text == ""){
            self.gridViewController.showMsgbox(_message: "请输入需爬取数据内容")
        }
        else{
            self.columns.removeAll()
            self.rows.removeAll()
            self.gridViewController.removeRow()
            self.qdata = tf_data.text!
            let url = "https://www.xingzhu.club/XzTest/spiders/weibo"
            let paras = ["keyword":self.qdata]
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
                    let datamess = json["data"]
                    print("数据量\(datamess.count)")
                    self.columns = ["序号","网址","内容","图片","发布者"]
                    if(datamess.count>0){
                        for index in 1...datamess.count {
                            let datamess1 = datamess["\(index)"]
                            var num = "No.\(index)"
                            var pic:String = datamess1["pic"].string ?? "null"
                            var people:String = datamess1["people"].string ?? "null"
                            var url:String = datamess1["url"].string ?? "null"
                            var text:String = ""
                            var texts:String = ""
                            var textsz:[String] = []
                            let datavinces = datamess1["text"]
                            if let arr = datavinces.arrayObject {
                                textsz = arr as! [String]
                            }
                            for arrayItem in textsz {
                                if("\(arrayItem)" != " "&&"\(arrayItem)" != ":"){
                                    text += "\(arrayItem)"
                                }
                            }
                            self.row += [num]
                            self.row += [url]
                            self.row += [text]
                            self.row += [pic]
                            self.row += [people]
                            self.rows += [self.row]
                            self.row.removeAll()
                        }
                        self.gridViewController.setColumns(columns: self.columns)
                        print("数据表格是\(self.rows)")
                        for arrayItem in self.rows {
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
}

