//
//  OperViewController.swift
//  XZ
//
//  Created by wjz on 2019/1/3.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit

class OperViewController: UIViewController {

    @IBOutlet weak var tv_title: UILabel!
    @IBOutlet weak var tv_pid: UILabel!
    @IBOutlet weak var tv_ptype: UILabel!
    @IBOutlet weak var tv_ctime: UILabel!
    @IBOutlet weak var tv_scou: UILabel!
    @IBOutlet weak var tv_xz: UILabel!
    var pid:Int = 0
    var pids: String = ""
    var titles: String = ""
    var ctimes: String = ""
    var types: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print(pid)
        pids = String(pid)
        setvalues()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func setvalues(){
        tv_pid.text = pids
        if (pid == 2238241) {
            titles = "微博热搜版"
            ctimes = "2018-10-19"
            types = "API接口"
        }
        if (pid == 2238242) {
            titles = "百度搜索次数排行版"
            ctimes = "2018-10-22"
            types = "API接口"
        }
        if (pid == 2238243) {
            titles = "携程网机票价格走向"
            ctimes = "2018-11-02"
            types = "数据"
        }
        if (pid == 2238244) {
            titles = "淘宝销售版"
            ctimes = "2018-11-11"
            types = "爬虫"
        }
        if (pid == 2238245) {
            titles = "爱奇艺电影点击排行版"
            ctimes = "2018-11-12"
            types = "API接口"
        }
        if (pid == 2238246) {
            titles = "哔哩哔哩评论量排行"
            ctimes = "2018-11-22"
            types = "爬虫"
        }
        if (pid == 2238247) {
            titles = "深度学习"
            ctimes = "2018-11-30"
            types = "机器学习"
        }
        tv_title.text = titles
        tv_ctime.text = ctimes
        tv_ptype.text = types
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
