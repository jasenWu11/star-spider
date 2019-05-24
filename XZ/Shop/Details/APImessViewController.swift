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
<<<<<<< HEAD
    private let viewController3 = HistoryViewController()
=======
    private let viewController3 = messViewController()
    //第4个子视图控制器
    private let viewController4 = HistoryViewController()
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
    //组件类型
    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    
    //所有子视图控制器
    fileprivate var pagingControllers: [UIViewController] {
<<<<<<< HEAD
        return [viewController1, viewController2, viewController3]
=======
        return [viewController1, viewController2, viewController3, viewController4]
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
    }
    
    //菜单配置项
    fileprivate struct MenuOptions: MenuViewCustomizable {
        //菜单显示模式
        var displayMode: MenuDisplayMode {
            return .segmentedControl
        }
        //菜单项
        var itemsOptions: [MenuItemViewCustomizable] {
<<<<<<< HEAD
            return [MenuItem1(), MenuItem2(), MenuItem3()]
=======
            return [MenuItem1(), MenuItem2(), MenuItem3(), MenuItem4()]
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
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
<<<<<<< HEAD
            return .text(title: MenuItemText(text: "数据示例"))
        }
    }
    //第4个菜单项
    fileprivate struct MenuItem3: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
=======
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
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
            return .text(title: MenuItemText(text: "版本说明"))
        }
    }
}

class APImessViewController: UIViewController {
    var pid:Int = 0
<<<<<<< HEAD
    var datatitles:String = ""
=======
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
    var userid:Int = 0
    var proedit : String = ""
    var prouptime : String = ""
    var hight:CGFloat = 0.0
<<<<<<< HEAD
    var thesly:CGFloat = 0.0
    var scene = Int32(WXSceneSession.rawValue)
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //导航栏高度
        let nv_height = self.navigationController?.navigationBar.frame.size.height
        //状态栏高度
        let zt_height = UIApplication.shared.statusBarFrame.height
        thesly = nv_height!+zt_height
        self.title = datatitles
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title:"+",style:UIBarButtonItem.Style.plain,target:self,action:#selector(menu))
        self.navigationItem.rightBarButtonItem?.image = UIImage(named: "share")
=======
    override func viewDidLoad() {
        super.viewDidLoad()
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
        userid = UserDefaults.standard.object(forKey: "userId") as! Int
        //分页菜单配置
        let options = PagingMenuOptions()
        (options.pagingControllers[0] as! messViewController).root = self
        (options.pagingControllers[1] as! ShiliViewController).root = self
<<<<<<< HEAD
        (options.pagingControllers[2] as! HistoryViewController).root = self
        (options.pagingControllers[0] as! messViewController).pids = pid
        (options.pagingControllers[1] as! ShiliViewController).pids = pid
        //分页菜单控制器初始化
        let pagingMenuController = PagingMenuController(options: options)
        //分页菜单控制器尺寸设置
        pagingMenuController.view.frame.origin.y += 0
        pagingMenuController.view.frame.size.height = screenHeight-nv_height!-zt_height
        let hights = pagingMenuController.view.frame.size.height
        let tabBarHeight = (zt_height==44 ? 34 : 0)
        hight = hights-55-CGFloat(tabBarHeight)
        print("高度等于\(hight)")
=======
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
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
        
        //建立父子关系
        addChild(pagingMenuController)
        //分页菜单控制器视图添加到当前视图中
        view.addSubview(pagingMenuController.view)
        print("传进来的商品是\(pid)")
    }
<<<<<<< HEAD

=======
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func Xiadan(_ sender: Any) {
<<<<<<< HEAD
        self.createApp()
=======
        let url = "https://www.xingzhu.club/XzTest/orders/postOrder"
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
                print("提示:\(message)")
                if (message == "创建订单成功！") {
                    self.createApp()
                    let alertController = UIAlertController(title: "\(message)",
                                                            message: nil, preferredStyle: .alert)
                    //显示提示框
                    self.present(alertController, animated: true, completion: nil)
                    //两秒钟后自动消失
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                        self.presentedViewController?.dismiss(animated: false, completion: nil)
                    }
                }
                else{
                    let alertController = UIAlertController(title: "\(message)",
                                                            message: nil, preferredStyle: .alert)
                    //显示提示框
                    self.present(alertController, animated: true, completion: nil)
                    //两秒钟后自动消失
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                        self.presentedViewController?.dismiss(animated: false, completion: nil)
                    }
                }
            }
        }
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
       
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
<<<<<<< HEAD
                let alertController = UIAlertController(title: message,
                                                        message: nil, preferredStyle: .alert)
                //显示提示框
                self.present(alertController, animated: true, completion: nil)
                //两秒钟后自动消失
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                    self.presentedViewController?.dismiss(animated: false, completion: nil)
                }
=======
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
            }
        }
        
    }
<<<<<<< HEAD
    @objc func menu(_ sender: Any) {
        let items: [String] = ["分享到微信","分享朋友圈","生成二维码"]
        let imgSource: [String] = ["wechat","pyq","erweima"]
        NavigationMenuShared.showPopMenuSelecteWithFrameWidth(width: itemWidth, height: 160, point: CGPoint(x: ScreenInfo.Width - 30, y: 0), item: items, imgSource: imgSource) { (index) in
            ///点击回调
            switch index{
            case 0:
                self.scene = Int32(WXSceneSession.rawValue)
                self.share()
            case 1:
                self.scene = Int32(WXSceneTimeline.rawValue)
                self.share()
            default:
                break
            }
        }
    }
    func share(){
        let message =  WXMediaMessage()
        
        message.title = "星蛛数据-\(self.datatitles)"
        message.description = "星蛛数据服务平台，获取您最需要的数据。"
        message.setThumbImage(UIImage(named:"sendlogo.png"))
        
        let ext =  WXWebpageObject()
        ext.webpageUrl = "https://www.xingzhu.club/v1.0/#/to-mark/crawler/crawler-details?clistId=\(self.pid)"
        message.mediaObject = ext
        
        let req =  SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = scene
        WXApi.send(req)
    }
=======
    
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
}

