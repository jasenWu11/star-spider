//
//  hideViewController.swift
//  XZ
//
//  Created by 烨文  梁 on 2019/1/7.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit

class hideViewController: UIViewController {

    @IBOutlet var hideHegiht: NSLayoutConstraint!
    @IBOutlet var hidButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func action(_ sender: Any) {
        hidButton.isHidden = !hidButton.isHidden
        if hidButton.isHidden{
                    hideHegiht.constant = 0
        }else{
            hideHegiht.constant = 400
        }

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
