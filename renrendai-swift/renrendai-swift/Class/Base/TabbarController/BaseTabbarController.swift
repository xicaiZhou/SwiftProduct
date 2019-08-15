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

        //去掉UITabbar原有的选染色
//        UITabBar.appearance().isTranslucent = false
//
//        view.backgroundColor = UIColor.white
//        tabBar.backgroundColor = UIColor.white
//        UITabBar.appearance().shadowImage = UIImage()
//        UITabBar.appearance().backgroundImage = UIImage()
        
        
        initTabbar()
        
    }
    
    func dropShadow(offset: CGSize, radius:CGFloat, color:UIColor, opacity: CGFloat){
        
        let path = CGMutablePath()

        self.tabBar.layer.shadowPath = path
        
        
    }
    
    
    func initTabbar(){
        
        // ....
        //addChild(<#T##childController: UIViewController##UIViewController#>, title: <#T##String#>, imageNmae: <#T##String#>)
        addChild(MainViewController.init(), title: "1111", imageName: "icon_tabbar_complex")
        addChild(LoginController.init(), title: "1111", imageName: "icon_tabbar_complex")

    }
    
    func addChild(_ childController: UIViewController, title: String, imageName: String) {
        
        let navVC = BaseNavigationController.init(rootViewController: childController)
        childController.tabBarItem.title = title
        childController.tabBarItem.setTitleTextAttributes([.foregroundColor : UIColor.colorWithHex(hex:0xEC4A52)], for: .selected)
        childController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")
        self.addChild(navVC)
        
    }

    
    
}
