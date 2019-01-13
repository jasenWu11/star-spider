//
//  APImessViewController.swift
//  XZ
//
//  Created by wjz on 2018/12/26.
//  Copyright © 2018年 wjz. All rights reserved.
//

import UIKit

class APImessViewController: UIViewController {

    @IBOutlet weak var tv_desc: UITextView!
    @IBOutlet weak var iv_img: UIImageView!
    @IBOutlet weak var av_yyxx: UIView!
    @IBOutlet weak var av_yyxq: UIView!
    @IBOutlet weak var tv_atitle: UILabel!
    var ptitle:String = " "
    var pdesc:String = " "
    var pid:Int = 0
    @IBAction func Xiadan(_ sender: Any) {
        let alertController = UIAlertController(title: "下单成功!",
                                                message: nil, preferredStyle: .alert)
        //显示提示框
        self.present(alertController, animated: true, completion: nil)
        //两秒钟后自动消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.presentedViewController?.dismiss(animated: false, completion: nil)
        }
    }
    @IBOutlet weak var av_apidy: UIView!
    @IBOutlet weak var av_bbsm: UIView!
    @IBOutlet weak var segcon: UISegmentedControl!
    @IBAction func Xuanxiang(_ sender: Any) {
        switch segcon.selectedSegmentIndex{
        case 0:
            av_yyxx.isHidden = false
            av_yyxq.isHidden = true
            av_apidy.isHidden = true
            av_bbsm.isHidden = true
        case 1:
            av_yyxx.isHidden = true
            av_yyxq.isHidden = false
            av_apidy.isHidden = true
            av_bbsm.isHidden = true
        case 2:
            av_yyxx.isHidden = true
            av_yyxq.isHidden = true
            av_apidy.isHidden = false
            av_bbsm.isHidden = true
        case 3:
            av_yyxx.isHidden = true
            av_yyxq.isHidden = true
            av_apidy.isHidden = true
            av_bbsm.isHidden = false
        default:
            break
            
        }
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if(pid == 2238243){
            ptitle = "携程网机票价格走向"
            pdesc = "获取携程网机票价格数据，分析走向"
            let url = URL(string:"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1546428544571&di=aec9218dcffa1e52bd80d9bd046bd8ad&imgtype=0&src=http%3A%2F%2Fphotocdn.sohu.com%2F20150601%2Fmp17161050_1433123079696_1_th.png")
            let data = try! Data(contentsOf: url!)
            let smallImage = UIImage(data: data)
            iv_img.image = smallImage
            
        }
        if(pid == 2238242){
            ptitle = "百度搜索次数排行版"
            pdesc = "获取百度网搜索次数排行，分析用户需求"
            let url = URL(string:"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3668473071,2731513318&fm=26&gp=0.jpg")
            let data = try! Data(contentsOf: url!)
            let smallImage = UIImage(data: data)
            iv_img.image = smallImage
        }
        if(pid == 2238245){
            ptitle = "爱奇艺点击率最高电影"
            pdesc = "获取爱奇艺点击率最高电影,可以方便找到票房较高的电影，筛选避过烂片"
            let url = URL(string:"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1850075590,3068352838&fm=26&gp=0.jpg")
            let data = try! Data(contentsOf: url!)
            let smallImage = UIImage(data: data)
            iv_img.image = smallImage
        }
        if(pid == 2238241){
            ptitle = "微博热搜版"
            pdesc = "获取微博热搜版，研究大众兴趣"
            let url = URL(string:"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1546428801285&di=669cbde92e7431224a61735411e9f22f&imgtype=0&src=http%3A%2F%2Fwww.xmexpo.cn%2Fuploads%2Fallimg%2F180125%2F1Q91aG5_0.png")
            let data = try! Data(contentsOf: url!)
            let smallImage = UIImage(data: data)
            iv_img.image = smallImage
        }
        if(pid == 2238244){
            ptitle = "淘宝销售排行"
            pdesc = "获取淘宝销售排行，可以作为准备开网店的前期互联网用户需求分析调查研究使用"
            let url = URL(string:"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1546428895544&di=edf4a9afdf17a53d702aef9fee17a639&imgtype=0&src=http%3A%2F%2Fphoto.16pic.com%2F00%2F61%2F24%2F16pic_6124483_b.jpg")
            let data = try! Data(contentsOf: url!)
            let smallImage = UIImage(data: data)
            iv_img.image = smallImage
        }
        if(pid == 2238246){
            ptitle = "哔哩哔哩评论量排行"
            pdesc = "获取淘宝销售排行，可以作为准备开网店的前期互联网用户需求分析调查研究使用"
            let url = URL(string:"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1546428895544&di=edf4a9afdf17a53d702aef9fee17a639&imgtype=0&src=http%3A%2F%2Fphoto.16pic.com%2F00%2F61%2F24%2F16pic_6124483_b.jpg")
            let data = try! Data(contentsOf: url!)
            let smallImage = UIImage(data: data)
            iv_img.image = smallImage
        }
        if(pid == 2238244){
            ptitle = "深度学习"
            pdesc = "获取淘宝销售排行，可以作为准备开网店的前期互联网用户需求分析调查研究使用"
            let url = URL(string:"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1546428895544&di=edf4a9afdf17a53d702aef9fee17a639&imgtype=0&src=http%3A%2F%2Fphoto.16pic.com%2F00%2F61%2F24%2F16pic_6124483_b.jpg")
            let data = try! Data(contentsOf: url!)
            let smallImage = UIImage(data: data)
            iv_img.image = smallImage
        }
        tv_atitle.text = ptitle
        tv_desc.text = pdesc
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
