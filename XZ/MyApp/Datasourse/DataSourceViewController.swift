//
//  DataSourceViewController.swift
//  XZ
//
//  Created by wjz on 2019/2/28.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit
import Alamofire
class DataSourceViewController: UIViewController{
    var iskey:Int = 0
    var Ntitle:String = ""
    var dataName:String = ""
    var gridViewController: UICollectionGridViewController!
    var columns:[String] = []
    var columd:[String] = []
    var row1:[String] = []
    var rows:[[String]] = []
    var excelrows:[[String]] = []
    var row:[String] = []
    var therow : [Any] = []
    var therows : [[Any]]! = []
    var pid:Int = 0
    var qdata:String = ""
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    var titless:[String] = []
//    var v_datasource : UIView?
//    var datasourceView : UIScrollView?
//    var iv_close:UIButton?
//    var height:Int = 0
    var phoitem:Int = -1
    var text:String = "loading..."
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Ntitle
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title:"+",style:UIBarButtonItem.Style.plain,target:self,action:#selector(menu))
        self.navigationItem.rightBarButtonItem?.image = UIImage(named: "share")
        self.navigationItem.rightBarButtonItem!.isEnabled = false
        gridViewController = UICollectionGridViewController()
        view.addSubview(self.gridViewController.view)
   
        DataRequet()
    }
    
    override func viewDidLayoutSubviews() {
        gridViewController.view.frame = CGRect(x:0, y:0, width:view.frame.width,
                                               height:view.frame.height-0)
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
    func DataRequet() {
        self.navigationItem.rightBarButtonItem!.isEnabled = false
        self.gridViewController.addtext()
        MCGCDTimer.shared.scheduledDispatchTimer(WithTimerName: "GCDTimer", timeInterval: 5, queue: .main, repeats: true) {
            if(self.text == "loading..."){
                self.gridViewController.bezierText.show(text: self.text)
                self.text = "获取中..."
            }
            else if(self.text == "获取中..."){
                self.gridViewController.bezierText.show(text: self.text)
                self.text = "loading..."
            }
        }
            self.columns.removeAll()
            self.rows.removeAll()
            self.gridViewController.removeRow()
            let url = "https://www.xingzhu.club/XzTest/datasource/getDataSource"
            var userid:Int = UserDefaults.standard.object(forKey: "userId") as! Int
            let paras = ["userId":userid,"crawlerName":dataName] as [String : Any]
        ///循环查找当前数组中是否已经添加过该元素
        
       
            print("用户id\(userid)和数据源名\(dataName)")
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
                        self.excelrows = self.rows
                        MCGCDTimer.shared.cancleTimer(WithTimerName: "GCDTimer")
                        self.gridViewController.bezierText.removeFromSuperview()
                        self.gridViewController.setViewY(type: 0)
                        self.gridViewController.setColumns(columns: self.columns)
                        self.gridViewController.setColumd(columd: self.columd)
                        self.gridViewController.setRow(row: self.rows)
                        self.gridViewController.setPhoto(photoindex: self.phoitem)
                        //print("数据表格是\(self.rows)")
                        //print("数据表格假装是\(self.therows)")
                        self.navigationItem.rightBarButtonItem!.isEnabled = true
                        for arrayItem in self.therows {
                            self.gridViewController.addRow(row: arrayItem)
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
//    @objc func CloseClick(shopcellView: UILabel) {
//        v_datasource?.isHidden = true
//    }
//    func Setdatasource(){
//        print("hhh")
//        v_datasource?.isHidden = false
//        for i in 0..<10{
//            var a = UILabel(frame: CGRect(x:5, y: i*30, width:200, height: 30))
//            a.text = "我是标签\(i)"
//            v_datasource?.addSubview(a)
//        }
//        datasourceView?.contentSize = CGSize(width: 200,
//                                             height: 310);
//    }
    func StringtoArray(Stringvalue:String)->Array<Any>{
        //去掉无用字符
        let leftquit = Stringvalue.trimmingCharacters(in: NSCharacterSet(charactersIn: "[") as CharacterSet)
        let rightquit = leftquit.trimmingCharacters(in: NSCharacterSet(charactersIn: "]") as CharacterSet)
        var thetitle:String = "序号,\(rightquit)"
        let array = thetitle.components(separatedBy:",")
        return array
    }
    @objc func menu(_ sender: Any) {
        let items: [String] = ["导出Excel","分享到微信","分享到QQ","发送到邮箱"]
        let imgSource: [String] = ["excel","wechat","QQ","youxiang"]
        NavigationMenuShared.showPopMenuSelecteWithFrameWidth(width: itemWidth, height: 160, point: CGPoint(x: ScreenInfo.Width - 30, y: 0), item: items, imgSource: imgSource) { (index) in
            ///点击回调
            switch index{
            case 0:
                self.gridViewController.excel(excelname: self.Ntitle)
            case 1:
                self.gridViewController.wechat(excelname: self.Ntitle)
            case 2:
                self.gridViewController.QQ2(excelname: self.Ntitle)
            case 3:
                self.gridViewController.toemail(excelname: self.Ntitle)
            default:
                break
            }
        }
    }
    
    
    func showMsgbox(_message: String, _title: String = "提示"){
        
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
        
    }
}

