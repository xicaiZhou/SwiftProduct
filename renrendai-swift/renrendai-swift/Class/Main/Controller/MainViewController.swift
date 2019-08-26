//
//  MainViewController.swift
//  renrendai-swift
//
//  Created by 周希财 on 2019/8/15.
//  Copyright © 2019 VIC. All rights reserved.
//

import UIKit
import HEPhotoPicker

class MainViewController: BaseViewController, HEPhotoPickerViewControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    //MARK: UITableViewDelegate - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "mainTableViewCell", for: indexPath)
        
        cell.textLabel?.text = arr[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        switch indexPath.row {
        case 0:
            picker()
        case 1:
            address()
        case 2:
            photoSelect()
        case 3:
            alertShow()
        case 4:
            toastShow()
        default:
            break
        }
        
    }
    
    //MARK: HEPhotoPickerViewControllerDelegate
    func pickerController(_ picker: UIViewController, didFinishPicking selectedImages: [UIImage], selectedModel: [HEPhotoAsset]) {
        
    }

    lazy var tableview: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: KHeight_NavBar, width: kScreenWidth, height: kScreenHeight - KHeight_NavBar - KHeight_TabBat), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        return tableView
    }()
    
    var arr: Array =  ["日历选择器", "地址选择器", "图片选择器", "Alert", "Toast"]

    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "swift"
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "mainTableViewCell")
        
        view.addSubview(tableview)
        

        
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
    
    @objc func photoSelect() {
        let option = HEPickerOptions.init()
        // 只能选择一个视频
        option.singleVideo = true
        // 图片和视频只能选择一种
        option.mediaType = .imageOrVideo
        // 将上次选择的数据传入，表示支持多次累加选择，
        //        option.defaultSelections = self.selectedModel
        // 选择图片的最大个数
        option.maxCountOfImage = 9
        // 创建选择器
        let picker = HEPhotoPickerViewController.init(delegate: self, options: option)
        // 弹出
        hePresentPhotoPickerController(picker: picker, animated: true)
    }

    func alertShow() {
        Alert.showAlert1(self, title: "title", message: "message", alertTitle: "alertTitle", style: .default) {
            
        }
    }
    
    
    func toastShow() {
        // basic usage
        self.view.makeToast("This is a piece of toast")
        
        // toast with a specific duration and position
        self.view.makeToast("This is a piece of toast", duration: 3.0, position: .top)
        
        // toast presented with multiple options and with a completion closure
        self.view.makeToast("This is a piece of toast", duration: 2.0, point: CGPoint(x: 110.0, y: 110.0), title: "Toast Title", image: UIImage(named: "toast.png")) { didTap in
            if didTap {
                print("completion from tap")
            } else {
                print("completion without tap")
            }
        }
        
        // display toast with an activity spinner
        self.view.makeToastActivity(.center)
        
        // display any view as toast
//        self.view.showToast(anyView)
        
        // immediately hides all toast views in self.view
        self.view.hideAllToasts()
        
    }
}
