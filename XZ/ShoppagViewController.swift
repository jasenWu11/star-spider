import UIKit
import PagingMenuController

//分页菜单配置
private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    //第1个子视图控制器
    private let viewController1 = ShopTableViewController()
    //第2个子视图控制器
    private let viewController2 = ShopTableViewController()
    //第3个子视图控制器
    private let viewController3 = ShopTableViewController()
    //组件类型
    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    
    //所有子视图控制器
    fileprivate var pagingControllers: [UIViewController] {
        return [viewController1, viewController2, viewController3]
    }
    
    //菜单配置项
    fileprivate struct MenuOptions: MenuViewCustomizable {
        //菜单显示模式
        var displayMode: MenuDisplayMode {
            return .segmentedControl
        }
        //菜单项
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItem1(), MenuItem2(), MenuItem3()]
        }
    }
    
    //第1个菜单项
    fileprivate struct MenuItem1: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "数据"))
        }
    }
    
    //第2个菜单项
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "爬虫"))
        }
    }
    //第3个菜单项
    fileprivate struct MenuItem3: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "API"))
        }
    }
}

//主视图控制器
class ShoppagViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //分页菜单配置
        let options = PagingMenuOptions()
        (options.pagingControllers[0] as! ShopTableViewController).root = self
        (options.pagingControllers[1] as! ShopTableViewController).root = self
        (options.pagingControllers[2] as! ShopTableViewController).root = self
        //2的数据
        (options.pagingControllers[1] as! ShopTableViewController).titles = ["微博热搜版","爱奇艺点击率最高电影"]
        (options.pagingControllers[1] as! ShopTableViewController).contents = ["获取微博热搜版，研究大众兴趣","获取爱奇艺点击率最高电影,可以方便找到票房较高的电影，筛选避过烂片"]
        (options.pagingControllers[1] as! ShopTableViewController).images = ["weibo","aiqiyi"]
        (options.pagingControllers[1] as! ShopTableViewController).price = ["¥81.04","¥130.5"]
        (options.pagingControllers[1] as! ShopTableViewController).pidss = [2238241,2238245]
        //3的数据
        (options.pagingControllers[2] as! ShopTableViewController).titles = ["淘宝销售排行","百度搜索次数排行版"]
        (options.pagingControllers[2] as! ShopTableViewController).contents = ["获取淘宝销售排行，可以作为准备开网店的前期互联网用户需求分析调查研究使用","获取百度网搜索次数排行，分析用户需求"]
        (options.pagingControllers[2] as! ShopTableViewController).images = ["taobao","baidu"]
        (options.pagingControllers[2] as! ShopTableViewController).price = ["¥75.04","¥126.5"]
        (options.pagingControllers[2] as! ShopTableViewController).pidss = [2238244,2238242]
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
        if segue.identifier == "deatil"{
            let controller = segue.destination as! APImessViewController
            controller.pid = (sender as? Int)!
        }
    }
}

