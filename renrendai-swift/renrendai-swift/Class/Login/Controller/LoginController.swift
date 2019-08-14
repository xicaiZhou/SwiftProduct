//
//  LoginController.swift
//  renrendai-swift
//
//  Created by 周希财 on 2019/8/7.
//  Copyright © 2019 VIC. All rights reserved.
//

import UIKit
import Alamofire



class LoginController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.purple;
        // Do any additional setup after loading the view.
        

//        let param : Dictionary = ["phoneNumber":"15590284773","password":"21218cca77804d2ba1922c33e0151105"];
//        XCNetWorkTools.share.requestData(type: .post, api: "user/login", encoding: .JSON, parameters: param, success: { (res) in
//
//
//        }) { (errorInfo) in
//
//        }
//        


        XCNetWorkTools.share.requestData(type: .get, api: "wallet/detail", encoding: .URL, success: { (value) in

            print(value)
            let dic = value as! [String:Any]
            print(dic)
            let model:resData = try! resData.mapFromDict(value as! [String : Any], resData.self)
            print(model.payed)


        }) { (info) in

        };
//
    }
   
    


}
