//
//  PursedeailTableViewController.swift
//  XZ
//
//  Created by wjz on 2019/2/22.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
import MobileCoreServices
import MessageUI
class PursedeailTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  ,MFMailComposeViewControllerDelegate{
    var rId:[String] = []
    var rechargeId:[Int] = []
    var rechargeTime:[String] = []
    var rechargerMoney:[String] = []
    var recharerRemark:[String] = []
    //表格
    var columd:[String] = ["编号","金额", "详情", "时间"]
    var row : [Any] = []
    var rows : [[Any]]! = []
    //    var states:[String] = ["未开始","已停止","已停止","暂停","未开始","正在操作","正在操作"]
    //    var counts:[String] = ["0","16","30","15","0","20","18"]
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    let TAG_CELL_LABEL = 1
    let TAG_CELL_BUTTON = 2
    var pids:Int = 0
    var tableView:UITableView?
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "账单明细"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title:"+",style:UIBarButtonItem.Style.plain,target:self,action:#selector(menu))
        self.navigationItem.rightBarButtonItem?.image = UIImage(named: "share")
        let handLeftRight = UISwipeGestureRecognizer(target: self, action: #selector(funLeftRight))
        //handLeftRight.direction = .left //支持向左
        self.view.addGestureRecognizer(handLeftRight)
        
        self.tableView?.separatorStyle = .none
        //下拉刷新
        header.lastUpdatedTimeLabel.isHidden = true
        header.stateLabel.isHidden = true
        //创建表视图
        //导航栏高度
        let nv_height = self.navigationController?.navigationBar.frame.size.height
        //状态栏高度
        let zt_height = UIApplication.shared.statusBarFrame.height
        self.tableView = UITableView(frame: CGRect(x:0, y:0, width:screenWidth, height: screenHeight-nv_height!-zt_height), style:.plain)
        //self.tableView = UITableView(frame: self.view.frame, style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        tableView?.separatorStyle = .none
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "ShopCell")
        view.addSubview(self.tableView!)
        header.setRefreshingTarget(self, refreshingAction: #selector(getRechargeRecords))
        self.tableView!.mj_header = header
        getRechargeRecords()
    }
    
    @objc func funLeftRight(sender: UIPanGestureRecognizer){

    }
    
    @IBAction func back(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false, completion: nil)
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rechargeId.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let identifier = "MyappCell"
            let cell = pursedeailTableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier) as! pursedeailTableViewCell
            cell.root = self
            cell.tv_rids?.text = "\(rId[indexPath.row])"
            cell.tv_times?.text = rechargeTime[indexPath.row]
            cell.tv_mons?.text = rechargerMoney[indexPath.row]
            cell.tv_rcr?.text = recharerRemark[indexPath.row]
            //cell.bt_dele!.tag = pidss[indexPath.row]
            return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        print(indexPath.row)
    }
    //充值记录
    @objc func getRechargeRecords()  {
        
        var userid:Int = UserDefaults.standard.object(forKey: "userId") as! Int
        let url = "https://www.xingzhu.club/XzTest/recharges/getRechargeRecords"
        let paras = ["userId":userid]
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
                let provinces = json["data"]
                self.rId.removeAll()
                self.rechargeId.removeAll()
                self.rechargeTime.removeAll()
                self.rechargerMoney.removeAll()
                self.recharerRemark.removeAll()
                self.row.removeAll()
                self.rows.removeAll()
                var theid:Int = provinces.count
                for i in 0..<provinces.count{
                    self.rId += ["\(provinces.count-i)"]
                    let rid: Int = provinces[i]["rechargeId"].int ?? 0
                    self.rechargeId += [rid]
                    let rids = "\(provinces.count-i)"
                    self.row += [rids]
                    let rmo: Double = provinces[i]["rechargerMoney"].double ?? 0.0
                    if(rmo>0){
                        var rmos:String = "+\(rmo)"
                        self.rechargerMoney += [rmos]
                        self.row += [rmos]
                    }
                    else{
                        self.rechargerMoney += ["\(rmo)"]
                        self.row += ["\(rmo)"]
                    }
                    let rcr: String = provinces[i]["rechargerRemarks"].string ?? ""
                    self.recharerRemark += [rcr]
                    self.row += [rcr]
                    let rct: String = provinces[i]["rechargeTime"].string ?? ""
                    self.rechargeTime += [rct]
                    self.row += [rct]
                    self.rows += [self.row]
                    self.row.removeAll()
                }
            }
            print("id为\(self.rechargeId)")
            print("钱财\(self.rechargerMoney)")
            self.tableView!.reloadData()
            //结束刷新
            self.tableView!.mj_header.endRefreshing()
            self.makeexcel()
        }
    }
    func makeexcel(){
        print("生成excel")
        print("报表数据位\(rows)")
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("statement.xlsx")
        
        let book = workbook_new(jsonPath)
        let sheet = workbook_add_worksheet(book, "sheet1")
        for index in 0..<columd.count{
            var titles = columd[index]
            worksheet_write_string(sheet, 0, lxw_col_t(index), titles, nil)
        }
        for i in 0..<rows.count{
            var row = rows[i]
            for j in 0..<row.count{
                var col:String  = row[j] as! String
                worksheet_write_string(sheet, lxw_row_t(i)+1, lxw_col_t(j), col, nil)
            }
        }
        workbook_close(book);
    }
    @objc func menu(_ sender: Any) {
        let items: [String] = ["发送报表"]
        let imgSource: [String] = ["youxiang"]
        NavigationMenuShared.showPopMenuSelecteWithFrameWidth(width: itemWidth, height: 160, point: CGPoint(x: ScreenInfo.Width - 30, y: 0), item: items, imgSource: imgSource) { (index) in
            ///点击回调
            switch index{
            case 0:
                self.sendstatement()
            case 1:
                self.sendstatement()
            default:
                break
            }
        }
    }
    /*菜单按钮点击事件*/
    func sendstatement(){
        viewDidAppear()
    }
    @objc func viewDidAppear(){
        
        
        let alertController = UIAlertController(title: "压缩密码",
                                                message: "请输入4位压缩密码", preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "压缩密码"
            textField.addChangeTextTarget()
            textField.maxTextNumber = 12
            textField.isSecureTextEntry = true
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let noAction = UIAlertAction(title: "不用", style: .default, handler: {
            action in
            self.toemail(pass: "")
        })
        let okAction = UIAlertAction(title: "确定", style: .destructive, handler: {
            action in
            //也可以用下标的形式获取textField let login = alertController.textFields![0]
            let oldpass = alertController.textFields!.first!
            var opass = oldpass.text
            print("压缩密码：\(oldpass.text)")
            if(opass == ""){
                self.showMsgbox(_message: "压缩密码不能为空")
            }
            else if((opass?.count)! != 4){
                self.showMsgbox(_message: "压缩密码为4位数")
            }
            else{
                self.toemail(pass: opass!)
            }
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        alertController.addAction(noAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func toemail(pass:String){
        //0.首先判断设备是否能发送邮件
        if MFMailComposeViewController.canSendMail() {
            //1.配置邮件窗口
            let mailView = configuredMailComposeViewController(pwd: pass)
            //2. 显示邮件窗口
            present(mailView, animated: true, completion: nil)
        } else {
            print("Whoop...设备不能发送邮件")
            showSendMailErrorAlert()
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
    func configuredMailComposeViewController(pwd:String) -> MFMailComposeViewController {
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        var files:[Any] = []
        let jsonPath = (docDir as NSString).appendingPathComponent("statement.xlsx")
        files += [jsonPath]
        let zipPath3 = docDir+"/DataSource.zip"
        print("输出数据为\(files)")
        if(pwd == ""){
            SSZipArchive.createZipFile(atPath: zipPath3, withFilesAtPaths: files as! [String])
        }
        else{
            SSZipArchive.createZipFile(atPath: zipPath3, withFilesAtPaths: files as! [String],withPassword: pwd)
        }
        
        print("发送的东西是\(zipPath3)")
        
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        //测试1
        let mimeType1 = mimeType(pathExtension: "gif")
        print("文件1是\(mimeType1)")
        //设置邮件地址、主题及正文
        var theemail:String = ""
        if UserDefaults.standard.object(forKey: "userEmail") != nil {
            var theemails = UserDefaults.standard.object(forKey: "userEmail") as! String
            theemail = theemails
        }
        mailComposeVC.setToRecipients([theemail])
        mailComposeVC.setSubject("我的消费报表")
        if(pwd == ""){
           mailComposeVC.setMessageBody("发送消费报表至邮箱", isHTML: false)
        }
        else{
            mailComposeVC.setMessageBody("发送消费报表至邮箱,压缩密码为\(pwd)", isHTML: false)
        }
        //添加文件附件
        let url = URL(fileURLWithPath: zipPath3)
        let mimeType2 = mimeType(pathExtension: url.pathExtension)
        print("文件类型是\(mimeType2)")
        let myData = try! Data(contentsOf: url)
        mailComposeVC.addAttachmentData(myData, mimeType: mimeType2, fileName: "statement.zip")
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
    func showMsgbox(_message: String, _title: String = "提示"){
        
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
        
    }
}
