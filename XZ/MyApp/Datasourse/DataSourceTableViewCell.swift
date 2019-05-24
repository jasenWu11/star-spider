//
//  DataSourceTableViewCell.swift
//  XZ
//
//  Created by wjz on 2019/2/28.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit
import Alamofire
class DataSourceTableViewCell: UITableViewCell {
    
    var iconImage     : UIImageView?
    var titleLabel    : UILabel?
    var tv_dsct : UILabel?
    var l_dsct:UILabel?
    var tv_dsut : UILabel?
    var l_dsut:UILabel?
    var tv_dsnu : UILabel?
    var l_dsnu:UILabel?
    var l_dsss:UILabel?
    var tv_dsss : UILabel?
    var subButton : UIButton?
    let screenWidth =  UIScreen.main.bounds.size.width
    var rows:Int = 0
    var datasourceView : UIButton?
    var root : DataSourceTableViewController?
    var pid:Int = 5
    var pids:Int = 5
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    @objc func composeBtnClick(datasourceView: UILabel) {
        print(datasourceView.tag)
        pids = datasourceView.tag
        root?.root?.performSegue(withIdentifier: "deatil", sender: pids)
    }
    @objc func LookClick(subButton: UIButton) {
        var Ntitle:String = (root?.dsns[subButton.tag])!
        var dataname:String = (root?.clns[subButton.tag])!
        root?.root?.Ntitle = Ntitle
        root?.root?.dataName = dataname
        root?.root?.datasourceDetailView()
    }
    func setUpUI(){
        //视图
        datasourceView = UIButton(frame: CGRect(x:5, y: 5, width:screenWidth-10, height: 160))
        datasourceView?.backgroundColor=UIColor.white
        datasourceView?.clipsToBounds=true
        datasourceView?.layer.cornerRadius = 3
        datasourceView?.layer.shadowColor = UIColor.gray.cgColor
        datasourceView?.layer.shadowOpacity = 1.0
        datasourceView?.layer.shadowOffset = CGSize(width: 0, height: 0)
        datasourceView?.layer.shadowRadius = 4
        datasourceView?.layer.masksToBounds = false
        //datasourceView?.addTarget(self, action: #selector(composeBtnClick), for: UIControl.Event.touchUpInside)
        self.addSubview(datasourceView!)
        //增加长按手势
        datasourceView?.isUserInteractionEnabled = true
        let longGress = UILongPressGestureRecognizer()
        longGress.addTarget(self, action: #selector(longGressGestrue(longGress:)))
        datasourceView?.addGestureRecognizer(longGress)
        // 图片
        iconImage = UIImageView(frame: CGRect(x:0, y: 0, width:120, height: 160))
        iconImage?.layer.cornerRadius = 3.0
        iconImage?.layer.maskedCorners = [CACornerMask.layerMinXMinYCorner , CACornerMask.layerMinXMaxYCorner]
        iconImage?.layer.masksToBounds = true
        datasourceView?.addSubview(iconImage!)
        iconImage?.image = UIImage(named:"datas")
        // 大标题
        titleLabel = UILabel(frame: CGRect(x:(iconImage?.frame.size.width)!+15, y:10, width: self.frame.size.width-(iconImage?.frame.size.width)!+20, height:30))
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        titleLabel?.textColor = UIColor.black
        titleLabel?.numberOfLines = 0
        titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        datasourceView?.addSubview(titleLabel!)
//        titleLabel = UITextView(frame: CGRect(x:(iconImage?.frame.size.width)!+25, y:10, width: self.frame.size.width-(iconImage?.frame.size.width)!+20, height:60))
//        titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        titleLabel?.textColor = UIColor.black
//        titleLabel?.isEditable = false
//        datasourceView?.addSubview(titleLabel!)
        
        // 创建时间标签
        l_dsct = UILabel(frame: CGRect(x:(iconImage?.frame.size.width)!+15, y:(titleLabel?.frame.size.height)!+10, width:60, height: 20))
        l_dsct?.font = UIFont.systemFont(ofSize: 13)
        l_dsct?.textColor = UIColor.gray
        datasourceView?.addSubview(l_dsct!)
        l_dsct?.text = "创建时间:"
        
        // 创建时间
        tv_dsct = UILabel(frame: CGRect(x:(iconImage?.frame.size.width)!+75, y:(titleLabel?.frame.size.height)!+10, width:self.frame.size.width-(iconImage?.frame.size.width)!+20, height: 20))
        tv_dsct?.font = UIFont.systemFont(ofSize: 13)
        tv_dsct?.textColor = UIColor.gray
        datasourceView?.addSubview(tv_dsct!)
        
        // 更新时间标签
        l_dsut = UILabel(frame: CGRect(x:(iconImage?.frame.size.width)!+15, y:(titleLabel?.frame.size.height)!+(l_dsct?.frame.size.height)!+10, width:60, height: 30))
        l_dsut?.font = UIFont.systemFont(ofSize: 13)
        l_dsut?.textColor = UIColor.gray
        datasourceView?.addSubview(l_dsut!)
        l_dsut?.text = "更新时间:"
        
        // 更新时间
        tv_dsut = UILabel(frame: CGRect(x:(iconImage?.frame.size.width)!+75, y:(titleLabel?.frame.size.height)!+(l_dsct?.frame.size.height)!+10, width:self.frame.size.width-(iconImage?.frame.size.width)!+20, height: 30))
        tv_dsut?.font = UIFont.systemFont(ofSize: 13)
        tv_dsut?.textColor = UIColor.gray
        datasourceView?.addSubview(tv_dsut!)
        
        // 数据量标签
        l_dsnu = UILabel(frame: CGRect(x:(iconImage?.frame.size.width)!+15, y:(titleLabel?.frame.size.height)!+(l_dsct?.frame.size.height)!+(tv_dsut?.frame.size.height)!+10, width:45, height: 30))
        l_dsnu?.font = UIFont.systemFont(ofSize: 13)
        l_dsnu?.textColor = UIColor.black
        datasourceView?.addSubview(l_dsnu!)
        l_dsnu?.text = "数据量:"
        
        // 数据量
        tv_dsnu = UILabel(frame: CGRect(x:(iconImage?.frame.size.width)!+60, y:(titleLabel?.frame.size.height)!+(l_dsct?.frame.size.height)!+(tv_dsut?.frame.size.height)!+10, width:self.frame.size.width-(iconImage?.frame.size.width)!+10, height: 30))
        tv_dsnu?.font = UIFont.systemFont(ofSize: 13)
        tv_dsnu?.textColor = UIColor.black
        datasourceView?.addSubview(tv_dsnu!)
        
        // 数据大小标签
        l_dsnu = UILabel(frame: CGRect(x:(iconImage?.frame.size.width)!+15, y:(titleLabel?.frame.size.height)!+(l_dsct?.frame.size.height)!+(tv_dsut?.frame.size.height)!+(tv_dsnu?.frame.size.height)!+10, width:45, height: 30))
        l_dsnu?.font = UIFont.systemFont(ofSize: 13)
        l_dsnu?.textColor = UIColor.black
        datasourceView?.addSubview(l_dsnu!)
        l_dsnu?.text = "存储量:"
        // 数据大小
        tv_dsss = UILabel(frame: CGRect(x:(iconImage?.frame.size.width)!+60, y:(titleLabel?.frame.size.height)!+(l_dsct?.frame.size.height)!+(tv_dsut?.frame.size.height)!+(tv_dsnu?.frame.size.height)!+10, width:60, height: 30))
        tv_dsss?.font = UIFont.systemFont(ofSize: 13)
        tv_dsss?.textColor = UIColor.black
        datasourceView?.addSubview(tv_dsss!)
        // 按钮
        subButton = UIButton(frame: CGRect(x:screenWidth-70-20, y:(iconImage?.frame.size.height)!-40, width:70, height: 25))
        subButton?.setTitle("查看", for: UIControl.State.normal)
        subButton?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        subButton?.backgroundColor = UIColor.black
        subButton?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        subButton?.addTarget(self, action: #selector(LookClick), for: UIControl.Event.touchUpInside)
        //subButton!.tag = pid
        datasourceView?.addSubview(subButton!)
        
    }
    
    // 给cell赋值，项目中一般使用model，我这里直接写死了
    //    func setValueForCell(){
    //
    //        rows = rows+1
    //        iconImage?.image = UIImage(named:"weibo")
    //        titleLabel?.text = "大大大大的标题"
    //        tv_dsct?.text = "副副副副的标题"
    //    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    @objc private func longGressGestrue(longGress:UILongPressGestureRecognizer){
        
          if longGress.state == UIGestureRecognizer.State.began {
            var sourcename : String = (root?.dsns[(datasourceView?.tag)!])!
            var dataname : String = (root?.clns[(datasourceView?.tag)!])!
            Deleactions(datanames: dataname,sourcenames:sourcename)
        }
    }
    func Deleactions(datanames:String,sourcenames:String) {
        let alertController = UIAlertController(title: "提示", message: "是否删除数据源\"\(sourcenames)\"？",preferredStyle: .alert)
        let cancelAction1 = UIAlertAction(title: "确定", style: .destructive, handler: {
            action in
            self.deleteok(dataname: datanames)
        })
        let cancelAction2 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction1)
        alertController.addAction(cancelAction2)
        root?.present(alertController, animated: true, completion: nil)
    }
    func deleteok(dataname:String){
        
        var userid:Int = UserDefaults.standard.object(forKey: "userId") as! Int
        let url = "https://www.xingzhu.club/XzTest/datasource/deleteDataSource"
        let paras = ["userId":userid,"crawlerName":dataname] as [String : Any]
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
                let alertController = UIAlertController(title: "\(message)",
                    message: nil, preferredStyle: .alert)
                //显示提示框
                self.root?.present(alertController, animated: true, completion: nil)
                //两秒钟后自动消失
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.root?.presentedViewController?.dismiss(animated: false, completion: nil)
                }
                self.root?.Refresh()
            }
        }
        
    }
}
