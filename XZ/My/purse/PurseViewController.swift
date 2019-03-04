//
//  PurseViewController.swift
//  XZ
//
//  Created by wjz on 2019/2/10.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit
import Alamofire
class PurseViewController: UIViewController ,UITextFieldDelegate{
    @IBOutlet weak var tv_money: UILabel!
    @IBOutlet weak var v_Topup: UIView!
    var yuer : Double = 0.0;
    @IBOutlet weak var l_pursedeail: UILabel!
    var moneys:String = ""
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tv_money.frame.size.width = 200.0  //获取宽度
        tv_money?.textAlignment=NSTextAlignment.left
        if UserDefaults.standard.object(forKey: "userBalance") != nil {
            yuer = UserDefaults.standard.object(forKey: "userBalance") as! Double
        }
        let pursedeailclick = UITapGestureRecognizer(target: self, action: #selector(pursedeailAction))
        l_pursedeail.addGestureRecognizer(pursedeailclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        l_pursedeail.isUserInteractionEnabled = true
        moneys = "\(yuer)"
        tv_money.text = moneys
        
        print("余额\(yuer)")
        let Topupclick = UITapGestureRecognizer(target: self, action: #selector(TopupAction))
        v_Topup.addGestureRecognizer(Topupclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        v_Topup.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    //点击事件方法
    @objc func pursedeailAction() -> Void {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: PursedeailTableViewController())))
            as! PursedeailTableViewController
        self.present(controller, animated: true, completion: nil)
    }
    //点击事件方法
    @objc func TopupAction() -> Void {
       viewDidAppear()
    }
    @objc func viewDidAppear(){
        
        
        let alertController = UIAlertController(title: "钱包充值",
                                                message: "请输入100000以内充值金额(元)", preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "充值金额(元)"
            textField.clearButtonMode=UITextField.ViewMode.whileEditing  //编辑时出现清除按钮
            textField.clearButtonMode=UITextField.ViewMode.unlessEditing  //编辑时不出现，编辑后才出现清除按钮
            textField.clearButtonMode=UITextField.ViewMode.always  //一直显示清除按钮
            textField.delegate = self
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .destructive, handler: {
            action in
            //也可以用下标的形式获取textField let login = alertController.textFields![0]
            let money = alertController.textFields!.first!
            var mon:String = money.text ?? ""
            print("充值金额：\(mon)")
            if(mon == ""){
                self.showMsgbox(_message: "充值金额不能为空")
            }
            else{
                let mon1 = Double(self.moneys)!
                let mon2 = Double(mon)!
                print("充值金额\(mon2)")
//                let mon2 = Double("\(String(describing: mon))")!
                var mons:Double = mon1+mon2
                self.moneys = "\(mons)"
                
                
                var userid:Int = UserDefaults.standard.object(forKey: "userId") as! Int
                let url = "https://www.xingzhu.club/XzTest/recharges/recharge"
                // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
                let paras = ["userId":userid,"rechargerMoney":mon2] as [String : Any]
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
                        self.present(alertController, animated: true, completion: nil)
                        //两秒钟后自动消失
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                            self.presentedViewController?.dismiss(animated: false, completion: nil)
                        }
                        if(message == "充值成功！"){
                          UserDefaults.standard.set(mons, forKey: "userBalance")
                            self.tv_money.text = "\(mons)"
                        }
                    }
                }
            }
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func showMsgbox(_message: String, _title: String = "提示"){
        
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let expression = "^[0-9]*(?:\\.[0-9]{0,2})?$"
        
        do {
            let regex: NSRegularExpression = try NSRegularExpression(pattern: expression, options: NSRegularExpression.Options.caseInsensitive)
            let numberOfMatches = regex.matches(in: newString, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, newString.characters.count))
            
            if numberOfMatches.count == 0{
                return false
            }else{
                
                if newString != "" {
                    if newString[newString.startIndex] == "." {
                        newString = "0" + newString
                    }
                    
                    if newString[newString.index(before: newString.endIndex)] == "." {
                        newString = newString + "0"
                    }
                    
                    if (Double(newString)! > 100000.0){
                        textField.text = "100000"
                        return false
                    }
                }
                return true
            }
        }
        catch {
            return false
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
