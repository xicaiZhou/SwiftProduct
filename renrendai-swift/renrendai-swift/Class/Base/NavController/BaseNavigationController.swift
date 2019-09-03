//
//  BaseNavigationController.swift
//  renrendai-swift
//
//  Created by 周希财 on 2019/8/7.
//  Copyright © 2019 VIC. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.backgroundColor = UIColor.clear
        self.navigationBar.barTintColor = UIColor.clear
        self.navigationBar.setBackgroundImage(UIImage(named: "nav_bar_bg"), for: .default)
        self.navigationBar.titleTextAttributes = {[ NSAttributedString.Key.foregroundColor: UIColor.white,
                                                    NSAttributedString.Key.font: UIFont(name: "Heiti SC", size: 24.0)!]}()

    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
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
