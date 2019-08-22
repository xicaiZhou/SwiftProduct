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
        
        let selectAddress:UIButton = UIButton(type: UIButton.ButtonType.custom)
        selectAddress.frame = CGRect(x: 100,y: 200,width: 100,height: 40)
        selectAddress.backgroundColor = UIColor.purple
        self.view.addSubview(selectAddress)
        selectAddress.addTarget(self, action:#selector(address), for: UIControl.Event.touchUpInside)
        
        
        
    }
    
    @objc func picker()  {
        XCDatePicker.init(currentDate: Date(), minLimitDate: Date.dateWithDateStr("2015-09-01", formatter: "yyyy-MM-dd"), maxLimitDate: Date.dateWithDateStr("2099-09-01", formatter: "yyyy-MM-dd"), datePickerType: .YMD) { (date) in
            
        }.show()
        
    }
    
    @objc func address() {
        
        XCAddressPicker.init(type: .PC) { (address) in
            print(address)
        }.show()
        
        XCAddressPicker.getAddressFormAddressId(addressID: "340000-340100", separator: "-") { (address) in
            print(address)

        }
        
        XCAddressPicker.getAddressIdFormAddress(address: "安徽省-合肥市", separator: "-") { (address) in
            print(address)

        }
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
