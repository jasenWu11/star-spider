//
//  MainViewController.swift
//  XZ
//
//  Created by wjz on 2018/12/27.
//  Copyright © 2018年 wjz. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func hideTabbar(hidden: Bool) {
        UIView.animate(withDuration: 0.2) {
            if hidden {
                var frame = self.tabBar.frame
                frame.origin.y = self.screenHeight
                self.tabBar.frame = frame
            } else {
                var frame = self.tabBar.frame
                frame.origin.y = self.screenHeight
                self.tabBar.frame = frame
            }
        }
    }
    func hidetabbars(hidden: Bool){
        UIView.animate(withDuration: 0.2){
            if hidden {
                self.tabBar.frame.origin.y += 100
            }
            else{
                self.tabBar.frame.origin.y -= 100
            }
        }
    }
    //代理点击事件
    func getheight()->CGFloat{
        let height = self.tabBar.frame.size.height
        return height
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
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
