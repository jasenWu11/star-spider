//
//  MymessViewController.swift
//  XZ
//
//  Created by wjz on 2018/12/20.
//  Copyright © 2018年 wjz. All rights reserved.
//

import UIKit
import Alamofire
class textViewController: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let inputNameLabel = UILabel()
    let inputNameTextField = UITextField()
    let inputNameLoginButton = UIButton()
    let photo = UIImageView()
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
    
    //输入信息名称
    inputNameLabel.frame = CGRect(x: 20, y:50, width: 200, height:20)
    inputNameLabel.text = "Input Your Name"
        inputNameLabel.textColor = UIColor.blue
        inputNameLabel.font = UIFont.systemFont(ofSize: 14)
        inputNameLabel.textAlignment = NSTextAlignment.left
    self.view.addSubview(inputNameLabel)
    
    //输入信息
    inputNameTextField.frame = CGRect(x: 20, y:90, width: 200, height:30)
    inputNameTextField.placeholder = " Please Input Your Name"
        inputNameTextField.font = UIFont.systemFont(ofSize: 14)
    inputNameTextField.delegate = self
    inputNameTextField.clipsToBounds = true
    inputNameTextField.layer.cornerRadius = 5
    inputNameTextField.layer.borderWidth = 0.5
        inputNameTextField.layer.borderColor = UIColor.grayColor.cgColor
    self.view.addSubview(inputNameTextField)
    
    //模拟登陆按钮
    inputNameLoginButton.frame = CGRect(x: 20, y:130, width: 200, height:30)
        inputNameLoginButton.setTitle("Login Button", for:UIControl.State.Normal)
        inputNameLoginButton.setTitleColor(UIColor.blueColor(), for: UIControl.State.Normal)
        inputNameLoginButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        inputNameLoginButton.titleLabel?.textAlignment = NSTextAlignment.left
    inputNameLoginButton.addTarget(self, action:#selector(textViewController.loginClike), forControlEvents:UIControlEvents.TouchUpInside)
    self.view.addSubview(inputNameLoginButton)
    
    //照片
    photo.frame = CGRect(x: 20, y:180, width: 200, height:200)
    photo.image = UIImage(named: "img.jpg")
    //给照片加入点击事件 点击可选择系统相册照片
    let choosePhoto:UITapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector (textViewController.chooseTap))
    photo.addGestureRecognizer(choosePhoto)
        photo.isUserInteractionEnabled = true
    self.view.addSubview(photo)
    
    }
    
    func loginClike() -> () {
        print("Login Button Clike...")
        inputNameLabel.text = "Change Input Your Name"
        photo.image = UIImage(named: "img1.jpg")
        
    }
    
    func chooseTap() -> () {
        
        //创建UIImagePickerController
        let imagePicker = UIImagePickerController()
        //类型。。 相册
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self//设置代理
        present(imagePicker, animated:true, completion: nil)//跳转
        
    }
    
    //点击取消 返回
    func imagePickerControllerDidCancel(picker:UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }
    
    //选择完照片后的调用方法
    func imagePickerController(picker:UIImagePickerController, didFinishPickingMediaWithInfo info: [String :AnyObject]) {
        //拿到选择完的照片
        let selectedImage = info[UIImagePickerControllerOriginalImage]as! UIImage
        //设置photo的照片
        photo.image = selectedImage
        //返回
        dismiss(animated: true, completion:nil)
    }
    
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
    
    
}
