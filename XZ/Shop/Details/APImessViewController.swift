//
//  APImessViewController.swift
//  XZ
//
//  Created by wjz on 2018/12/26.
//  Copyright © 2018年 wjz. All rights reserved.
//

import UIKit
import PagingMenuController
import Alamofire
//分页菜单配置
private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    //第1个子视图控制器
    private let viewController1 = messViewController()
    //第2个子视图控制器
    private let viewController2 = ShiliViewController()
    //第3个子视图控制器
    private let viewController3 = messViewController()
    //第4个子视图控制器
    private let viewController4 = HistoryViewController()
    //组件类型
    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    
    //所有子视图控制器
    fileprivate var pagingControllers: [UIViewController] {
        return [viewController1, viewController2, viewController3, viewController4]
    }
    
    //菜单配置项
    fileprivate struct MenuOptions: MenuViewCustomizable {
        //菜单显示模式
        var displayMode: MenuDisplayMode {
            return .segmentedControl
        }
        //菜单项
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItem1(), MenuItem2(), MenuItem3(), MenuItem4()]
        }
    }
    
    //第1个菜单项
    fileprivate struct MenuItem1: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "应用信息"))
        }
    }
    
    //第2个菜单项
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "应用详情"))
        }
    }
    //第3个菜单项
    fileprivate struct MenuItem3: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "API调用说明"))
        }
    }
    //第4个菜单项
    fileprivate struct MenuItem4: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "版本说明"))
        }
    }
}

class APImessViewController: UIViewController {
    var pid:Int = 0
    var userid:Int = 0
    var proedit : String = ""
    var prouptime : String = ""
    var hight:CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        userid = UserDefaults.standard.object(forKey: "userId") as! Int
        //分页菜单配置
        let options = PagingMenuOptions()
        (options.pagingControllers[0] as! messViewController).root = self
        (options.pagingControllers[1] as! ShiliViewController).root = self
        (options.pagingControllers[2] as! messViewController).root = self
        (options.pagingControllers[3] as! HistoryViewController).root = self
        (options.pagingControllers[0] as! messViewController).pids = pid
        //分页菜单控制器初始化
        let pagingMenuController = PagingMenuController(options: options)
        //分页菜单控制器尺寸设置
        pagingMenuController.view.frame.origin.y += 64
        pagingMenuController.view.frame.size.height -= 119
        let hights = pagingMenuController.view.frame.size.height
        hight = hights
        print("高度等于\(hights)")
        
        //建立父子关系
        addChild(pagingMenuController)
        //分页菜单控制器视图添加到当前视图中
        view.addSubview(pagingMenuController.view)
        print("传进来的商品是\(pid)")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func Xiadan(_ sender: Any) {
        self.createApp()
//        let url = "https://www.xingzhu.club/XzTest/orders/postOrder"
//        let paras = ["productId":self.pid,"userId":self.userid]
//        print("商品ID\(self.pid),用户\(self.userid)")
//        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
//        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
//            print("jsonRequest:\(response.result)")
//
//            if let data = response.result.value {
//                let json = JSON(data)
//                print("结果:\(json)")
//                var code: Int = json["code"].int!
//                print("错误:\(code)")
//                var message:String = json["message"].string!
//                print("提示:\(message)")
//                if (message == "创建订单成功！") {
//                    self.createApp()
//                    let alertController = UIAlertController(title: "\(message)",
//                                                            message: nil, preferredStyle: .alert)
//                    //显示提示框
//                    self.present(alertController, animated: true, completion: nil)
//                    //两秒钟后自动消失
//                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
//                        self.presentedViewController?.dismiss(animated: false, completion: nil)
//                    }
//                }
//                else{
//                    let alertController = UIAlertController(title: "\(message)",
//                                                            message: nil, preferredStyle: .alert)
//                    //显示提示框
//                    self.present(alertController, animated: true, completion: nil)
//                    //两秒钟后自动消失
//                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
//                        self.presentedViewController?.dismiss(animated: false, completion: nil)
//                    }
//                }
//            }
//        }
       
    }
    func createApp() {
        let url = "https://www.xingzhu.club/XzTest/apps/createApp"
        let paras = ["productId":self.pid,"userId":self.userid]
        print("商品ID\(self.pid),用户\(self.userid)")
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("jsonRequest:\(response.result)")
            
            if let data = response.result.value {
                let json = JSON(data)
                print("结果:\(json)")
                var code: Int = json["code"].int!
                print("错误:\(code)")
                var message:String = json["message"].string!
                print("创建应用提示:\(message)")
            }
        }
        
    }
    
}

