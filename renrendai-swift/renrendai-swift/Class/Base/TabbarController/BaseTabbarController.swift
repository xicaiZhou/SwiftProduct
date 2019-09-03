//
//  BaseTabbarController.swift
//  renrendai-swift
//
//  Created by 周希财 on 2019/8/7.
//  Copyright © 2019 VIC. All rights reserved.
//

import UIKit
import CoreGraphics

class BaseTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initTabbar()
        
    }
    
    func dropShadow(offset: CGSize, radius:CGFloat, color:UIColor, opacity: CGFloat){
        
        let path = CGMutablePath()

        self.tabBar.layer.shadowPath = path
        
        
    }
    
    
    func initTabbar(){
        
        // ....
        addChild(MainViewController.init(), title: "业务申请", imageName: "icon_tabbar_home")
        addChild(OrderViewController.init(), title: "综合查询", imageName: "icon_tabbar_search")
        addChild(OrderViewController.init(), title: "钱包", imageName: "icon_tabbar_wallet")
        addChild(OrderViewController.init(), title: "个人中心", imageName: "icon_tabbar_mine")

    }
    
    func addChild(_ childController: UIViewController, title: String, imageName: String) {
        
        let navVC = BaseNavigationController.init(rootViewController: childController)
        childController.tabBarItem.title = title
        childController.navigationItem.title = title
        childController.tabBarItem.setTitleTextAttributes([.foregroundColor : UIColor.colorWithHex(hex:0xEC4A52)], for: .selected)
        childController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_on")
        self.addChild(navVC)
        
    }

    
    
}
