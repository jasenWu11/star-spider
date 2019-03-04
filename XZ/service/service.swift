//
//  servie.swift
//  XZ
//
//  Created by 烨文  梁 on 2019/1/7.
//  Copyright © 2019年 wjz. All rights reserved.
//

import Foundation
import Alamofire

class serviceUtils{
    
    
    func login(username:String,action : @escaping (DataResponse<Any>)-> Void){
        Alamofire.request("").responseJSON(completionHandler: action);
    }
}
