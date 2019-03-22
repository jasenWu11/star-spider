//
//  ToWebViewController.swift
//  XZ
//
//  Created by wjz on 2019/3/4.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit

class ToWebViewController: UIViewController {
    @IBOutlet weak var wv_web: UIWebView!
    var theurl:String = ""
    var thetitle:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.title = thetitle
        print("标题\(thetitle)")
        wv_web.loadRequest(URLRequest(url: NSURL(string : theurl)! as URL))
        // Do any additional setup after loading the view.
    }
    @IBAction func back(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false, completion: nil)
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
