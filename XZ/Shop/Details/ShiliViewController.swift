//
//  ShiliViewController.swift
//  XZ
//
//  Created by wjz on 2019/1/24.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit
<<<<<<< HEAD
import Alamofire
class ShiliViewController: UIViewController{
    @IBOutlet weak var ni_title: UINavigationItem!
    @IBOutlet weak var bt_com: UIButton!
    @IBOutlet weak var tf_data: UITextField!
    @IBOutlet weak var l_key: UILabel!
    var iskey:Int = 0
    var Ntitle:String = ""
    var dataName:String = ""
    var gridViewController: UICollectionGridViewController!
    var columns:[String] = ["编号","客户", "消费金额", "消费次数", "满意度","搞笑"]
    var columd:[String] = ["编号","客户", "消费金额", "消费次数", "满意度","搞笑"]
    var row1:[String] = ["No.01","hangge", "100", "8", "60%","11"]
    var rows:[[String]] = []
    var row:[String] = []
    var therow : [Any] = []
    var therows : [[Any]]! = []
    var qdata:String = ""
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    var titless:[String] = []
    //    var v_datasource : UIView?
    //    var datasourceView : UIScrollView?
    //    var iv_close:UIButton?
    //    var height:Int = 0
    var phoitem:Int = -1
    
    var root : APImessViewController?
=======

class ShiliViewController: UIViewController {
    var root : APImessViewController?
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
    var pids:Int = 0
    var shiliView : UIView?
    var tv_shili : UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD
        
        //ni_title.title = Ntitle
        bt_com?.backgroundColor=UIColorRGB_Alpha(R: 91.0, G: 84.0, B: 145.0, alpha: 0.8);
        bt_com?.clipsToBounds=true
        bt_com?.layer.shadowColor = UIColor.gray.cgColor
        bt_com?.layer.shadowOpacity = 1.0
        bt_com?.layer.shadowOffset = CGSize(width: 0, height: 0)
        bt_com?.layer.shadowRadius = 4
        bt_com?.layer.masksToBounds = false
        gridViewController = UICollectionGridViewController()
        
        view.addSubview(self.gridViewController.view)
        
        
        getProductCase()
        
        view.backgroundColor = UIColorRGB_Alpha(R: 238.0, G: 238.0, B: 238.0, alpha: 1.0);
        // Do any additional setup after loading the view.
//        //返回示例视图
//        shiliView = UIView(frame: CGRect(x:0, y: 0, width:screenWidth, height: 40))
//        shiliView?.backgroundColor=UIColorRGB_Alpha(R: 50.0, G: 184.0, B: 208.0, alpha: 0.8);
//        shiliView?.clipsToBounds=true
//        shiliView?.layer.shadowColor = UIColor.gray.cgColor
//        shiliView?.layer.shadowOpacity = 1.0
//        shiliView?.layer.shadowOffset = CGSize(width: 0, height: 0)
//        shiliView?.layer.shadowRadius = 4
//        shiliView?.layer.masksToBounds = false
//        view.addSubview(shiliView!)
//        //返回示例标签
//        tv_shili = UILabel(frame: CGRect(x:10, y: 5, width:screenWidth-20, height: 30))
//        tv_shili?.font = UIFont.systemFont(ofSize: 18)
//        tv_shili?.textColor = UIColor.black
//        tv_shili?.numberOfLines = 0
//        tv_shili?.lineBreakMode = NSLineBreakMode.byWordWrapping
//        shiliView?.addSubview(tv_shili!)
//        tv_shili?.text = "返回数据示例"
//        tv_shili?.textAlignment=NSTextAlignment.left
    }
    override func viewDidLayoutSubviews() {
        gridViewController.view.frame = CGRect(x:0, y:0, width:view.frame.width,
                                               height:view.frame.height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    func getProductCase() {
        
        self.columns.removeAll()
        self.rows.removeAll()
        self.gridViewController.removeRow()
        let url = "https://www.xingzhu.club/XzTest/products/getProductCase"
        var userid:Int = UserDefaults.standard.object(forKey: "userId") as! Int
        let paras = ["userId":userid,"productId":pids] as [String : Any]
        ///循环查找当前数组中是否已经添加过该元素
        
        
        print("用户id\(userid)和产品ID\(pids)")
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
                let titlemess = json["title"].string ?? ""
                //设置表头
                if(titlemess != ""){
                    self.columd = self.StringtoArray(Stringvalue: titlemess) as! [String]
                }
                //简约式表头
                var row0:String = self.columd[0]
                var row2:String = self.columd[2]
                self.columns += [row0]
                self.columns += [row2]
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
                    //导航栏状态栏高度
                    let getheight = self.root?.thesly
                    let theheight = self.screenHeight-getheight!-50-55
                    let they = getheight!+50
                    self.gridViewController.setViewY(sjthey: 0, sjheight: theheight,ctype:1)
                    self.gridViewController.setColumns(columns: self.columns)
                    self.gridViewController.setColumd(columd: self.columd)
                    self.gridViewController.setRow(row: self.rows)
                    self.gridViewController.setPhoto(photoindex: self.phoitem)
                    //print("数据表格是\(self.rows)")
                    //print("数据表格假装是\(self.therows)")
                    for arrayItem in self.therows {
                        self.gridViewController.addRow(row: arrayItem)
                    }
                    //self.gridViewController.sortDelegate = self
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

=======
        view.backgroundColor = UIColorRGB_Alpha(R: 238.0, G: 238.0, B: 238.0, alpha: 0.8);
        // Do any additional setup after loading the view.
        //返回示例视图
        shiliView = UIView(frame: CGRect(x:0, y: 0, width:screenWidth, height: 40))
        shiliView?.backgroundColor=UIColorRGB_Alpha(R: 50.0, G: 184.0, B: 208.0, alpha: 0.8);
        shiliView?.clipsToBounds=true
        shiliView?.layer.shadowColor = UIColor.gray.cgColor
        shiliView?.layer.shadowOpacity = 1.0
        shiliView?.layer.shadowOffset = CGSize(width: 0, height: 0)
        shiliView?.layer.shadowRadius = 4
        shiliView?.layer.masksToBounds = false
        view.addSubview(shiliView!)
        //返回示例标签
        tv_shili = UILabel(frame: CGRect(x:10, y: 5, width:screenWidth-20, height: 30))
        tv_shili?.font = UIFont.systemFont(ofSize: 18)
        tv_shili?.textColor = UIColor.black
        tv_shili?.numberOfLines = 0
        tv_shili?.lineBreakMode = NSLineBreakMode.byWordWrapping
        shiliView?.addSubview(tv_shili!)
        tv_shili?.text = "返回数据示例"
        tv_shili?.textAlignment=NSTextAlignment.left
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
    /// 设置颜色与透明度（RGB：0.0~255.0；alpha：0.0~1.0） 示例：UIColorRGB_Alpha(100.0, 100.0, 20.0, 1.0)
    func UIColorRGB_Alpha(R:CGFloat, G:CGFloat, B:CGFloat, alpha:CGFloat) -> UIColor
    {
        let color = UIColor.init(red: (R / 255.0), green: (G / 255.0), blue: (B / 255.0), alpha: alpha);
        return color;
    }
}
