//
//  ViewController.swift
//  hangge_1090
//
//  Created by hangge on 2016/11/19.
//  Copyright © 2016年 hangge.com. All rights reserved.
//

import UIKit
import Alamofire
class OperateViewController: UIViewController {
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
    var bezierText:BezierText!
    var cantouch:Int = 0
    var text:String = "loading..."
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    override func viewDidLoad() {
        super.viewDidLoad()
        //关闭导航栏半透明效果
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = Ntitle
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
        gridViewController.view.frame = CGRect(x:0, y:36, width:view.frame.width,
                                               height:view.frame.height-36)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func UIColorRGB_Alpha(R:CGFloat, G:CGFloat, B:CGFloat, alpha:CGFloat) -> UIColor
    {
        let color = UIColor.init(red: (R / 255.0), green: (G / 255.0), blue: (B / 255.0), alpha: alpha);
        return color;
    }
    @IBAction func DataRequet(_ sender: Any) {
        self.gridViewController.v_datasource?.isHidden = true
        if (cantouch == 1) {
            let alertController = UIAlertController(title: "正在爬取数据中，请稍等",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
        }
        else{
            if(tf_data.text == ""&&iskey == 1){
                self.gridViewController.showMsgbox(_message: "请输入需爬取数据内容")
            }
            else{
                columd.removeAll()
                columns.removeAll()
                rows.removeAll()
                therows.removeAll()
                self.gridViewController.setColumd(columd: self.columd)
                self.gridViewController.setColumns(columns: self.columns)
                self.gridViewController.addtext()
                //定时循环执行
                MCGCDTimer.shared.scheduledDispatchTimer(WithTimerName: "GCDTimer", timeInterval: 5, queue: .main, repeats: true) {
                    if(self.text == "loading..."){
                        self.gridViewController.bezierText.show(text: self.text)
                        self.text = "爬取中..."
                    }
                    else if(self.text == "爬取中..."){
                        self.gridViewController.bezierText.show(text: self.text)
                        self.text = "loading..."
                    }
                }
                
                cantouch = 1
                self.columns.removeAll()
                self.rows.removeAll()
                self.gridViewController.removeRow()
                self.qdata = tf_data.text!
                let url = "https://www.xingzhu.club/XzTest/spiders/crawlers"
                let paras = ["crawlerName":self.crawlername,"keyword":self.qdata,"max_page":8,"page_info_number":30,"userId":self.userid,"number":50] as [String : Any]
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
                        let titlemess = json["title"].string
                        //设置表头
                        self.columd = self.StringtoArray(Stringvalue: titlemess!) as! [String]
                        //简约式表头
                        var row0:String = self.columd[0]
                        var row2:String = self.columd[2]
                        self.columns += [row0]
                        self.columns += [row2]
                        ///循环查找当前数组中是否已经添加过该元素
                        for index in 0..<self.columd.count
                            
                        {
                            var item : String = self.columd[index]
                            //print("遍历数组1：\(item)")
                            let stringResult = item.contains("图")
                            print("\(index)包含图吗？\(stringResult)")
                            if(stringResult == true){
                                self.phoitem = index
                            }
                        }
                        //print("输出数组是\(self.titless)")
                        //print("数据量\(datamess.count)")
                        if(datamess.count>0){
                            for index in 0...datamess.count-1 {
                                var num = "NO.\(index+1)"
                                self.row += [num]
                                self.therow += [num]
                                for i in 1..<self.columd.count{
                                    var row1 = "\(datamess[index][self.columd[i]])"
                                    var row1s : String = self.Spacequit(Stringvalue: row1)
                                    if(row1s != "无此数据"){
                                        self.row += [row1s]
                                    }
                                    if(i == 2){
                                        self.therow += [row1s]
                                    }
                                }
                                
                                self.rows += [self.row]
                                self.row.removeAll()
                                
                                self.therows += [self.therow]
                                self.therow.removeAll()
                            }
                            //关闭定时d任务
                            MCGCDTimer.shared.cancleTimer(WithTimerName: "GCDTimer")
                            self.gridViewController.bezierText.removeFromSuperview()
                            //导航栏高度
                            let nv_height = self.navigationController?.navigationBar.frame.size.height
                            //状态栏高度
                            let zt_height = UIApplication.shared.statusBarFrame.height
                            let theheight = nv_height!+zt_height+36
                            let thisheight = self.screenHeight-theheight
                            let they = theheight
                            self.gridViewController.setViewY(sjthey: 0, sjheight: thisheight,ctype:1)
                            self.gridViewController.setColumns(columns: self.columns)
                            self.gridViewController.setColumd(columd: self.columd)
                            self.gridViewController.setRow(row: self.rows)
                            self.gridViewController.setPhoto(photoindex: self.phoitem)
                            self.gridViewController.zidong(excelname: self.Ntitle)
                            //print("数据表格是\(self.rows)")
                            for arrayItem in self.therows {
                                self.gridViewController.addRow(row: arrayItem)
                            }
                           
                            self.cantouch = 0
                        }
                        else{
                            self.gridViewController.showMsgbox(_message: "爬取数据量为0，请确认需爬取内容后重新爬取")
                        }
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
    func StringtoArray(Stringvalue:String)->Array<Any>{
        //去掉无用字符
        let leftquit = Stringvalue.trimmingCharacters(in: NSCharacterSet(charactersIn: "[") as CharacterSet)
        let rightquit = leftquit.trimmingCharacters(in: NSCharacterSet(charactersIn: "]") as CharacterSet)
        var thetitle:String = "序号,\(rightquit)"
        let array = thetitle.components(separatedBy:",")
        return array
    }
}

