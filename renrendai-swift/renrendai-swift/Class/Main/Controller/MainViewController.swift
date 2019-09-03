//
//  MainViewController.swift
//  renrendai-swift
//
//  Created by 周希财 on 2019/8/15.
//  Copyright © 2019 VIC. All rights reserved.
//

import UIKit
import HEPhotoPicker

class MainViewController: BaseViewController {
    
    



    lazy var tableview: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: KHeight_NavBar, width: kScreenWidth, height: kScreenHeight - KHeight_NavBar - KHeight_TabBat), style: .plain)
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        return tableView
    }()
    
    var arr: Array =  ["日历选择器", "地址选择器", "图片选择器", "Alert", "Toast", "Rx~函数式响应编程", "GCD"]
    

    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "mainTableViewCell")
        
        view.addSubview(tableview)
    
    }
    
    
}
