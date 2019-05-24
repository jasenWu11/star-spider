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
    var therow : [String] = []
    var therows : [[String]] = []
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
            columd.removeAll()
            columns.removeAll()
            self.gridViewController.setColumd(columd: self.columd)
            self.gridViewController.setColumns(columns: self.columns)
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
                        //导航栏高度
                        let nv_height = self.navigationController?.navigationBar.frame.size.height
                        //状态栏高度
                        let zt_height = UIApplication.shared.statusBarFrame.height
                        let thisheight = self.screenHeight-nv_height!-zt_height
                        let they = zt_height+nv_height!
                        self.gridViewController.setViewY(sjthey: 0,sjheight: thisheight,ctype:0)
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
        let items: [String] = ["导出Excel","分享到微信","发送到邮箱","数据内搜索","筛选数据","全部数据"]
        let imgSource: [String] = ["excel","wechat","youxiang","sousuo","QQ","quanbu"]
        NavigationMenuShared.showPopMenuSelecteWithFrameWidth(width: itemWidth, height: 160, point: CGPoint(x: ScreenInfo.Width - 30, y: 0), item: items, imgSource: imgSource) { (index) in
            ///点击回调
            switch index{
            case 0:
                self.gridViewController.excel(excelname: self.Ntitle)
            case 1:
                self.gridViewController.wechat(excelname: self.Ntitle)
            case 2:
                self.gridViewController.toemail(excelname: self.Ntitle)
            case 3:
                print("状态是\(self.gridViewController.getckzt())")
                if(self.gridViewController.getckzt() == 1){
                    self.gridViewController.setaddY()
                }
                self.viewDidAppear1()
            case 4:
                print("状态是\(self.gridViewController.getckzt())")
                if(self.gridViewController.getckzt() == 1){
                    self.gridViewController.setaddY()
                }
                self.viewDidAppear2()
            case 5:
                print("状态是\(self.gridViewController.getckzt())")
                if(self.gridViewController.getckzt() == 1){
                    self.gridViewController.setaddY()
                }
                self.rows.removeAll()
                self.therows.removeAll()
                self.DataRequet()
            default:
                break
            }
        }
    }
    @objc func viewDidAppear1(){
        
        
        let alertController = UIAlertController(title: "搜索信息",
                                                message: "请输入要搜索的信息", preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "搜索信息"
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            //也可以用下标的形式获取textField let login = alertController.textFields![0]
            let datasele = alertController.textFields!.first!
            var data = datasele.text
            //print("搜索信息：\(datasele.text)")
            if(data == ""){
                self.showMsgbox(_message: "搜索信息不能为空")
            }
            else{
                self.Datastelce(seledata: data!)
            }
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func Datastelce(seledata:String){
        var serows:[[String]] = [[]]
        var jserows:[[String]] = [[]]
        serows.removeAll()
        jserows.removeAll()
        var xuhao:[String] = []
        xuhao.removeAll()
        var xuhao1:[String] = []
        xuhao1.removeAll()
        var jse1:[String] = []
        if(self.rows.count>0){
            for index in 0...self.rows.count-1{
                var sterow:[String] = rows[index]
                for jndex in 0...sterow.count-1{
                    var item : String = sterow[jndex]
                    let stringResult = item.contains("\(seledata)")
                    if(stringResult == true){
                        if (xuhao.count>0){
                            for mndex in 0...xuhao.count-1{
                                let stringR2 = xuhao.contains(sterow[0])
                                if(stringR2 == false){
                                    serows += [sterow]
                                    xuhao += [sterow[0]]
                                }
                            }
                        }
                        else{
                            serows += [sterow]
                            xuhao += [sterow[0]]
                        }
                    }
                }
            }
            //print("最后的数组是\(serows)")
            if(serows.count>0){
                for index in 0...serows.count-1{
                    print("s只是第\(index+1)次访问")
                    var xjsz = serows[index]
                    var row0:String = xjsz[0]
                    var row2:String = xjsz[2]
                    var xxjsz:[String] = []
                    xxjsz += [row0]
                    xxjsz += [row2]
                    print("小贾数组\(xxjsz)")
                    jserows += [xxjsz]
                }
            }
            
            //print("最后的假数组是\(jserows)")
            var xbt:[String] = []
            xbt.removeAll()
            self.gridViewController.setColumns(columns: xbt)
            self.gridViewController.setColumd(columd: xbt)
            self.rows = serows
            self.therows = jserows
            self.gridViewController.removeRow()
            self.excelrows = self.rows
            MCGCDTimer.shared.cancleTimer(WithTimerName: "GCDTimer")
            self.gridViewController.bezierText.removeFromSuperview()
            //导航栏高度
            let nv_height = self.navigationController?.navigationBar.frame.size.height
            //状态栏高度
            let zt_height = UIApplication.shared.statusBarFrame.height
            let thisheight = self.screenHeight-nv_height!-zt_height
            let they = zt_height+nv_height!
            self.gridViewController.setViewY(sjthey: 0,sjheight: thisheight,ctype:0)
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
    @objc func viewDidAppear2(){
        
        
        let alertController = UIAlertController(title: "搜索信息",
                                                message: "请输入要筛除的信息", preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "筛除信息"
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            //也可以用下标的形式获取textField let login = alertController.textFields![0]
            let datasele = alertController.textFields!.first!
            var data = datasele.text
            //print("筛除信息：\(datasele.text)")
            if(data == ""){
                self.showMsgbox(_message: "筛除信息不能为空")
            }
            else{
                self.Dataquit(seledata: data!)
            }
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func Dataquit(seledata:String){
        var serows:[[String]] = [[]]
        var jserows:[[String]] = [[]]
        serows.removeAll()
        jserows.removeAll()
        var xuhao:[String] = []
        xuhao.removeAll()
        var xuhao1:[String] = []
        xuhao1.removeAll()
        var jse1:[String] = []
        //print("数组\(rows)的行数为\(rows.count)")
        var count:Int = 0
        if(self.rows.count>0){
            for index in 0...100000{
                if(index<rows.count+count){
                print("\(index)所有数据量\(self.rows.count-1),删除了\(count)行")
                    //print("检索到\(index),数据量剩下\(self.rows.count)，删除了\(count)")
                    var sterow:[String] = rows[index-count]
                    for jndex in 0...sterow.count-1{
                        var item : String = sterow[jndex]
                        let stringResult = item.contains("\(seledata)")
                        if(stringResult == true){
                            print("删除的是\(index)")
                            rows.remove(at: index-count)
                            therows.remove(at: index-count)
                            count += 1
                            break
                        }
                    }
                }
            }
            self.gridViewController.setColumns(columns: [])
            self.gridViewController.setColumd(columd: [])
            self.gridViewController.removeRow()
            self.excelrows = self.rows
            MCGCDTimer.shared.cancleTimer(WithTimerName: "GCDTimer")
            self.gridViewController.bezierText.removeFromSuperview()
            //导航栏高度
            let nv_height = self.navigationController?.navigationBar.frame.size.height
            //状态栏高度
            let zt_height = UIApplication.shared.statusBarFrame.height
            let thisheight = self.screenHeight-nv_height!-zt_height
            let they = zt_height+nv_height!
            self.gridViewController.setViewY(sjthey: 0,sjheight: thisheight,ctype:0)
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
    func showMsgbox(_message: String, _title: String = "提示"){
        
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
        
    }
}

