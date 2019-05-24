//
//  MyApppagViewController.swift
//  XZ
//
//  Created by wjz on 2019/1/12.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit
import PagingMenuController

//分页菜单配置
private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    //第1个子视图控制器
    private let viewController1 = MyAppTableViewController()
    //第2个子视图控制器
    private let viewController2 = DataSourceTableViewController()
    //组件类型
    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    
    //所有子视图控制器
    fileprivate var pagingControllers: [UIViewController] {
        return [viewController1, viewController2]
    }
    
    //菜单配置项
    fileprivate struct MenuOptions: MenuViewCustomizable {
        //菜单显示模式
        var displayMode: MenuDisplayMode {
            return .segmentedControl
        }
        //菜单项
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItem1(), MenuItem2()]
        }
    }
    
    //第1个菜单项
    fileprivate struct MenuItem1: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "我的应用"))
        }
    }
    
    //第2个菜单项
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "数据源"))
        }
    }
}

//主视图控制器
class MyApppagViewController: UIViewController {
    var iskey:Int = 0
    var Ntitle:String = ""
    var dataName:String = ""
    var crawlername:String = ""
    var pids:Int = 0
    var etimes:String = ""
    var quitheight:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        //导航栏高度
        let nv_height = self.navigationController?.navigationBar.frame.size.height
        //状态栏高度
        let zt_height = UIApplication.shared.statusBarFrame.height

        let tabBarHeight = (zt_height==44 ? 83 : 49)
        let theheight = CGFloat((tabBarHeight))
        quitheight = Int(nv_height!+zt_height+theheight)
        print("高度是\(quitheight)和\(nv_height)和\(zt_height)")
        //关闭导航栏半透明效果
        self.navigationController?.navigationBar.isTranslucent = false
        //分页菜单配置
        let options = PagingMenuOptions()
        (options.pagingControllers[0] as! MyAppTableViewController).root = self
        (options.pagingControllers[1] as! DataSourceTableViewController).root = self
        //分页菜单控制器初始化
        let pagingMenuController = PagingMenuController(options: options)
        //分页菜单控制器尺寸设置
        pagingMenuController.view.frame.origin.y += 0
        pagingMenuController.view.frame.size.height -= 0
        pagingMenuController.onMove = { state in
            switch state {
            case let .willMoveItem(menuItemView, previousMenuItemView):
                print("--- 标签将要切换 ---")
            case let .didMoveItem(menuItemView, previousMenuItemView):
                print("--- 标签切换完毕 ---")
                if(menuItemView.titleLabel.text == "我的应用"){
                    (options.pagingControllers[0] as! MyAppTableViewController).headerres()
                    print("刷新爬虫")
                }
                if(menuItemView.titleLabel.text == "数据源"){
                    (options.pagingControllers[1] as! DataSourceTableViewController).headerres()
                    print("刷新数据源")
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
        //建立父子关系
        addChild(pagingMenuController)
        //分页菜单控制器视图添加到当前视图中
        view.addSubview(pagingMenuController.view)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @objc func operDetailView() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: OperateViewController())))
            as! OperateViewController
        controller.crawlername = self.crawlername
        controller.iskey = self.iskey
        controller.Ntitle = self.Ntitle
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    @objc func MyOrder() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: BuyappViewController())))
            as! BuyappViewController
        controller.pids = pids
        controller.etime = etimes
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    @objc func datasourceDetailView() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: DataSourceViewController())))
            as! DataSourceViewController
        controller.Ntitle = self.Ntitle
        controller.dataName = self.dataName
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        self.hidesBottomBarWhenPushed = false
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

