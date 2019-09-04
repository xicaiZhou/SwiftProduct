//
//  LoginController.swift
//  renrendai-swift
//
//  Created by 周希财 on 2019/8/7.
//  Copyright © 2019 VIC. All rights reserved.
//

import UIKit
import Alamofire
import KakaJSON


class LoginController: BaseViewController {

    
    
    lazy var loginView: ZLHJ_LoginView = {
        
        let loginView = ZLHJ_LoginView.loadFromNib()
        loginView.frame = CGRect(x: 0, y: 100, width: kScreenWidth, height: 200)
        return loginView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.loginView)
        self.loginView.label.text = "我太难了"
        // Do any additional setup after loading the view.

        //
//        after(5) {
//            let param : Dictionary = ["phoneNumber":"15590284773","password":"21218cca77804d2ba1922c33e0151105"];
//            XCNetWorkTools.share.requestData(type: .post, api: "user/login", encoding: .JSON, parameters: param, success: { (res) in
//
//                Utils.saveUserInfo(info: res)
//                self.pushTabViewController()
//            }) { (errorInfo) in
//
//            }
//        }

        
//


//        XCNetWorkTools.share.requestData(type: .get, api: "wallet/detail", encoding: .URL, success: { (value) in
//
//            print(value)
//            let dic = value as! [String:Any]
//            print(dic)
//            let model:resData = try! resData.mapFromDict(value as! [String : Any], resData.self)
//            print(model.payed)
//
//
//        }) { (info) in
//
//        };
//
    }
   
    func pushTabViewController() {
        
        let tabbar = BaseTabbarController()
        navigationController?.pushViewController(tabbar, animated: true)
        
    }
    


}
