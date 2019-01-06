//
//  CustomTableViewCell.swift
//  XZ
//
//  Created by wjz on 2019/1/2.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    var iconImage     : UIImageView?
    var titleLabel    : UILabel?
    var subTitleLabel : UILabel?
    var subButton : UIButton?
    let screenWidth =  UIScreen.main.bounds.size.width
    var rows:Int = 0
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    @objc func composeBtnClick(subButton: UIButton) {
        print(subButton.tag)
       
    }
    func setUpUI(){
        // 图片
        iconImage = UIImageView(frame: CGRect(x:15, y: 10, width:100, height: 75))
        self.addSubview(iconImage!)
        
        // 大标题
        titleLabel = UILabel(frame: CGRect(x:(iconImage?.frame.size.width)!+25, y:10, width: self.frame.size.width-(iconImage?.frame.size.width)!+20, height:30))
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        titleLabel?.textColor = UIColor.black
        self.addSubview(titleLabel!)
        
        // 副标题
        subTitleLabel = UILabel(frame: CGRect(x:(iconImage?.frame.size.width)!+25, y:(titleLabel?.frame.size.height)!+35, width:self.frame.size.width-(iconImage?.frame.size.width)!+20, height: 30))
        subTitleLabel?.font = UIFont.systemFont(ofSize: 14)
        subTitleLabel?.textColor = UIColor.gray
        self.addSubview(subTitleLabel!)
        // 按钮
        subButton = UIButton(frame: CGRect(x:screenWidth-46-15, y:((95-46)/2), width:46, height: 46))
        subButton?.setTitle("详情", for: UIControl.State.normal)
        subButton?.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        subButton?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        subButton?.layer.cornerRadius=23
                        subButton?.layer.masksToBounds=true
                        subButton?.layer.borderColor = UIColor(red: 140/255, green:124/255, blue:221/255, alpha:1).cgColor
                        subButton?.layer.borderWidth=1
        subButton?.addTarget(self, action: #selector(composeBtnClick), for: UIControl.Event.touchUpInside)
        subButton!.tag = rows
        self.addSubview(subButton!)
        
    }
    
    // 给cell赋值，项目中一般使用model，我这里直接写死了
    func setValueForCell(){
        
        rows = rows+1
        iconImage?.image = UIImage(named:"weibo")
        titleLabel?.text = "大大大大的标题"
        subTitleLabel?.text = "副副副副的标题"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
