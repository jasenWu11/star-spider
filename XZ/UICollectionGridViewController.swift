<<<<<<< HEAD
//
//  UICollectionGridViewController.swift
//  hangge_1081
//
//  Created by hangge on 2016/11/19.
//  Copyright © 2016年 hangge.com. All rights reserved.
//

=======
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
import Foundation
import UIKit

//表格排序协议
protocol UICollectionGridViewSortDelegate: class {
    func sort(colIndex: Int, asc: Bool, rows: [[Any]]) -> [[Any]]
}

//多列表格组件（通过CollectionView实现）
class UICollectionGridViewController: UICollectionViewController {
    //表头数据
    var cols: [String]! = []
    //行数据
    var rows: [[Any]]! = []
<<<<<<< HEAD
    //实际表头数据
    var colum :[String]! = []
    let datav = DataSourceViewController()
=======
    
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
    //排序代理
    weak var sortDelegate: UICollectionGridViewSortDelegate?
    
    //选中的表格列（-1表示没有选中的）
    private var selectedColIdx = -1
    //列排序顺序
    private var asc = true
<<<<<<< HEAD
    var v_datasource : UIView?
    var datasourceView : UIScrollView?
    var iv_close:UIButton?
    var height:Int = 0
    var they:Int = 0
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    var rowdata:[String] = []
    var row1 : String = ""
    var row2 : String = ""
    var therow : [[Any]]! = []
    var phoitem:Int = -1
    init() {
        //初始化表格布局
        let layout = UICollectionGridViewLayout()
        super.init(collectionViewLayout: layout)
        layout.viewController = self
        collectionView!.backgroundColor = UIColor.white
        collectionView!.register(UICollectionGridViewCell.self,
=======
    
    init() {
        //初始化表格布局
        let layout = UICollectionViewLayout()
        super.init(collectionViewLayout: layout)
        //layout.viewController = self
        collectionView!.backgroundColor = UIColor.white
        collectionView!.register(UICollectionViewCell.self,
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
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
    
<<<<<<< HEAD
    //设置列头实际数据
    func setColumd(columd: [String]) {
        colum = columd
    }
    
    //添加行数据
    
=======
    //添加行数据
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
    func addRow(row: [Any]) {
        rows.append(row)
        collectionView!.collectionViewLayout.invalidateLayout()
        collectionView!.reloadData()
    }
    
<<<<<<< HEAD
    
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
        v_datasource = UIScrollView(frame: CGRect(x:20, y: screenHeight/5-64, width:screenWidth-40, height: screenHeight/5*3))
        v_datasource?.backgroundColor=UIColor.white
        v_datasource?.clipsToBounds=true
        v_datasource?.layer.cornerRadius = 3
        v_datasource?.layer.shadowColor = UIColor.gray.cgColor
        v_datasource?.layer.shadowOpacity = 1.0
        v_datasource?.layer.shadowOffset = CGSize(width: 0, height: 0)
        v_datasource?.layer.shadowRadius = 4
        v_datasource?.layer.masksToBounds = false
        //datasourceView?.addTarget(self, action: #selector(composeBtnClick), for: UIControl.Event.touchUpInside)
        view.addSubview(v_datasource!)
        v_datasource?.isHidden = true
        
        iv_close = UIButton(frame: CGRect(x:10, y: 8, width:30, height: 30))
        iv_close?.setImage(UIImage(named:"close"), for: .normal)
        iv_close?.addTarget(self, action: #selector(CloseClick), for: UIControl.Event.touchUpInside)
        v_datasource?.addSubview(iv_close!)
        
        datasourceView = UIScrollView(frame: CGRect(x:0, y: 40, width:screenWidth-40, height: (v_datasource?.frame.size.height)!-40))
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
        
=======
    override func viewDidLoad() {
        super.viewDidLoad()
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
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
<<<<<<< HEAD
        
=======
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
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
<<<<<<< HEAD
            cell.backgroundColor = UIColor(red: 91.0/255, green: 84.0/255,
                                           blue: 145.0/255, alpha: 1)
            //排序列列头显示升序降序图标
            if indexPath.row == selectedColIdx {
                let iconType = asc ? FAType.FALongArrowUp : FAType.FALongArrowDown
                cell.imageView.setFAIconWithName(icon: iconType, textColor: UIColor.white)
=======
            cell.backgroundColor = UIColor(red: 0x91/255, green: 0xDA/255,
                                           blue: 0x51/255, alpha: 1)
            //排序列列头显示升序降序图标
            if indexPath.row == selectedColIdx {
//                let iconType = asc ? FAType.FALongArrowUp : FAType.FALongArrowDown
//                cell.imageView.setFAIconWithName(icon: iconType, textColor: UIColor.white)
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
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
<<<<<<< HEAD
//        showMsgbox(_message: rows[indexPath.section-1][indexPath.row] as! String)
=======
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
        if indexPath.section == 0 && sortDelegate != nil {
            //如果点击的是表头单元格，则默认该列升序排列，再次点击则变降序排列，以此交替
            asc = (selectedColIdx != indexPath.row) ? true : !asc
            selectedColIdx = indexPath.row
            rows = sortDelegate?.sort(colIndex: indexPath.row, asc: asc, rows: rows)
            collectionView.reloadData()
        }
<<<<<<< HEAD
        self.Setdatasource(section: indexPath.section)
    }
    func showMsgbox(_message: String, _title: String = "数据"){
        
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
        
    }
    @objc func CloseClick(shopcellView: UILabel) {
        v_datasource?.isHidden = true
    }
    func Setdatasource(section:Int){
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
                    var dataImage = UIImageView(frame: CGRect(x:0, y: they, width:Int((datasourceView?.frame.size.width)!), height: Int((datasourceView?.frame.size.width)!)*2/3))
                    let url = URL(string:Imageurl)
                    let data = try! Data(contentsOf: url!)
                    let smallImage = UIImage(data: data)
                    dataImage.image = smallImage
                    datasourceView?.addSubview(dataImage)
                    they=they+Int((dataImage.frame.size.height)+10)
                }
            }
            
        }
        //print("行\(rowdata)")
        for i in 0..<colum.count{
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

            
            //print("字符串长度为\(self.rowdata[i].count)")
            var strcou = self.rowdata[i].count
            if(strcou<=13){
                var b = CanCopyLabel(frame: CGRect(x:Int((datasourceView?.frame.size.width)!-20)/2-40, y: they-35, width:Int((datasourceView?.frame.size.width)!-20)+40, height: 30))
                b.text = self.rowdata[i]
                b.font = UIFont.systemFont(ofSize: 16)
                b.textColor = UIColor.black
                datasourceView?.addSubview(b)
            }
            if(strcou>13&&strcou<20){
                var b = CanCopyLabel(frame: CGRect(x:10, y: they, width:Int((datasourceView?.frame.size.width)!-20), height: 30))
                b.text = self.rowdata[i]
                b.font = UIFont.systemFont(ofSize: 16)
                b.textColor = UIColor.black
                they=they+Int((b.frame.size.height)+5)
                datasourceView?.addSubview(b)
            }
            else if(strcou>20){
                var b = UITextView(frame: CGRect(x:10, y: they, width:Int((datasourceView?.frame.size.width)!-20), height: 60))
                b.text = self.rowdata[i]
                b.font = UIFont.systemFont(ofSize: 16)
                b.textColor = UIColor.black
                b.isEditable = false
                b.backgroundColor = UIColor(red: 91.0/225.0, green: 84.0/225.0, blue: 145.0/225.0, alpha: 0.2)
                they=they+Int((b.frame.size.height)+5)
                datasourceView?.addSubview(b)
            }
            else if(strcou>60){
                var b = UITextView(frame: CGRect(x:10, y: they, width:Int((datasourceView?.frame.size.width)!-20), height: 90))
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
=======
    }
}

>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
