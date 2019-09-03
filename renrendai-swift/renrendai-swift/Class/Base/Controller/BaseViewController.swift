//
//  BaseViewController.swift
//  renrendai-swift
//
//  Created by 周希财 on 2019/8/7.
//  Copyright © 2019 VIC. All rights reserved.
//

import UIKit
import Toast_Swift
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        
    }
    

    
    
    func setupBarButtonItemSelectorName(){
        
        let button : UIButton = UIButton.init(type: UIButton.ButtonType.system);

        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        button.setTitle("返回", for: UIControl.State.normal);
        button.setTitle("返回", for: UIControl.State.highlighted);
        button.setTitleColor(UIColor.red, for: UIControl.State.normal);
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18);
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: button)

    }

    
    // 获取当前显示的ViewController
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController?
    {
        if let nav = base as? UINavigationController
        {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController
        {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController
        {
            return currentViewController(base: presented)
        }
        return base
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
