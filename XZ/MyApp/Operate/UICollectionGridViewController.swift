//
//  UICollectionGridViewController.swift
//  hangge_1081
//
//  Created by hangge on 2016/11/19.
//  Copyright © 2016年 hangge.com. All rights reserved.
//

import Foundation
import UIKit
import MessageUI
import MobileCoreServices
import SafariServices

//多列表格组v件（通过CollectionView实现）
class UICollectionGridViewController: UICollectionViewController ,MFMailComposeViewControllerDelegate{
    //表头数据
    var cols: [String]! = []
    //行数据
    var rows: [[Any]]! = []
    //实际表头数据
    var colum :[String]! = []
    let datav = DataSourceViewController()
    //排序代理
    //weak var sortDelegate: UICollectionGridViewSortDelegate?
    
    //选中的表格列（-1表示没有选中的）
    private var selectedColIdx = -1
    //列排序顺序
    private var asc = true
    var v_datasource : UIButton?
    var datasourceView : UIScrollView?
    var iv_close:UIButton?
    //var bt_min:UIButton?
    var bt_left:UIButton?
    var bt_right:UIButton?
    var sw_bj:UISwitch?
    var bt_save:UIButton?
    var height:Int = 0
    var they:Int = 0
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    var rowdata:[String] = []
    var row1 : String = ""
    var row2 : String = ""
    var therow : [[Any]]! = []
    var phoitem:Int = -1
    var page:Int = 0
    var xiangqing:Int = 0
    var safariurl:String = ""
    var _scene = Int32(WXSceneSession.rawValue)
    var _tencentOAuth:TencentOAuth!
    //动画
    var bezierText:BezierText!
    var v_web:UIView?
    var smallImage:UIImage?
    var emailph:String = ""
    var alltext:[UITextView] = []
    var zhongjihei:CGFloat = 0.0
    var tczt:Int = 0
    var xg_view:UIView?
    init() {
        
        //初始化表格布局
        let layout = UICollectionGridViewLayout()
        super.init(collectionViewLayout: layout)
        layout.viewController = self
        collectionView!.backgroundColor = UIColor.white
        collectionView!.register(UICollectionGridViewCell.self,
                                 forCellWithReuseIdentifier: "cell")
        collectionView!.delegate = self
        collectionView!.dataSource = self
        collectionView!.isDirectionalLockEnabled = true
        //collectionView!.contentInset = UIEdgeInsetsMake(0, 10, 0, 10)
        collectionView!.bounces = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("UICollectionGridViewController.init(coder:) has not been implemented")
    }
    
    //设置列头数据
    func setColumns(columns: [String]) {
        cols = columns
    }
    
    //设置列头实际数据
    func setColumd(columd: [String]) {
        colum = columd
    }
    
    //添加行数据
    
    func addRow(row: [Any]) {
        rows.append(row)
        collectionView!.collectionViewLayout.invalidateLayout()
        collectionView!.reloadData()
    }
    //添加真的行数据
    
    func addRows(row: [Any]) {
        therow.append(row)
        collectionView!.collectionViewLayout.invalidateLayout()
        collectionView!.reloadData()
    }
    
    //添加实际行数据
    func setRow(row: [[Any]]) {
        therow = row
        //print("真正数据为\(therow)")
    }
    
    func setPhoto(photoindex: Int) {
        phoitem = photoindex
    }
    
    //清空行数据
    func removeRow() {
        rows.removeAll()
        collectionView!.collectionViewLayout.invalidateLayout()
        collectionView!.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(UICollectionGridViewController.keyboardWillChangeFrame), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UICollectionGridViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        //获取屏幕大小
        let screenSize : CGSize = UIScreen.main.bounds.size
        
        _tencentOAuth = TencentOAuth.init(appId: "101552319", andDelegate: nil)
        //初始化文字笔迹书写组件
        bezierText = BezierText(frame: CGRect(x: 0, y: 160,
                                              width: self.view.bounds.width, height: 50))
        
        v_datasource = UIButton(frame: CGRect(x:0, y: screenHeight, width:screenWidth, height: screenHeight/5*3))
        v_datasource?.backgroundColor=UIColor.white
        v_datasource?.clipsToBounds=true
        v_datasource?.layer.cornerRadius = 3
        v_datasource?.layer.shadowColor = UIColor.gray.cgColor
        v_datasource?.layer.shadowOpacity = 1.0
        v_datasource?.layer.shadowOffset = CGSize(width: 0, height: 0)
        v_datasource?.layer.shadowRadius = 4
        v_datasource?.layer.masksToBounds = false
        v_datasource?.addTarget(self, action: #selector(maxClick), for: UIControl.Event.touchUpInside)
        view.addSubview(v_datasource!)
        //v_datasource?.isHidden = true
        
        
        let handRight = UISwipeGestureRecognizer(target: self, action: #selector(funRight))
        //handLeftRight.direction = .left //支持向左
        
        let handLeft = UISwipeGestureRecognizer(target: self, action: #selector(funLeft))
        handLeft.direction = .left //支持向左
        
        let handdown = UISwipeGestureRecognizer(target: self, action: #selector(funDown))
        handdown.direction = .down //支持向下
        
        let webdown = UISwipeGestureRecognizer(target: self, action: #selector(closewebView))
        webdown.direction = .down //支持向下
        
        v_datasource?.addGestureRecognizer(handRight)
        v_datasource?.addGestureRecognizer(handLeft)
        v_datasource?.addGestureRecognizer(handdown)
        //关闭按钮
        iv_close = UIButton(frame: CGRect(x:10, y: 8, width:30, height: 30))
        iv_close?.setImage(UIImage(named:"close"), for: .normal)
        iv_close?.addTarget(self, action: #selector(CloseClick), for: UIControl.Event.touchUpInside)
        v_datasource?.addSubview(iv_close!)
        //最小化按钮
//        bt_min = UIButton(frame: CGRect(x:50, y: 8, width:30, height: 30))
//        bt_min?.setImage(UIImage(named:"min"), for: .normal)
//        bt_min?.addTarget(self, action: #selector(minClick), for: UIControl.Event.touchUpInside)
//        v_datasource?.addSubview(bt_min!)
        
        
        bt_left = UIButton(frame: CGRect(x:(v_datasource?.frame.size.width)!-100-30, y: 8, width:30, height: 30))
        bt_left?.setImage(UIImage(named:"left"), for: .normal)
        bt_left?.addTarget(self, action: #selector(funbuttonRight(sender:)), for: UIControl.Event.touchUpInside)
        v_datasource?.addSubview(bt_left!)
        
        bt_right = UIButton(frame: CGRect(x:(v_datasource?.frame.size.width)!-30-20, y: 8, width:30, height: 30))
        bt_right?.setImage(UIImage(named:"right"), for: .normal)
        bt_right?.addTarget(self, action: #selector(funbuttonLeft(sender:)), for: UIControl.Event.touchUpInside)
        v_datasource?.addSubview(bt_right!)
        datasourceView = UIScrollView(frame: CGRect(x:0, y: 40, width:screenWidth, height: (v_datasource?.frame.size.height)!-40))
        datasourceView?.backgroundColor=UIColor.white
        datasourceView?.clipsToBounds=true
        datasourceView?.layer.cornerRadius = 3
        datasourceView?.layer.shadowColor = UIColor.gray.cgColor
        datasourceView?.layer.shadowOpacity = 1.0
        datasourceView?.layer.shadowOffset = CGSize(width: 0, height: 0)
        datasourceView?.layer.shadowRadius = 4
        datasourceView?.layer.masksToBounds = false
        //datasourceView?.addTarget(self, action: #selector(composeBtnClick), for: UIControl.Event.touchUpInside)
        v_datasource?.addSubview(datasourceView!)
        
        //是否可以滚动
        datasourceView?.isScrollEnabled = true
        //垂直方向反弹
        datasourceView?.alwaysBounceVertical = true
        //垂直方向是否显示滚动条
        datasourceView?.showsVerticalScrollIndicator = false
        datasourceView?.clipsToBounds = true
        
        let zt_height = UIApplication.shared.statusBarFrame.height
        let dh_height = (zt_height==44 ? 44 : 20)
        let nv_height = CGFloat((dh_height))
        //弹出视图
        v_web = UIView(frame: CGRect(x:0, y: screenHeight, width:screenWidth, height: screenHeight-nv_height-zt_height))
        v_web?.backgroundColor = UIColor.white
        view.addSubview(v_web!)
        v_web?.addGestureRecognizer(webdown)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidLayoutSubviews() {
        collectionView!.frame = CGRect(x:0, y:0,
                                       width:view.frame.width, height:view.frame.height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //返回表格总行数
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        if cols.isEmpty {
            return 0
        }
        //总行数是：记录数＋1个表头
        return rows.count + 1
        
    }
    
    //返回表格的列数
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return cols.count
    }
    
    //单元格内容创建
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as! UICollectionGridViewCell
        
        //设置列头单元格，内容单元格的数据
        if indexPath.section == 0 {
            cell.label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
            cell.label.text = cols[indexPath.row]
            cell.label.textColor = UIColor.white
        } else {
            cell.label.font = UIFont.systemFont(ofSize: 15)
            cell.label.text = "\(rows[indexPath.section-1][indexPath.row])"
            cell.label.textColor = UIColor.black
        }
        
        //表头单元格背景色
        if indexPath.section == 0 {
            cell.backgroundColor = UIColor(red: 91.0/255, green: 84.0/255,
                                           blue: 145.0/255, alpha: 1)
            //排序列列头显示升序降序图标
            if indexPath.row == selectedColIdx {
                let iconType = asc ? FAType.FALongArrowUp : FAType.FALongArrowDown
                cell.imageView.setFAIconWithName(icon: iconType, textColor: UIColor.white)
            }else{
                cell.imageView.image = nil
            }
        }
            //内容单元格背景色
        else {
            //排序列的单元格背景会变色
            if indexPath.row == selectedColIdx {
                //排序列的单元格背景会变色
                cell.backgroundColor = UIColor(red: 0xCC/255, green: 0xF8/255,
                                               blue: 0xFF/255, alpha: 1)
            }
                //数据区域每行单元格背景色交替显示
            else if indexPath.section % 2 == 0 {
                cell.backgroundColor = UIColor(white: 242/255.0, alpha: 1)
            } else {
                cell.backgroundColor = UIColor.white
            }
        }
        
        return cell
    }
    
    //单元格选中事件
    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        //打印出点击单元格的［行,列］坐标
        print("点击单元格的[行,列]坐标: [\(indexPath.section),\(indexPath.row)]")
//        if indexPath.section == 0 && sortDelegate != nil {
//            //如果点击的是表头单元格，则默认该列升序排列，再次点击则变降序排列，以此交替
//            asc = (selectedColIdx != indexPath.row) ? true : !asc
//            selectedColIdx = indexPath.row
//            rows = sortDelegate?.sort(colIndex: indexPath.row, asc: asc, rows: rows)
//            collectionView.reloadData()
//        }
        if(indexPath.section>0){
            if (xiangqing == 0) {
               UIView.animate(withDuration: 0.4) {
                    self.v_datasource?.center.y -= self.screenHeight
                self.tczt = 1
                }
            xiangqing = 1
            }
            self.Setdatasource(section: indexPath.section)
        }
    }
    func showMsgbox(_message: String, _title: String = "数据"){
        
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
        
    }
    @objc func CloseClick() {
        self.v_datasource?.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.4) {
            self.v_datasource?.center.y += self.screenHeight
            self.tczt = 0
        }
        xiangqing = 0
    }
//    @objc func minClick() {
//        UIView.animate(withDuration: 0.6) {
//            self.v_datasource?.transform = CGAffineTransform.identity
//                .translatedBy(x: -100, y: 0)
//                //.rotated(by:CGFloat(Double.pi/4))
//                .scaledBy(x: 0.5, y: 0.5)
//        }
//        //v_datasource?.isHidden = true
//    }
    @objc func maxClick() {
        UIView.animate(withDuration: 0.6) {
            self.v_datasource?.transform = CGAffineTransform.identity
                .translatedBy(x: 0, y: 0)
                //.rotated(by:CGFloat(Double.pi/4))
                .scaledBy(x: 1, y: 1)
        }
    }
    func Setdatasource(section:Int){
        bt_save?.isHidden = true
        sw_bj?.isOn = false
        if(section>0){
            self.page = section
            //print("列数是\(self.colum.count)")
            v_datasource?.isHidden = false
            //print("表头数据\(self.colum)")
            //先清除datasourceView视图下所有子视图，避免叠加
            let chilrenviews = datasourceView?.subviews
            
            for chilren in chilrenviews! {
                
                chilren.removeFromSuperview()
                
            }
            they = 0
            rowdata = self.therow[section-1] as! [String]
            if(phoitem != -1){
                print("第\(phoitem)列")
                print(self.rowdata[phoitem])
                var Imageurl = self.rowdata[phoitem]
                // 图片
                
                if(Imageurl != ""&&Imageurl != "null"){
                    let stringResult = Imageurl.contains("http")
                    print("\(index)包含图吗？\(stringResult)")
                    if(stringResult == true){
                        var dataImage = UIImageView(frame: CGRect(x:0, y: they, width:Int((datasourceView?.frame.size.width)!), height: Int((datasourceView?.frame.size.width)!)))
                        dataImage.contentMode = UIView.ContentMode.scaleAspectFit
                        let url = URL(string:Imageurl)
                        if let data = try? Data(contentsOf: url!){
                            smallImage = UIImage(data: data)
                            dataImage.image = smallImage
                            datasourceView?.addSubview(dataImage)
                            they=they+Int((dataImage.frame.size.height)+10)
                        }
                        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressClick))
                        dataImage.isUserInteractionEnabled = true
                        dataImage.addGestureRecognizer(longPress)
                    }
                }
                
            }
            //print("行\(rowdata)")
            for i in 0..<colum.count{
                var long = self.colum[i].count
                if (long>5){
                    var a = UILabel(frame: CGRect(x:10, y: they, width:105, height: 30))
                    a.text = self.colum[i]
                    a.font = UIFont.systemFont(ofSize: 16)
                    a.textColor = UIColor(red: 91.0/225.0, green: 84.0/225.0, blue: 145.0/225.0, alpha: 1.0)
                    a.layer.cornerRadius = 3
                    a.layer.borderWidth = 1
                    a.layer.borderColor = UIColor(red: 91.0/225.0, green: 84.0/225.0, blue: 145.0/225.0, alpha: 1.0).cgColor
                    a.layer.masksToBounds = true
                    a.textAlignment = .center
                    they=they+35
                    datasourceView?.addSubview(a)
                }
                else{
                    var a = UILabel(frame: CGRect(x:10, y: they, width:90, height: 30))
                    a.text = self.colum[i]
                    a.font = UIFont.systemFont(ofSize: 16)
                    a.textColor = UIColor(red: 91.0/225.0, green: 84.0/225.0, blue: 145.0/225.0, alpha: 1.0)
                    a.layer.cornerRadius = 3
                    a.layer.borderWidth = 1
                    a.layer.borderColor = UIColor(red: 91.0/225.0, green: 84.0/225.0, blue: 145.0/225.0, alpha: 1.0).cgColor
                    a.layer.masksToBounds = true
                    a.textAlignment = .center
                    they=they+35
                    datasourceView?.addSubview(a)
                }
                if(i == 1){
                    var b = UIButton(frame: CGRect(x:Int((datasourceView?.frame.size.width)!-120), y: they-35, width:110, height: 30))
                    b.setTitle("跳转链接", for: .normal)
                    b.backgroundColor = UIColor(red: 91.0/225.0, green: 84.0/225.0, blue: 145.0/225.0, alpha: 1.0)
                    b.setTitleColor(UIColor.white, for: .normal)
                    b.layer.cornerRadius = 3
                    b.layer.borderWidth = 1
                    b.layer.masksToBounds = true
                    b.setImage(UIImage(named: "jumpto"), for: .normal)
                    b.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
                    b.addTarget(self, action: #selector(toweburl), for: UIControl.Event.touchUpInside)
                    datasourceView?.addSubview(b)
                }
                //print("字符串长度为\(self.rowdata[i].count)")
                var strcou = self.rowdata[i].count
                if(strcou<=13){
                    var b = CanCopyLabel(frame: CGRect(x:Int((datasourceView?.frame.size.width)!-20)/2-40, y: they-35, width:Int((datasourceView?.frame.size.width)!-20)+40, height: 30))
                    b.text = self.rowdata[i]
                    b.font = UIFont.systemFont(ofSize: 16)
                    b.textColor = UIColor.black
                    datasourceView?.addSubview(b)
                }
                if(strcou>13&&strcou<=20){
                    var b = CanCopyLabel(frame: CGRect(x:10, y: they, width:Int((datasourceView?.frame.size.width)!-20), height: 30))
                    b.text = self.rowdata[i]
                    b.font = UIFont.systemFont(ofSize: 16)
                    b.textColor = UIColor.black
                    they=they+Int((b.frame.size.height)+5)
                    datasourceView?.addSubview(b)
                }
                else if(strcou<=60 && strcou>20){
                    var b = UITextView(frame: CGRect(x:10, y: they, width:Int((datasourceView?.frame.size.width)!-20), height: 60))
                    b.text = self.rowdata[i]
                    b.font = UIFont.systemFont(ofSize: 16)
                    b.textColor = UIColor.black
                    b.isEditable = false
                    b.backgroundColor = UIColor(red: 91.0/225.0, green: 84.0/225.0, blue: 145.0/225.0, alpha: 0.2)
                    they=they+Int((b.frame.size.height)+5)
                    datasourceView?.addSubview(b)
                }
                else if(strcou<=100 && strcou>60){
                    var b = UITextView(frame: CGRect(x:10, y: they, width:Int((datasourceView?.frame.size.width)!-20), height: 90))
                    b.text = self.rowdata[i]
                    b.font = UIFont.systemFont(ofSize: 16)
                    b.textColor = UIColor.black
                    b.isEditable = false
                    b.backgroundColor = UIColor(red: 91.0/225.0, green: 84.0/225.0, blue: 145.0/225.0, alpha: 0.2)
                    they=they+Int((b.frame.size.height)+5)
                    datasourceView?.addSubview(b)
                }
                else if(strcou>100){
                    var b = UITextView(frame: CGRect(x:10, y: they, width:Int((datasourceView?.frame.size.width)!-20), height: 150))
                    b.text = self.rowdata[i]
                    b.font = UIFont.systemFont(ofSize: 16)
                    b.textColor = UIColor.black
                    b.isEditable = false
                    b.backgroundColor = UIColor(red: 91.0/225.0, green: 84.0/225.0, blue: 145.0/225.0, alpha: 0.2)
                    they=they+Int((b.frame.size.height)+5)
                    datasourceView?.addSubview(b)
                }
            }
            datasourceView?.contentSize = CGSize(width: 200,
                                                 height: they);
        }
    }
    func Setdatasource2(section:Int){
        alltext.removeAll()
        if(section>0){
            self.page = section
            //print("列数是\(self.colum.count)")
            v_datasource?.isHidden = false
            //print("表头数据\(self.colum)")
            //先清除datasourceView视图下所有子视图，避免叠加
            let chilrenviews = datasourceView?.subviews
            
            for chilren in chilrenviews! {
                
                chilren.removeFromSuperview()
                
            }
            they = 0
            rowdata = self.therow[section-1] as! [String]
            if(phoitem != -1){
                print("第\(phoitem)列")
                print(self.rowdata[phoitem])
                var Imageurl = self.rowdata[phoitem]
                // 图片
                if(Imageurl != ""&&Imageurl != "null"){
                    let stringResult = Imageurl.contains("http")
                    print("\(index)包含图吗？\(stringResult)")
                    if(stringResult == true){
                        var dataImage = UIImageView(frame: CGRect(x:0, y: they, width:Int((datasourceView?.frame.size.width)!), height: Int((datasourceView?.frame.size.width)!)))
                        dataImage.contentMode = UIView.ContentMode.scaleAspectFit
                        let url = URL(string:Imageurl)
                        if let data = try? Data(contentsOf: url!){
                            smallImage = UIImage(data: data)
                            dataImage.image = smallImage
                            datasourceView?.addSubview(dataImage)
                            they=they+Int((dataImage.frame.size.height)+10)
                        }
                        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressClick))
                        dataImage.isUserInteractionEnabled = true
                        dataImage.addGestureRecognizer(longPress)
                    }
                }
                
            }
            //print("行\(rowdata)")
            for i in 0..<colum.count{
                var long = self.colum[i].count
                if (long>5){
                    var a = UILabel(frame: CGRect(x:10, y: they, width:105, height: 30))
                    a.text = self.colum[i]
                    a.font = UIFont.systemFont(ofSize: 16)
                    a.textColor = UIColor(red: 91.0/225.0, green: 84.0/225.0, blue: 145.0/225.0, alpha: 1.0)
                    a.layer.cornerRadius = 3
                    a.layer.borderWidth = 1
                    a.layer.borderColor = UIColor(red: 91.0/225.0, green: 84.0/225.0, blue: 145.0/225.0, alpha: 1.0).cgColor
                    a.layer.masksToBounds = true
                    a.textAlignment = .center
                    they=they+35
                    datasourceView?.addSubview(a)
                }
                else{
                    var a = UILabel(frame: CGRect(x:10, y: they, width:90, height: 30))
                    a.text = self.colum[i]
                    a.font = UIFont.systemFont(ofSize: 16)
                    a.textColor = UIColor(red: 91.0/225.0, green: 84.0/225.0, blue: 145.0/225.0, alpha: 1.0)
                    a.layer.cornerRadius = 3
                    a.layer.borderWidth = 1
                    a.layer.borderColor = UIColor(red: 91.0/225.0, green: 84.0/225.0, blue: 145.0/225.0, alpha: 1.0).cgColor
                    a.layer.masksToBounds = true
                    a.textAlignment = .center
                    they=they+35
                    datasourceView?.addSubview(a)
                }
                if(i == 1){
                    var b = UIButton(frame: CGRect(x:Int((datasourceView?.frame.size.width)!-120), y: they-35, width:110, height: 30))
                    b.setTitle("跳转链接", for: .normal)
                    b.backgroundColor = UIColor(red: 91.0/225.0, green: 84.0/225.0, blue: 145.0/225.0, alpha: 1.0)
                    b.setTitleColor(UIColor.white, for: .normal)
                    b.layer.cornerRadius = 3
                    b.layer.borderWidth = 1
                    b.layer.masksToBounds = true
                    b.setImage(UIImage(named: "jumpto"), for: .normal)
                    b.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
                    b.addTarget(self, action: #selector(toweburl), for: UIControl.Event.touchUpInside)
                    datasourceView?.addSubview(b)
                }
                //print("字符串长度为\(self.rowdata[i].count)")
                var strcou = self.rowdata[i].count
                if(strcou<=13){
                    var b = UITextView(frame: CGRect(x:Int((datasourceView?.frame.size.width)!-20)/2-40, y: they-35, width:Int((datasourceView?.frame.size.width)!-20)+40, height: 30))
                    b.text = self.rowdata[i]
                    b.font = UIFont.systemFont(ofSize: 16)
                    b.textColor = UIColor.black
                    b.isScrollEnabled = false
                    datasourceView?.addSubview(b)
                    alltext += [b]
                    if(i == 0){
                        b.isEditable = false
                    }
                }
                if(strcou>13&&strcou<=20){
                    var b = UITextView(frame: CGRect(x:10, y: they, width:Int((datasourceView?.frame.size.width)!-20), height: 30))
                    b.text = self.rowdata[i]
                    b.font = UIFont.systemFont(ofSize: 16)
                    b.textColor = UIColor.black
                    they=they+Int((b.frame.size.height)+5)
                    datasourceView?.addSubview(b)
                    alltext += [b]
                }
                else if(strcou<=60 && strcou>20){
                    var b = UITextView(frame: CGRect(x:10, y: they, width:Int((datasourceView?.frame.size.width)!-20), height: 60))
                    b.text = self.rowdata[i]
                    b.font = UIFont.systemFont(ofSize: 16)
                    b.textColor = UIColor.black
                    b.backgroundColor = UIColor(red: 91.0/225.0, green: 84.0/225.0, blue: 145.0/225.0, alpha: 0.2)
                    they=they+Int((b.frame.size.height)+5)
                    datasourceView?.addSubview(b)
                    alltext += [b]
                }
                else if(strcou<=100 && strcou>60){
                    var b = UITextView(frame: CGRect(x:10, y: they, width:Int((datasourceView?.frame.size.width)!-20), height: 90))
                    b.text = self.rowdata[i]
                    b.font = UIFont.systemFont(ofSize: 16)
                    b.textColor = UIColor.black
                    b.backgroundColor = UIColor(red: 91.0/225.0, green: 84.0/225.0, blue: 145.0/225.0, alpha: 0.2)
                    they=they+Int((b.frame.size.height)+5)
                    datasourceView?.addSubview(b)
                    alltext += [b]
                }
                else if(strcou>100){
                    var b = UITextView(frame: CGRect(x:10, y: they, width:Int((datasourceView?.frame.size.width)!-20), height: 150))
                    b.text = self.rowdata[i]
                    b.font = UIFont.systemFont(ofSize: 16)
                    b.textColor = UIColor.black
                    b.backgroundColor = UIColor(red: 91.0/225.0, green: 84.0/225.0, blue: 145.0/225.0, alpha: 0.2)
                    they=they+Int((b.frame.size.height)+5)
                    datasourceView?.addSubview(b)
                    alltext += [b]
                }
            }
            datasourceView?.contentSize = CGSize(width: 200,
                                                 height: they);
        }
    }
    func setViewY(sjthey:CGFloat,sjheight:CGFloat,ctype:Int){
        if(ctype == 1){
            v_datasource!.frame.origin.y = sjthey+screenHeight
            v_datasource!.frame.size.height = sjheight
            zhongjihei = sjheight
            datasourceView!.frame.size.height = sjheight-40
            let vwidth = v_datasource?.frame.size.width
            let vheight = v_datasource?.frame.size.height
        }else{
            v_datasource!.frame.origin.y = sjthey+screenHeight
            v_datasource!.frame.size.height = sjheight
            zhongjihei = sjheight
            datasourceView!.frame.size.height = sjheight-80
            let vwidth = v_datasource?.frame.size.width
            let vheight = v_datasource?.frame.size.height
            xg_view = UIView(frame: CGRect(x:(vwidth!-120)/2, y: vheight!-35, width:80, height: 30))
            v_datasource?.addSubview(xg_view!)
            var l_xiugai = UILabel(frame: CGRect(x:0, y: 0, width:40, height: 30))
            l_xiugai.text = "编辑"
            xg_view?.addSubview(l_xiugai)
            sw_bj = UISwitch(frame: CGRect(x:40, y: 0, width:80, height: 30))
            //添加状态变化监听器
            sw_bj?.addTarget(self, action: #selector(switchDidChange(_:)), for: .valueChanged)
            xg_view?.addSubview(sw_bj!)
            bt_save = UIButton(frame: CGRect(x:vwidth!-90, y: vheight!-35, width:80, height: 30))
            bt_save?.backgroundColor = UIColor(red: 91.0/255.0, green: 84.0/255.0, blue: 145.0/255.0, alpha: 0.7)
            bt_save?.setTitle("保存修改", for: .normal)
            bt_save?.isHidden = true
            v_datasource?.addSubview(bt_save!)
            bt_save?.addTarget(self, action: #selector(saveData), for: UIControl.Event.touchUpInside)
            //        if(type == 1){
            //            v_datasource!.frame.origin.y = screenHeight/5-84+screenHeight // 获取坐标Y
            //        }
            //        else if(type == 0){
            //            v_datasource!.frame.origin.y = screenHeight/5-64+screenHeight  // 获取坐标Y
            //            //修改视图高度
            //            v_datasource!.frame.size.height += 40
            //            datasourceView!.frame.size.height += 40
            //        }
        }
    }
    func setaddY(){
        v_datasource?.frame.origin.y = self.screenHeight
        print("窗口y值为\(v_datasource?.frame.origin.y)")
        xiangqing = 0
    }
    func getckzt() -> Int {
        return tczt
    }
    @objc func switchDidChange(_ sender: UISwitch){
        //打印当前值
        print(sender.isOn)
        if(sender.isOn == true) {
            Setdatasource2(section: page)
            //rowdata = self.therow[page-1] as! [String]
            //print("该行数据是\(rowdata)")
            bt_save?.isHidden = false
        }
        else{
            Setdatasource(section: page)
        }
    }
    @objc func saveData(){
        //rowdata = self.therow[page-1] as! [String]
        var xsz:[String] = []
        var jxsz:[String] = []
        for index in 0..<colum.count{
            var sz = alltext[index].text as! String
            xsz += [sz]
            print("第\(index)个数据是\(sz)")
        }
        jxsz += [alltext[0].text as! String]
        jxsz += [alltext[2].text as! String]
        print("改了之后的数据是\(xsz)")
        rows.remove(at: page-1)
        therow.remove(at: page-1)
        var xrows:[[String]] = []
        var jxrows:[[String]] = []
        addRow(row: jxsz)
        addRows(row: xsz)
        Setdatasource(section: rows.count)
        UIView.animate(withDuration: 0.3) {
            self.v_web?.frame.origin.y = self.screenHeight
            let alertController = UIAlertController(title: "修改成功",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
        }
    }
    //到处excel
    func excel(excelname:String){
        showMsgbox(_message: "已导出Excel文件")
        //获取当前时间
        let now = Date()
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日HH:mm:ss"
        var savetime:String = "\(dformatter.string(from: now))"
        print("当前日期时间：\(savetime)")
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filesPath = (docDir as NSString).appendingPathComponent("/\(excelname)")
        let fileManager = FileManager.default
        try! fileManager.createDirectory(atPath: filesPath,
                                         withIntermediateDirectories: true, attributes: nil)
        let jsonPath = (docDir as NSString).appendingPathComponent("/\(excelname)/\(savetime).xlsx")
        let book = workbook_new(jsonPath)
        let sheet = workbook_add_worksheet(book, "sheet1")
        for index in 0..<colum.count{
            var titles = colum[index]
            worksheet_write_string(sheet, 0, lxw_col_t(index), titles, nil)
        }
        for i in 0..<therow.count{
            var row = therow[i]
            for j in 0..<row.count{
                var col:String  = row[j] as! String
                worksheet_write_string(sheet, lxw_row_t(i)+1, lxw_col_t(j), col, nil)
            }
        }
        
        //
        //        worksheet_write_string(sheet, 0, 1, "到处", nil)
        //        worksheet_write_string(sheet, 0, 2, "数据", nil)
        //        worksheet_write_string(sheet, 0, 3, "到", nil)
        //        worksheet_write_string(sheet, 0, 4, "excel", nil)
        workbook_close(book);
    }
    func wechat(excelname:String){
        print("分享到微信")
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("\(excelname).xlsx")
        
        let book = workbook_new(jsonPath)
        let sheet = workbook_add_worksheet(book, "sheet1")
        for index in 0..<colum.count{
            var titles = colum[index]
            worksheet_write_string(sheet, 0, lxw_col_t(index), titles, nil)
        }
        for i in 0..<therow.count{
            var row = therow[i]
            for j in 0..<row.count{
                var col:String  = row[j] as! String
                worksheet_write_string(sheet, lxw_row_t(i)+1, lxw_col_t(j), col, nil)
            }
        }
        workbook_close(book);
        
        let message =  WXMediaMessage()
        message.title = "\(excelname).xlsx"
        message.description = "Pro CoreData"
        message.setThumbImage(UIImage(named:"sendlogo.png"))
        
        let ext =  WXFileObject()
        ext.fileExtension = "xlsx"
        let url = URL(fileURLWithPath: jsonPath)
        ext.fileData = try! Data(contentsOf: url)
        message.mediaObject = ext
        
        let req =  SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = _scene
        WXApi.send(req)
    }
    func QQ(excelname:String){
//        print("分享到QQ")
//        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//        let jsonPath = (docDir as NSString).appendingPathComponent("senddata.xlsx")
//
//        let book = workbook_new(jsonPath)
//        let sheet = workbook_add_worksheet(book, "sheet1")
//        for index in 0..<colum.count{
//            var titles = colum[index]
//            worksheet_write_string(sheet, 0, lxw_col_t(index), titles, nil)
//        }
//        for i in 0..<therow.count{
//            var row = therow[i]
//            for j in 0..<row.count{
//                var col:String  = row[j] as! String
//                worksheet_write_string(sheet, lxw_row_t(i)+1, lxw_col_t(j), col, nil)
//            }
//        }
//        workbook_close(book);
//        let thetitle="\(excelname)"
//        let fileData = NSData(contentsOfFile:jsonPath)
//        let imgPath =  Bundle.main.path(forResource: "sendlogo", ofType: "png")
//        let imgData = NSData(contentsOfFile:imgPath!)
//        let fileObj = QQApiFileObject(data: fileData as! Data, previewImageData: imgData as! Data, title: thetitle, description: thetitle)
//        let req = SendMessageToQQReq(content: fileObj)
//        //发送并获取响应结果
//        let sendResult = QQApiInterface.send(req)
//        //处理结果
//        handleSendResult(sendResult:  sendResult)
        let filePath =  Bundle.main.path(forResource: "\(excelname)", ofType: "xlsx")
        let fileData = NSData(contentsOfFile:filePath!)
        let imgPath =  Bundle.main.path(forResource: "logo", ofType: "png")
        let imgData = NSData(contentsOfFile:imgPath!)
        
        let fileObj = QQApiFileObject(data: imgData as Data!, previewImageData: imgData as Data!, title: "\(excelname)", description: "星蛛数据服务平台")
        let req = SendMessageToQQReq(content: fileObj)
        QQApiInterface.send(req)
    }
    func QQ2(excelname:String){
        let txtObj = QQApiTextObject(text: "欢迎访问 hangge.com")
        let req = SendMessageToQQReq(content: txtObj)
        QQApiInterface.send(req)
    }
    func toemail(excelname:String){
        //0.首先判断设备是否能发送邮件
        if MFMailComposeViewController.canSendMail() {
            //1.配置邮件窗口
            let mailView = configuredMailComposeViewController(excelname2:excelname)
            //2. 显示邮件窗口
            present(mailView, animated: true, completion: nil)
        } else {
            print("Whoop...设备不能发送邮件")
            showSendMailErrorAlert()
        }
    }
    func addtext(){
        self.view.addSubview(bezierText)
    }
    @objc func funRight(sender: UIPanGestureRecognizer){
        if(page>1){
            UIView.beginAnimations("", context: nil)
            //设置动画的持续时间，类型和渐变类型
            UIView.setAnimationDuration(0.5)
            UIView.setAnimationTransition(UIView.AnimationTransition.curlDown, for: self.v_datasource!, cache: true)
            UIView.setAnimationCurve(UIView.AnimationCurve.easeInOut)
            //开始动画
            UIView.commitAnimations()
//            let xorig = v_datasource?.center.x
//            let opts = UIView.AnimationOptions.autoreverse
//            UIView.animate(withDuration: 0.2, delay: 0, options: opts, animations: {
//                self.v_datasource?.center.x += 10
//            }, completion: { _ in
//                self.v_datasource?.center.x = xorig!
//            })
            
          self.Setdatasource(section: page-1)
        }
        else{
            let alertController = UIAlertController(title: "已经到顶了哦～",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
        }
    }
    @objc func funLeft(sender: UIPanGestureRecognizer){
        if(page<therow.count){
            UIView.beginAnimations("", context: nil)
            //设置动画的持续时间，类型和渐变类型
            UIView.setAnimationDuration(0.5)
            UIView.setAnimationTransition(UIView.AnimationTransition.curlUp, for: self.v_datasource!, cache: true)
            UIView.setAnimationCurve(UIView.AnimationCurve.easeInOut)
            //开始动画
            UIView.commitAnimations()
//            let xorig = v_datasource?.center.x
//            let opts = UIView.AnimationOptions.autoreverse
//            UIView.animate(withDuration: 0.2, delay: 0, options: opts, animations: {
//                self.v_datasource?.center.x -= 10
//            }, completion: { _ in
//                self.v_datasource?.center.x = xorig!
//            })
            self.Setdatasource(section: page+1)
            print("\(page)为")
        }
        else{
            let alertController = UIAlertController(title: "已经到底了哦～",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
        }
    }
    @objc func funbuttonRight(sender: UIPanGestureRecognizer){
        if(page>1){
            UIView.beginAnimations("", context: nil)
            //设置动画的持续时间，类型和渐变类型
            UIView.setAnimationDuration(0.5)
            UIView.setAnimationTransition(UIView.AnimationTransition.curlDown, for: self.v_datasource!, cache: true)
            UIView.setAnimationCurve(UIView.AnimationCurve.easeInOut)
            //开始动画
            UIView.commitAnimations()
//            let xorig = v_datasource?.center.x
//            let opts = UIView.AnimationOptions.autoreverse
//            UIView.animate(withDuration: 0.2, delay: 0, options: opts, animations: {
//                self.v_datasource?.center.x -= 10
//            }, completion: { _ in
//                self.v_datasource?.center.x = xorig!
//            })
            self.Setdatasource(section: page-1)
        }
        else{
            let alertController = UIAlertController(title: "已经到顶了哦～",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
        }
    }
    @objc func funbuttonLeft(sender: UIPanGestureRecognizer){
        if(page<therow.count){
            UIView.beginAnimations("", context: nil)
            //设置动画的持续时间，类型和渐变类型
            UIView.setAnimationDuration(0.5)
            UIView.setAnimationTransition(UIView.AnimationTransition.curlUp, for: self.v_datasource!, cache: true)
            UIView.setAnimationCurve(UIView.AnimationCurve.easeInOut)
            //开始动画
            UIView.commitAnimations()
            
//            let xorig = v_datasource?.center.x
//            let opts = UIView.AnimationOptions.autoreverse
//            UIView.animate(withDuration: 0.2, delay: 0, options: opts, animations: {
//                self.v_datasource?.center.x += 10
//            }, completion: { _ in
//                self.v_datasource?.center.x = xorig!
//            })
            self.Setdatasource(section: page+1)
        }
        else{
            let alertController = UIAlertController(title: "已经到底了哦～",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
        }
    }
    @objc func funDown(sender: UIPanGestureRecognizer){
        if(sw_bj?.isOn != true){
            UIView.animate(withDuration: 0.6) {
                self.v_datasource?.transform = CGAffineTransform.identity
                    .translatedBy(x: -100, y: 0)
                    //.rotated(by:CGFloat(Double.pi/4))
                    .scaledBy(x: 0.5, y: 0.5)
            }
        }
    }
    //处理分享返回结果
    func handleSendResult(sendResult:QQApiSendResultCode){
        var message = ""
        switch(sendResult){
        case EQQAPIAPPNOTREGISTED:
            message = "App未注册"
        case EQQAPIMESSAGECONTENTINVALID, EQQAPIMESSAGECONTENTNULL,
             EQQAPIMESSAGETYPEINVALID:
            message = "发送参数错误"
        case EQQAPIQQNOTINSTALLED:
            message = "QQ未安装"
        case EQQAPIQQNOTSUPPORTAPI:
            message = "API接口不支持"
        case EQQAPISENDFAILD:
            message = "发送失败"
        case EQQAPIQZONENOTSUPPORTTEXT:
            message = "空间分享不支持纯文本分享，请使用图文分享"
        case EQQAPIQZONENOTSUPPORTIMAGE:
            message = "空间分享不支持纯图片分享，请使用图文分享"
        default:
            message = "发送成功"
        }
        print(message)
    }
    //MARK:- helper methods
    //配置邮件窗口
    func configuredMailComposeViewController(excelname2:String) -> MFMailComposeViewController {
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("\(excelname2).xlsx")
        
        let book = workbook_new(jsonPath)
        let sheet = workbook_add_worksheet(book, "sheet1")
        for index in 0..<colum.count{
            var titles = colum[index]
            worksheet_write_string(sheet, 0, lxw_col_t(index), titles, nil)
        }
        for i in 0..<therow.count{
            var row = therow[i]
            for j in 0..<row.count{
                var col:String  = row[j] as! String
                worksheet_write_string(sheet, lxw_row_t(i)+1, lxw_col_t(j), col, nil)
            }
        }
        workbook_close(book);
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        //测试1
        let mimeType1 = mimeType(pathExtension: "gif")
        print("文件1是\(mimeType1)")
        if UserDefaults.standard.object(forKey: "userEmail") != nil {
            emailph = UserDefaults.standard.object(forKey: "userEmail") as! String
        }
        //设置邮件地址、主题及正文
        mailComposeVC.setToRecipients(["1252279088@qq.com"])
        mailComposeVC.setSubject("\(excelname2)")
        mailComposeVC.setMessageBody("发送\(excelname2)至邮箱", isHTML: false)
        //添加文件附件
        let url = URL(fileURLWithPath: jsonPath)
        let mimeType2 = mimeType(pathExtension: url.pathExtension)
        print("文件类型是\(mimeType2)")
        let myData = try! Data(contentsOf: url)
        mailComposeVC.addAttachmentData(myData, mimeType: mimeType2, fileName: "\(excelname2).xlsx")
        return mailComposeVC
    }
    
    
    //提示框，提示用户设置邮箱
    func showSendMailErrorAlert() {
        
        let sendMailErrorAlert = UIAlertController(title: "未开启邮件功能", message: "设备邮件功能尚未开启，请在设置中更改", preferredStyle: .alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: "确定", style: .default) { _ in })
        self.present(sendMailErrorAlert, animated: true){}
    }
    
    
    //MARK:- Mail Delegate
    //用户退出邮件窗口时被调用
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue{
        case MFMailComposeResult.sent.rawValue:
            print("邮件已发送")
        case MFMailComposeResult.cancelled.rawValue:
            print("邮件已取消")
        case MFMailComposeResult.saved.rawValue:
            print("邮件已保存")
        case MFMailComposeResult.failed.rawValue:
            print("邮件发送失败")
        default:
            print("邮件没有发送")
            break
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    //根据后缀获取对应的Mime-Type
    func mimeType(pathExtension: String) -> String {
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,
                                                           pathExtension as NSString,
                                                           nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?
                .takeRetainedValue() {
                return mimetype as String
            }
        }
        //文件资源类型如果不知道，传万能类型application/octet-stream，服务器会自动解析文件类
        return "application/octet-stream"
    }
    func zidong(excelname:String){
        print("导出excel")
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("\(excelname)-数据源.xlsx")
        
        let book = workbook_new(jsonPath)
        let sheet = workbook_add_worksheet(book, "sheet1")
        for index in 0..<colum.count{
            var titles = colum[index]
            worksheet_write_string(sheet, 0, lxw_col_t(index), titles, nil)
        }
        for i in 0..<therow.count{
            var row = therow[i]
            for j in 0..<row.count{
                var col:String  = row[j] as! String
                worksheet_write_string(sheet, lxw_row_t(i)+1, lxw_col_t(j), col, nil)
            }
        }
        workbook_close(book);
    }
    @objc func toweburl(){
        let chilrenviews = self.v_web?.subviews
        
        for chilren in chilrenviews! {
            
            chilren.removeFromSuperview()
            
        }
        
        let zt_height = UIApplication.shared.statusBarFrame.height
        let dh_height = (zt_height==44 ? 44 : 20)
        let nv_height = CGFloat((dh_height))
        let tourl = rowdata[1]
        let showname = rowdata[2]
        self.safariurl = tourl
        UIView.animate(withDuration: 0.3) {
            self.v_web?.frame.origin.y -= self.screenHeight
            self.tczt = 1
        }
        //返回按钮
        var bt_back = UIButton(frame: CGRect(x:5, y: 5, width:30, height: 30))
        bt_back.setImage(UIImage(named: "close"), for: .normal)
        self.v_web?.addSubview(bt_back)
        bt_back.addTarget(self, action: #selector(closewebView), for: UIControl.Event.touchUpInside)
        //跳转浏览器
        var bt_safari = UIButton(frame: CGRect(x:screenWidth-30-5, y:5, width:30, height: 30))
        bt_safari.setImage(UIImage(named: "jumpto"), for: .normal)
        self.v_web?.addSubview(bt_safari)
        bt_safari.addTarget(self, action: #selector(tosafari), for: UIControl.Event.touchUpInside)
        //标题
        var l_title = UILabel(frame: CGRect(x:40,y:5,width:(v_web?.frame.size.width)! - 80,height:30))
        l_title.text = showname
        l_title.textColor = UIColor.black
        v_web?.addSubview(l_title)
        l_title.textAlignment = .center
        //分割线
        var v_febge = UIView(frame: CGRect(x:0, y: 39, width:screenWidth, height: 2))
        v_febge.backgroundColor = UIColor(red: 91.0/255.0, green: 84.0/255.0, blue: 145.0/255.0, alpha: 0.7)
        v_web?.addSubview(v_febge)
        //网页视图
        var webView = UIWebView(frame: CGRect(x:0, y: 40, width:screenWidth, height: screenHeight-40-nv_height-zt_height))
        webView.loadRequest(URLRequest(url: NSURL(string : tourl)! as URL))
        
        v_web?.addSubview(webView)
    }
    @objc func closewebView(){
        UIView.animate(withDuration: 0.3) {
            self.v_web?.frame.origin.y += self.screenHeight
            self.tczt = 0
        }
    }
    //长按手势事件
    @objc func longPressClick() {
        let headph = UserDefaults.standard.object(forKey: "userProfilePhoto") as! String
        let alert = UIAlertController(title: "请选择", message: nil, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "保存到相册", style: .default) { [weak self](_) in
            //按着command键，同时点击UIImageWriteToSavedPhotosAlbum方法可以看到
            let smallImages = self!.smallImage?.drawTextInImage(text: "星蛛服务", textColor: UIColor(red: 91.0/255.0, green: 84.0/255.0, blue: 145.0/255.0, alpha: 0.7), textFont: UIFont.systemFont(ofSize: 8), suffixText: nil, suffixFont: nil, suffixColor: nil)
            UIImageWriteToSavedPhotosAlbum(smallImages!,self, #selector(self!.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(action1)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    @objc func image(_ image: UIImage, didFinishSavingWithError: NSError?, contextInfo: AnyObject){
        if didFinishSavingWithError != nil {
            let alertController = UIAlertController(title: "请开启访问相册权限后使用此功能",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
        } else {
            let alertController = UIAlertController(title: "图片保存成功",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
        }
    }
    @objc func tosafari(){
        let urls = URL(string: self.safariurl)
        UIApplication.shared.open(urls!, options: [UIApplication.OpenExternalURLOptionsKey(rawValue: ""):""], completionHandler: nil)
    }
    /// 监听键盘弹出
    @objc private func keyboardWillChangeFrame(node : Notification){
        //1.获取动画执行的时间
        let duration =  node.userInfo!["UIKeyboardAnimationDurationUserInfoKey"] as! Double
        //2. 获取键盘最终的Y值
        let endFrame = (node.userInfo!["UIKeyboardFrameEndUserInfoKey"] as! NSValue).cgRectValue
        let y = endFrame.origin.y
        //3.计算工具栏距离底部的间距
        let margin =  UIScreen.main.bounds.height - y
        //4.执行动画
        print("高度是\(zhongjihei)")
        if(sw_bj?.isOn == true){
            v_datasource?.frame.size.height = zhongjihei
            v_datasource?.frame.size.height -= margin
            datasourceView?.frame.size.height = zhongjihei-80
            datasourceView?.frame.size.height -= margin
            print("视图的高度为\(v_datasource?.frame.size.height)")
        }
    }
    /// 监听键盘收回
    @objc func keyboardWillHide(notification: NSNotification) {
        if(sw_bj?.isOn == true){
            v_datasource?.frame.size.height = zhongjihei
            datasourceView?.frame.size.height = zhongjihei-80
        }
    }
}

