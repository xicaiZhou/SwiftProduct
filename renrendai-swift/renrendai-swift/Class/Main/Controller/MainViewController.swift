//
//  MainViewController.swift
//  renrendai-swift
//
//  Created by 周希财 on 2019/8/15.
//  Copyright © 2019 VIC. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "aaa"
        // Do any additional setup after loading the view.
        
        
        let btn:UIButton = UIButton(type: UIButton.ButtonType.custom)
        btn.frame = CGRect(x: 100,y: 100,width: 100,height: 40)
        btn.backgroundColor = UIColor.purple
       self.view.addSubview(btn)
        btn.addTarget(self, action:#selector(picker), for: UIControl.Event.touchUpInside)
        
      
        
        
        
    }
    
    @objc func picker()  {
        var pick : XCDatePicker = XCDatePicker.init(currentDate: Date(), minLimitDate: Date.dateWithDateStr("2015-09-01", formatter: "yyyy-MM-dd"), maxLimitDate: Date.dateWithDateStr("2099-09-01", formatter: "yyyy-MM-dd"), datePickerType: .YMD) { (date) in
            
        }
        
        pick.show()
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
