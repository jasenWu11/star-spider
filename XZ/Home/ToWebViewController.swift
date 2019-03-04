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
    @IBOutlet weak var ni_title: UINavigationItem!
    var theurl:String = ""
    var thetitle:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        ni_title.title = thetitle
        wv_web.loadRequest(URLRequest(url: NSURL(string : theurl) as! URL))
        // Do any additional setup after loading the view.
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
