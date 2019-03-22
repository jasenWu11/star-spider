//
//  AboutusViewController.swift
//  XZ
//
//  Created by wjz on 2018/12/21.
//  Copyright © 2018年 wjz. All rights reserved.
//

import UIKit

class AboutusViewController: UIViewController {

    @IBAction func back(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "关于我们"
        let handLeftRight = UISwipeGestureRecognizer(target: self, action: #selector(funLeftRight))
        //handLeftRight.direction = .left //支持向左
        self.view.addGestureRecognizer(handLeftRight)
        // Do any additional setup after loading the view.
    }
    
    @objc func funLeftRight(sender: UIPanGestureRecognizer){
        
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
