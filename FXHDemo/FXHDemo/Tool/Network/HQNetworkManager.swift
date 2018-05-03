//
//  HQNetworkManager.swift
//  FXHDemo
//
//  Created by wangyang on 2018/5/3.
//  Copyright © 2018年 HangzhouHaiqu. All rights reserved.
//

import UIKit
import Alamofire

class HQNetworkManager: NSObject {
    func postRequest(param:[String:Any],url:String,callback:@escaping ((_ success:Bool,_ response:[String:Any]?)->())) -> () {
        let header : HTTPHeaders = [:]
        Alamofire.request(kDOMAIN + url, method: .post, parameters: param, encoding: URLEncoding.default, headers: header).responseJSON { (result) in
            switch result.result.isSuccess {
            case true :
                if let value = result.result.value {
                    let dic = value as? [String : Any];
                    guard let retCode = dic?["retCode"] as? String else {
                        callback(false, dic);
                        return
                    }
                    if retCode == "0" {
                        callback(true,dic)
                    }
                }
                break
            case false:
                callback(true,["error":result.result.error as Any])
                break
            }
        }
    }
}