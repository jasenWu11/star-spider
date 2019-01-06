//
//  SHIchangViewController.swift
//  XZ
//
//  Created by wjz on 2018/12/21.
//  Copyright © 2018年 wjz. All rights reserved.
//

import UIKit

class SHIchangViewController: UIViewController {

    
    @IBOutlet weak var ssv_api: UIScrollView!
    @IBOutlet weak var ssv_sj: UIScrollView!
    @IBOutlet weak var ssv_pc: UIScrollView!
    @IBOutlet weak var ssv_jqxx: UIScrollView!
    @IBOutlet weak var segcon: UISegmentedControl!
    var pid:String = ""
    override func viewDidAppear(_ animated: Bool) {
        ssv_api.contentSize = CGSize.init(width: UIScreen.main.bounds.width, height: 600);
        ssv_api.isScrollEnabled=true;
        ssv_api.showsVerticalScrollIndicator = false;
        ssv_sj.contentSize = CGSize.init(width: UIScreen.main.bounds.width, height: 600);
        ssv_sj.isScrollEnabled=true;
        ssv_sj.showsVerticalScrollIndicator = false;
        ssv_pc.contentSize = CGSize.init(width: UIScreen.main.bounds.width, height: 600);
        ssv_pc.isScrollEnabled=true;
        ssv_pc.showsVerticalScrollIndicator = false;
        ssv_jqxx.contentSize = CGSize.init(width: UIScreen.main.bounds.width, height: 600);
        ssv_jqxx.isScrollEnabled=true;
        ssv_jqxx.showsVerticalScrollIndicator = false;
    }
    @IBAction func Xuanxiang(_ sender: Any) {
        switch segcon.selectedSegmentIndex{
        case 0:
            ssv_api.isHidden = false
            ssv_sj.isHidden = true
            ssv_pc.isHidden = true
            ssv_jqxx.isHidden = true
        case 1:
            ssv_api.isHidden = true
            ssv_sj.isHidden = false
            ssv_pc.isHidden = true
            ssv_jqxx.isHidden = true
        case 2:
            ssv_api.isHidden = true
            ssv_sj.isHidden = true
            ssv_pc.isHidden = false
            ssv_jqxx.isHidden = true
        case 3:
            ssv_api.isHidden = true
            ssv_sj.isHidden = true
            ssv_pc.isHidden = true
            ssv_jqxx.isHidden = false
        default:
            break
    }
}
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
