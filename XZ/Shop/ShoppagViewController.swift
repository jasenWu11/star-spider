import UIKit
import PagingMenuController
import Alamofire
//分页菜单配置
private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    //第1个子视图控制器
    private let viewController1 = ShopTableViewController()
    //第2个子视图控制器
    private let viewController2 = Shop1TableViewController()
    //第3个子视图控制器
    private let viewController3 = Shop2TableViewController()
    //第4个子视图控制器
    private let viewController4 = Shop3TableViewController()
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
            return .text(title: MenuItemText(text: "全部产品"))
        }
    }
    
    //第2个菜单项
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "新闻媒体"))
        }
    }
    //第3个菜单项
    fileprivate struct MenuItem3: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "电子商务"))
        }
    }
    //第4个菜单项
    fileprivate struct MenuItem4: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "社交网络"))
        }
    }
}

//主视图控制器
class ShoppagViewController: UIViewController {
    var pid1:[Int] = []
    var title1:[String] = []
    var content1:[String] = []
    var image1:[String] = []
    var price1:[Double] = []
    var Ntitle:String = ""
    var pids:Int = 0
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
        getAllProducts()
        
        //分页菜单配置
        let options = PagingMenuOptions()
        (options.pagingControllers[0] as! ShopTableViewController).root = self
        (options.pagingControllers[1] as! Shop1TableViewController).root = self
        (options.pagingControllers[2] as! Shop2TableViewController).root = self
        (options.pagingControllers[3] as! Shop3TableViewController).root = self
//        //1的数据
//        (options.pagingControllers[0] as! ShopTableViewController).titles = title1
//        (options.pagingControllers[0] as! ShopTableViewController).contents = content1
//        (options.pagingControllers[0] as! ShopTableViewController).images = image1
//        (options.pagingControllers[0] as! ShopTableViewController).price = price1
//        (options.pagingControllers[0] as! ShopTableViewController).pidss = pid1
//        //2的数据
//        (options.pagingControllers[1] as! ShopTableViewController).titles = ["微博热搜版","爱奇艺点击率最高电影"]
//        (options.pagingControllers[1] as! ShopTableViewController).contents = ["获取微博热搜版，研究大众兴趣","获取爱奇艺点击率最高电影,可以方便找到票房较高的电影，筛选避过烂片"]
//        (options.pagingControllers[1] as! ShopTableViewController).images = ["weibo","aiqiyi"]
//        (options.pagingControllers[1] as! ShopTableViewController).price = [81.04,130.5]
//        (options.pagingControllers[1] as! ShopTableViewController).pidss = [2238241,2238245]
//        //3的数据
//        (options.pagingControllers[2] as! ShopTableViewController).titles = ["淘宝销售排行","百度搜索次数排行版"]
//        (options.pagingControllers[2] as! ShopTableViewController).contents = ["获取淘宝销售排行，可以作为准备开网店的前期互联网用户需求分析调查研究使用","获取百度网搜索次数排行，分析用户需求"]
//        (options.pagingControllers[2] as! ShopTableViewController).images = ["taobao","baidu"]
//        (options.pagingControllers[2] as! ShopTableViewController).price = [75.04,126.5]
//        (options.pagingControllers[2] as! ShopTableViewController).pidss = [2238244,2238242]
        //分页菜单控制器初始化
        let pagingMenuController = PagingMenuController(options: options)
        //分页菜单控制器尺寸设置
        pagingMenuController.view.frame.origin.y += 0
        pagingMenuController.view.frame.size.height -= 0
        
        //建立父子关系
        addChild(pagingMenuController)
        //分页菜单控制器视图添加到当前视图中
        view.addSubview(pagingMenuController.view)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @objc func todeatil() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: APImessViewController())))
            as! APImessViewController
        controller.pid = self.pids
        controller.datatitles = self.Ntitle
        controller.hidesBottomBarWhenPushed = true
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    @objc func custom() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: CustommadeViewController())))
            as! CustommadeViewController
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "deatil"{
            let controller = segue.destination as! APImessViewController
            controller.pid = (sender as? Int)!
            controller.datatitles = self.Ntitle
        }
        if segue.identifier == "custom"{
            let controller = segue.destination as! CustommadeViewController
        }
    }
    func getAllProducts()  {
            let url = "https://www.xingzhu.club/XzTest/products/getAllProducts"
            // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
            Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                print("jsonRequest:\(response.result)")
                if let data = response.result.value {
                    let json = JSON(data)
                    var code: Int = json["code"].int!
                    print("错误:\(code)")
                    var message:String = json["message"].string!
                    print("提示:\(message)")
                    let provinces = json["data"]
                    for i in 0..<provinces.count{
                        let productId: Int = provinces[i]["productId"].int ?? 0
                        self.pid1 += [productId]
                        
                        let productTitle: String = provinces[i]["productTitle"].string ?? ""
                        self.title1 += [productTitle]
                        
                        let productDes: String = provinces[i]["productDes"].string ?? ""
                        self.content1 += [productDes]
                        
                        let productPhoto: String = provinces[i]["productPhoto"].string ?? ""
                        self.image1 += [productPhoto]
                        
                        let productPriceMonth: Double = provinces[i]["productPriceMonth"].double ?? 0
                        self.price1 += [productPriceMonth]
                    }
                    print("标题是\(self.title1)")
            }
    }
}
}

