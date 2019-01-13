//
//  MyApppagViewController.swift
//  XZ
//
//  Created by wjz on 2019/1/12.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit
import UIKit
import PagingMenuController

//分页菜单配置
private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    //第1个子视图控制器
    private let viewController1 = MyAppTableViewController()
    //第2个子视图控制器
    private let viewController2 = MyAppTableViewController()
    //第3个子视图控制器
    private let viewController3 = MyAppTableViewController()
    //第4个子视图控制器
    private let viewController4 = MyAppTableViewController()
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
            return .text(title: MenuItemText(text: "总览"))
        }
    }
    
    //第2个菜单项
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "数据"))
        }
    }
    //第3个菜单项
    fileprivate struct MenuItem3: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "爬虫"))
        }
    }
    //第4个菜单项
    fileprivate struct MenuItem4: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "API"))
        }
    }
}

//主视图控制器
class MyApppagViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //分页菜单配置
        let options = PagingMenuOptions()
        (options.pagingControllers[0] as! MyAppTableViewController).root = self
        (options.pagingControllers[1] as! MyAppTableViewController).root = self
        (options.pagingControllers[2] as! MyAppTableViewController).root = self
        (options.pagingControllers[3] as! MyAppTableViewController).root = self
        
        //2的数据
        (options.pagingControllers[1] as! MyAppTableViewController).titles = ["携程网机票价格走向","深度学习"]
        (options.pagingControllers[1] as! MyAppTableViewController).types = ["数据","数据"]
        (options.pagingControllers[1] as! MyAppTableViewController).ctimes = ["2018-11-02","2018-11-30"]
        (options.pagingControllers[1] as! MyAppTableViewController).states = ["已停止","正在操作"]
        (options.pagingControllers[1] as! MyAppTableViewController).counts = ["30","18"]
        (options.pagingControllers[1] as! MyAppTableViewController).pidss = [2238243,2238244]
        //3的数据
        (options.pagingControllers[2] as! MyAppTableViewController).titles = ["淘宝销售版","哔哩哔哩评论量排行"]
        (options.pagingControllers[2] as! MyAppTableViewController).types = ["爬虫","爬虫","机器学习"]
        (options.pagingControllers[2] as! MyAppTableViewController).ctimes = ["2018-11-11","2018-11-22"]
        (options.pagingControllers[2] as! MyAppTableViewController).states = ["暂停","正在操作"]
        (options.pagingControllers[2] as! MyAppTableViewController).counts = ["15","20"]
        (options.pagingControllers[2] as! MyAppTableViewController).pidss = [2238244,2238246]
        //4的数据
        (options.pagingControllers[3] as! MyAppTableViewController).titles = ["微博热搜版","百度搜索次数排行版","爱奇艺电影点击排行版"]
        (options.pagingControllers[3] as! MyAppTableViewController).types = ["API接口","API接口","API接口"]
        (options.pagingControllers[3] as! MyAppTableViewController).ctimes = ["2018-10-19","2018-10-22","2018-11-12"]
        (options.pagingControllers[3] as! MyAppTableViewController).states = ["未开始","已停止","未开始"]
        (options.pagingControllers[3] as! MyAppTableViewController).counts = ["0","16","0"]
        (options.pagingControllers[3] as! MyAppTableViewController).pidss = [2238241,2238242,2238245]
        //分页菜单控制器初始化
        let pagingMenuController = PagingMenuController(options: options)
        //分页菜单控制器尺寸设置
        pagingMenuController.view.frame.origin.y += 64
        pagingMenuController.view.frame.size.height -= 64
        
        //建立父子关系
        addChild(pagingMenuController)
        //分页菜单控制器视图添加到当前视图中
        view.addSubview(pagingMenuController.view)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "operDetailView"{
            let controller = segue.destination as! OperViewController
            controller.pid = (sender as? Int)!
        }
    }
}

