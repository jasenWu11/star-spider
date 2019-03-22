//
//  messagereadnTableViewCell.swift
//  XZ
//
//  Created by wjz on 2019/3/20.
//  Copyright © 2019年 wjz. All rights reserved.
//
import UIKit
import Alamofire
class messagereadnTableViewCell: UITableViewCell {
    //视图
    var v_mess:UIButton?
    var tableView:UITableView?
    //类型
    var tv_mid: UILabel?
    //标题
    var tv_title: UILabel?
    //创建时间
    var tv_ctime: UILabel?
    //结束时间
    var tv_etime: UILabel?
    //统计量
    var tv_content: UITextView?
    //产品单价标签
    var l_price: UILabel?
    //单价
    var tv_price:UILabel?
    //支付时间标签
    var l_mtime:UILabel?
    //支付时间
    var tv_mtime:UILabel?
    //状态
    var tv_states:UILabel?
    var bt_oper : UIButton?
    var bt_dele : UIButton?
    var tv_mids: UILabel?
    var tv_ctimes: UILabel?
    var tv_etimes: UILabel?
    var tv_contents: UILabel?
    var yuer : Double = 0.0;
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    var root : messagereadnTableViewController?
    var pid:Int = 5
    var pids:Int = 5
    var userid:Int = UserDefaults.standard.object(forKey: "userId") as! Int
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    @objc func Operactions(subButton: UIButton) {
        print(subButton.tag)
        let mids : Int = (root?.midss[subButton.tag])!
        var thecontenes : String = (root?.contents[subButton.tag])!
        var sentime : String = (root?.omtimes[subButton.tag])!
        showMsgbox(_message: thecontenes,_messid: mids,_messtime: sentime)
    }
    //    @objc func viewDidAppear(mids:Int,pids:Int,price:Double){
    //
    //
    //        let alertController = UIAlertController(title: "支付密码",
    //                                                message: "请输入支付密码", preferredStyle: .alert)
    //        alertController.addTextField {
    //            (textField: UITextField!) -> Vmid in
    //            textField.placeholder = "原密码"
    //        }
    //
    //        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
    //        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
    //            action in
    //            //也可以用下标的形式获取textField let login = alertController.textFields![0]
    //            let paypass = alertController.textFields!.first!
    //            var ppass = paypass.text
    //            if(ppass == ""){
    //                self.showMsgbox(_message: "支付密码不能为空")
    //            }
    //            else{
    //                self.payok(orderids: mids, productids: pids, prices: price, ppass: ppass!)
    //            }
    //        })
    //        alertController.addAction(cancelAction)
    //        alertController.addAction(okAction)
    //        root?.present(alertController, animated: true, completion: nil)
    //    }
    
    func payok(orderids:Int,productids:Int,prices:Double,ppass:String){
        var userid:Int = UserDefaults.standard.object(forKey: "userId") as! Int
        let url = "https://www.xingzhu.club/XzTest/orders/payOrder"
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        let paras = ["userId":userid,"orderId":orderids,"productId":productids,"productPriceMonth":prices,"payType":0,"userPayPassword":ppass] as [String : Any]
        print("订单ID\(orderids)")
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("jsonRequest:\(response.result)")
            var request : String = "\(response.result)"
            if let data = response.result.value {
                let json = JSON(data)
                print("结果:\(json)")
                let code: Int = json["code"].int!
                print("错误:\(code)")
                var message:String = json["message"].string!
                print("message\(message)")
                let alertController = UIAlertController(title: "\(message)",
                    message: nil, preferredStyle: .alert)
                //显示提示框
                self.root?.present(alertController, animated: true, completion: nil)
                //两秒钟后自动消失
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.root?.presentedViewController?.dismiss(animated: false, completion: nil)
                }
                if(message == "订单支付成功！"){
                    if UserDefaults.standard.object(forKey: "userBalance") != nil {
                        self.yuer = UserDefaults.standard.object(forKey: "userBalance") as! Double
                    }
                    UserDefaults.standard.set(self.yuer-prices, forKey: "userBalance")
                }
            }
            
        }
    }
    
    
    func setUpUI(){
        //视图
        v_mess = UIButton(frame: CGRect(x:5, y: 5, width:screenWidth-10, height: 90))
        v_mess?.backgroundColor=UIColor.white
        v_mess?.clipsToBounds=true
        v_mess?.layer.cornerRadius = 8
        v_mess?.layer.shadowColor = UIColor.gray.cgColor
        v_mess?.layer.shadowOpacity = 1.0
        v_mess?.layer.shadowOffset = CGSize(width: 0, height: 0)
        v_mess?.layer.shadowRadius = 4
        v_mess?.layer.masksToBounds = false
        v_mess?.addTarget(self, action: #selector(Operactions), for: UIControl.Event.touchUpInside)
        self.addSubview(v_mess!)
        //标号标签
        tv_mids = UILabel(frame: CGRect(x:10, y:10, width: 80, height:20))
        tv_mids?.font = UIFont.systemFont(ofSize: 14)
        tv_mids?.textColor = UIColor.black
        tv_mids?.text = "消息编号："
        v_mess?.addSubview(tv_mids!)
        // 编号
        tv_mid = UILabel(frame: CGRect(x:75, y:10, width: 100, height:20))
        tv_mid?.font = UIFont.systemFont(ofSize: 14)
        tv_mid?.textColor = UIColor.black
        v_mess?.addSubview(tv_mid!)
        // 大标题
        tv_title = UILabel(frame: CGRect(x:10, y: 35, width:screenWidth-10, height: 20))
        tv_title?.font = UIFont.systemFont(ofSize: 14)
        tv_title?.textColor = UIColor.black
        v_mess?.addSubview(tv_title!)
        // 支付时间
        tv_mtime = UILabel(frame: CGRect(x:10, y:60, width: screenWidth-100, height:20))
        tv_mtime?.font = UIFont.systemFont(ofSize: 14)
        tv_mtime?.textColor = UIColor.black
        v_mess?.addSubview(tv_mtime!)
        //状态
        // 状态
        tv_states = UILabel(frame: CGRect(x:screenWidth-60, y:(90-40)/2, width:40, height: 40))
        tv_states?.font = UIFont.systemFont(ofSize: 14)
        tv_states?.textColor = UIColor.white
        tv_states?.backgroundColor = UIColor.red
        tv_states?.text = "状态"
        tv_states?.layer.cornerRadius = 20
        tv_states?.layer.borderWidth = 0.5
        tv_states?.layer.masksToBounds = true
        tv_states?.textAlignment=NSTextAlignment.center
        v_mess?.addSubview(tv_states!)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func showMsgbox(_message: String,_messid: Int,_messtime: String ,_title: String = "消息内容"){
        
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        root?.present(alert, animated: true, completion: nil)
        getMyNotices(noticeId: _messid,sendTime: _messtime)
    }
    @objc func getMyNotices(noticeId:Int,sendTime:String)  {
        let url = "https://www.xingzhu.club/XzTest/notices/setNoticeStatus"
        let paras = ["userId":self.userid,"noticeId":noticeId,"sendTime":sendTime] as [String : Any]
        print("用户ID\(self.userid)")
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
                self.root?.Refresh()
            }
        }
        
    }
}

