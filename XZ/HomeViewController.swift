//
//  HomeViewController.swift
//  XZ
//
//  Created by wjz on 2018/12/29.
//  Copyright © 2018年 wjz. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController , SliderGalleryControllerDelegate{
    //获取屏幕宽度
    let screenWidth =  UIScreen.main.bounds.size.width
    
    //图片轮播组件
    var sliderGallery : SliderGalleryController!
    

    @IBOutlet weak var sv_tj: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化图片轮播组件
        sliderGallery = SliderGalleryController()
        sliderGallery.delegate = self
        sliderGallery.view.frame = CGRect(x: 0, y: 125, width: screenWidth,
                                          height: (screenWidth-20)/16*9);
        
        //将图片轮播组件添加到当前视图
        self.addChild(sliderGallery)
        self.view.addSubview(sliderGallery.view)
        
        //添加组件的点击事件
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(HomeViewController.handleTapAction(_:)))
        sliderGallery.view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        sv_tj.contentSize = CGSize.init(width: 450, height: 111);
        sv_tj.isScrollEnabled=true;
        sv_tj.showsVerticalScrollIndicator = false;
        sv_tj.showsHorizontalScrollIndicator = false;
    }
    //图片轮播组件协议方法：获取内部scrollView尺寸
    func galleryScrollerViewSize() -> CGSize {
        return CGSize(width: screenWidth, height: (screenWidth-20)/16*9)
    }
    
    //图片轮播组件协议方法：获取数据集合
    func galleryDataSource() -> [String] {
        return ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1546428544571&di=aec9218dcffa1e52bd80d9bd046bd8ad&imgtype=0&src=http%3A%2F%2Fphotocdn.sohu.com%2F20150601%2Fmp17161050_1433123079696_1_th.png",
                "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3668473071,2731513318&fm=26&gp=0.jpg",
                "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1850075590,3068352838&fm=26&gp=0.jpg",
                "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1546428801285&di=669cbde92e7431224a61735411e9f22f&imgtype=0&src=http%3A%2F%2Fwww.xmexpo.cn%2Fuploads%2Fallimg%2F180125%2F1Q91aG5_0.png",
                "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1546428895544&di=edf4a9afdf17a53d702aef9fee17a639&imgtype=0&src=http%3A%2F%2Fphoto.16pic.com%2F00%2F61%2F24%2F16pic_6124483_b.jpg"]
    }
    
    //点击事件响应
    @objc func handleTapAction(_ tap:UITapGestureRecognizer)->Void{
        //获取图片索引值
        let index = sliderGallery.currentIndex
        //弹出索引信息
        var ids : Int = 0
        
        if(index == 0){
            ids = 10
        }
        if(index == 1){
            ids = 11
        }
        if(index == 2){
            ids = 12
        }
        if(index == 3){
            ids = 13
        }
        if(index == 4){
            ids = 14
        }
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: APImessViewController())))
            as! APImessViewController
        controller.pid = ids
        self.present(controller, animated: true, completion: nil)
//        let alertController = UIAlertController(title: "您点击的图片索引是：",
//                                                message: "\(index)", preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
