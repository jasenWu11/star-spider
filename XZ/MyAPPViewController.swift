//
//  MyAPPViewController.swift
//  XZ
//
//  Created by wjz on 2018/12/21.
//  Copyright © 2018年 wjz. All rights reserved.
//

import UIKit

class MyAPPViewController: UIViewController {

    
    @IBOutlet weak var sv_zl: UIScrollView!
    @IBOutlet weak var sv_api: UIScrollView!
    @IBOutlet weak var sv_sj: UIScrollView!
    @IBOutlet weak var sv_pc: UIScrollView!
    @IBOutlet weak var sv_jq: UIScrollView!
    @IBOutlet weak var segcon: UISegmentedControl!
    @IBAction func Xuanxiang(_ sender: Any) {
        switch segcon.selectedSegmentIndex{
        case 0:
            sv_zl.isHidden = false
            sv_api.isHidden = true
            sv_sj.isHidden = true
            sv_pc.isHidden = true
            sv_jq.isHidden = true
        case 1:
            sv_zl.isHidden = true
            sv_api.isHidden = false
            sv_sj.isHidden = true
            sv_pc.isHidden = true
            sv_jq.isHidden = true
        case 2:
            sv_zl.isHidden = true
            sv_api.isHidden = true
            sv_sj.isHidden = false
            sv_pc.isHidden = true
            sv_jq.isHidden = true
        case 3:
            sv_zl.isHidden = true
            sv_api.isHidden = true
            sv_sj.isHidden = true
            sv_pc.isHidden = false
            sv_jq.isHidden = true
        case 4:
            sv_zl.isHidden = true
            sv_api.isHidden = true
            sv_sj.isHidden = true
            sv_pc.isHidden = true
            sv_jq.isHidden = false
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
