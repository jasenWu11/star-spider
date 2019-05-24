//
//  MyorderpagViewController.swift
//  XZ
//
//  Created by wjz on 2019/3/8.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit
import UIKit
import PagingMenuController

//分页菜单配置
private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    //第1个子视图控制器
    private let viewController1 = MyorderTableViewController()
    //第2个子视图控制器
    private let viewController2 = MyorderisnpayViewController()
    //第3个子视图控制器
    private let viewController3 = MyorderispayTableViewController()
    //第4个子视图控制器
    private let viewController4 = MyordercloseTableViewController()
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
            return .text(title: MenuItemText(text: "全部订单"))
        }
    }
    
    //第2个菜单项
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "未支付"))
        }
    }
    //第3个菜单项
    fileprivate struct MenuItem3: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "已支付"))
        }
    }
    //第4个菜单项
    fileprivate struct MenuItem4: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "已关闭"))
        }
    }
}
class MyorderpagViewController: UIViewController {
    var iskey:Int = 0
    var Ntitle:String = ""
    var dataName:String = ""
    var quitheight:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        //导航栏高度
        let nv_height = self.navigationController?.navigationBar.frame.size.height
        //状态栏高度
        let zt_height = UIApplication.shared.statusBarFrame.height
        
        let tabBarHeight = (zt_height==44 ? 83 : 49)
        let theheight = CGFloat((tabBarHeight))
        quitheight = Int(nv_height!+zt_height)
        print("高度是\(quitheight)和\(nv_height)和\(zt_height)")
        self.title = "我的订单"
        //分页菜单配置
        let options = PagingMenuOptions()
        (options.pagingControllers[0] as! MyorderTableViewController).root = self
        (options.pagingControllers[1] as! MyorderisnpayViewController).root = self
        (options.pagingControllers[2] as! MyorderispayTableViewController).root = self
        (options.pagingControllers[3] as! MyordercloseTableViewController).root = self
        //分页菜单控制器初始化
        let pagingMenuController = PagingMenuController(options: options)
        pagingMenuController.onMove = { state in
            switch state {
            case let .willMoveItem(menuItemView, previousMenuItemView):
                print("--- 标签将要切换 ---")
            case let .didMoveItem(menuItemView, previousMenuItemView):
                print("--- 标签切换完毕 ---")
                if(menuItemView.titleLabel.text == "全部订单"){
                    (options.pagingControllers[0] as! MyorderTableViewController).Refresh()
                    print("刷新全部订单")
                }
                if(menuItemView.titleLabel.text == "未支付"){
                    (options.pagingControllers[1] as! MyorderisnpayViewController).Refresh()
                    print("刷新未支付")
                }
                if(menuItemView.titleLabel.text == "已支付"){
                    (options.pagingControllers[2] as! MyorderispayTableViewController).Refresh()
                    print("刷新已支付")
                }
                if(menuItemView.titleLabel.text == "已关闭"){
                    (options.pagingControllers[3] as! MyordercloseTableViewController).Refresh()
                    print("刷新已关闭")
                }
            case let .willMoveController(menuController, previousMenuController):
                print("--- 页面将要切换 ---")
            case let .didMoveController(menuController, previousMenuController):
                print("--- 页面切换完毕 ---")
            case .didScrollStart:
                print("--- 分页开始左右滑动 ---")
            case .didScrollEnd:
                print("--- 分页停止左右滑动 ---")
            }
        }
        //分页菜单控制器尺寸设置
        pagingMenuController.view.frame.origin.y += 0
        pagingMenuController.view.frame.size.height -= 0
        
        //建立父子关系
        addChild(pagingMenuController)
        //分页菜单控制器视图添加到当前视图中
        view.addSubview(pagingMenuController.view)
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "operDetailView"{
            let controller = segue.destination as! OperateViewController
            controller.crawlername = (sender as? String)!
            controller.iskey = self.iskey
            controller.Ntitle = self.Ntitle
        }
        if segue.identifier == "MyOrder"{
            let controller = segue.destination as! BuyappViewController
            controller.pids = (sender as? Int)!
        }
        if segue.identifier == "datasourceDetailView"{
            let controller = segue.destination as! DataSourceViewController
            controller.Ntitle = self.Ntitle
            controller.dataName = self.dataName
        }
    }
}

