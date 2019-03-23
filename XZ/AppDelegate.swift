//
//  AppDelegate.swift
//  XZ
//
//  Created by wjz on 2018/12/20.
//  Copyright © 2018年 wjz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , WXApiDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.statusBarStyle = .lightContent
        // Override point for customization after application launch.
        // 注册app
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().tintColor = UIColor.orange
        WXApi.registerApp("wx81e05f32561a3b3f")
        return true
    }
    
    //重写openURL
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
        return TencentOAuth.handleOpen(url)
    }
    //微信分享完毕后的回调（只有使用真实的AppID才能收到响应）
    func onResp(_ resp: BaseResp!) {
        if resp.isKind(of: SendMessageToWXResp.self) {//确保是对我们分享操作的回调
            if resp.errCode == WXSuccess.rawValue{//分享成功
                print("分享成功")
            }else if resp.errCode == WXErrCodeCommon.rawValue {//普通错误类型
                print("分享失败：普通错误类型")
            }else if resp.errCode == WXErrCodeUserCancel.rawValue {//用户点击取消并返回
                print("分享失败：用户点击取消并返回")
            }else if resp.errCode == WXErrCodeSentFail.rawValue {//发送失败
                print("分享失败：发送失败")
            }else if resp.errCode == WXErrCodeAuthDeny.rawValue {//授权失败
                print("分享失败：授权失败")
            }else if resp.errCode == WXErrCodeUnsupport.rawValue {//微信不支持
                print("分享失败：微信不支持")
            }
        }
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    

}

