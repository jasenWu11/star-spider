//
//  MymessViewController.swift
//  XZ
//
//  Created by wjz on 2018/12/20.
//  Copyright © 2018年 wjz. All rights reserved.
//

import UIKit

class MymessViewController: UIViewController {
    
    var root : MyViewController?
    @IBOutlet weak var tv_name: UILabel!
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.root!.tv_name.text = "名字"
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tv_name.text = name
        // Do any additional setup after loading the view.
    }
    var name:String = ""
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
