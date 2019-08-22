//
//  XCAddressPicker.swift
//  renrendai-swift
//
//  Created by 周希财 on 2019/8/16.
//  Copyright © 2019 VIC. All rights reserved.
//

import Foundation
import UIKit

fileprivate let XCAddressPickerMargin:CGFloat = 8
fileprivate let XCAddressPickerH:CGFloat = 270

typealias DoneAddressBlock = (Address)->()
// 显示时间类型
public enum XCAddressPickerType:String {
    case P      // 省
    case PC      // 省市
    case PCA     // 省市区
 
}


class XCAddressPicker: UIView{
    
    fileprivate var dataSource = Array<Province>()
    fileprivate var type: XCAddressPickerType = .PCA //default 省市区
    fileprivate var doneBlock: DoneAddressBlock?
    fileprivate var indexOne = 0, indexTwo = 0, indexThree = 0
    
    fileprivate var backWindow: UIWindow = {
        let backWindow = UIWindow(frame: UIScreen.main.bounds)
        backWindow.windowLevel = UIWindow.Level.statusBar
        backWindow.backgroundColor = UIColor(white: 0, alpha: 0.2)
        backWindow.isHidden = true
        return backWindow
    }()
    fileprivate var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.showsSelectionIndicator = false
        return pickerView
    }()
    
    
}
extension XCAddressPicker{

    convenience init(type: XCAddressPickerType?, _ doneBlock: @escaping DoneAddressBlock){
        
        self.init()
        self.doneBlock = doneBlock
        if let type = type {
            self.type = type
        }
        
         layoutUI()
         loadData()
    }
    
    func layoutUI() {
        
        backgroundColor = UIColor.white
        layer.cornerRadius = 8
        clipsToBounds = true
        
        pickerView.delegate = self;
        pickerView.dataSource = self;
        pickerView.backgroundColor = UIColor.clear
        addSubview(pickerView)
        pickerView.snp.makeConstraints { (make) in
            
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(54)        }
        
        // 按钮
        let doneButton = UIButton(type: .custom)
        doneButton.setTitle("确定", for: .normal)
        doneButton.backgroundColor = UIColor.orange
        doneButton.addTarget(self, action: #selector(XCAddressPicker.doneButtonHandle), for: .touchUpInside)
        addSubview(doneButton)
        doneButton.snp.makeConstraints { (make) in
            
            make.top.left.right.equalToSuperview()
            make.height.equalTo(54)
        }
        
        backWindow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss)))
        
    }
    
    func loadData() {
        
        let path = Utils.getFilePath(fileName: "address", ofType: "json")
        if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe){
            
            let dataArray = data.toArray()!
            let dataPro = try! dataArray.mapFromJson([Province].self)
            self.dataSource = dataPro
            self.pickerView.reloadAllComponents()
        }
        
    }
    @objc func doneButtonHandle() {
      
        let pro = self.dataSource[indexOne].name
        let proId = self.dataSource[indexOne].id
        
        let city: String
        let cityId: String

        let area: String
        let areaId:String
        
        var address: String, addressId: String;
        
        var add: Address
        if type == .P {
            address = pro
            addressId = proId
            add = Address(address: address, addressId: addressId, province: pro, provinceId: proId, city: "",cityId: "",area: "",areaId: "");

        }else if type == .PC {
            city = self.dataSource[indexOne].city[indexTwo].name
            cityId = self.dataSource[indexOne].city[indexTwo].id
            address = pro + "-" + city
            addressId = proId + "-" + cityId
            add = Address(address: address, addressId: addressId, province: pro, provinceId: proId, city: city,cityId: cityId,area: "",areaId: "");

        }else{
            city = self.dataSource[indexOne].city[indexTwo].name
            cityId = self.dataSource[indexOne].city[indexTwo].id
            area = self.dataSource[indexOne].city[indexTwo].area[indexThree].name
            areaId = self.dataSource[indexOne].city[indexTwo].area[indexThree].name
            address = pro + "-" + city + "-" + area
            addressId = proId + "-" + cityId + "-" + areaId
            add = Address(address: address, addressId: addressId, province: pro, provinceId: proId, city: city,cityId: cityId,area: area,areaId: areaId);
        }

        doneBlock!(add)
        dismiss()
    }
    
}

extension XCAddressPicker: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        if type == .P {
            return 1
        }else if type == .PC {
            return 2
        }else{
            return 3
        }
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case 0:
           return self.dataSource.count
        case 1:
            let dic: Province = self.dataSource[indexOne]
            return dic.city.count
        case 2:
            let dic: Province = self.dataSource[indexOne]
            let city: City = dic.city[indexTwo]
            return city.area.count
        default:
            return 0
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch component {
        case 0:
            let dic: Province = self.dataSource[row]
            return dic.name
        case 1:
            let dic: Province = self.dataSource[indexOne]
            let city: City = dic.city[row]
            return city.name
        case 2:
            let dic: Province = self.dataSource[indexOne]
            let city: City = dic.city[indexTwo]
            let area: Area = city.area[row]
            return area.name
        default:
            return ""
        }
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //component表示你动了第几栏 row表示你懂了第几个
        print("didSelectRow:row:\(row) ------ component:\(component)")
        
        switch component {
        case 0:
            indexOne = row
            indexTwo = 0
            indexThree = 0

            if self.type == .P{ //只有省
                
            }else if self.type == .PC{ // 只显示省市
                pickerView.reloadComponent(1)
                pickerView.selectRow(0, inComponent: 1, animated: true)
            }else {   // 省市区
                
                pickerView.reloadComponent(1)
                pickerView.selectRow(0, inComponent: 1, animated: true)
                
                pickerView.reloadComponent(2)
                pickerView.selectRow(0, inComponent: 2, animated: true)
            }
            
        case 1:
            indexTwo = row
            indexThree = 0

            if type == .PCA {
                
                pickerView.reloadComponent(2)
                pickerView.selectRow(0, inComponent: 2, animated: true)
            }

        case 2:
            indexThree = row
            
        default:
            indexOne = 0
            indexTwo = 0
            indexThree = 0
        }
        
        
        
    }
    
    
}
extension XCAddressPicker{
    
    /// 根据id查找地址
    ///
    /// - Parameters:
    ///   - addressID: 地址id
    ///   - separator: 地址id间隔符
    ///   - type: XCAddressPickerType
    ///   - doneBlock: Address
    class func getAddressFormAddressId(addressID: String, separator:String, doneBlock: @escaping DoneAddressBlock ){
        
        
        //开启异步
        DispatchQueue.global().async {
            let path = Utils.getFilePath(fileName: "address", ofType: "json")
            var dataPro = Array<Province>()
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe){
                let dataArray = data.toArray()!
                dataPro = try! dataArray.mapFromJson([Province].self)
            }
            
            let arr:[String] = addressID.components(separatedBy: separator)
            
            var address: [String] = Array()
            
            var provinceModel: Province? = nil
            var cityModel: City?
            var provinceName: String = "", provinceId: String = "", cityName: String = "", cityId: String = "", areaName: String = "", areaId: String = ""

            
            for temp: Int in 0..<arr.count{
                let addressId: String = arr[temp]
                
                switch temp{
                    case 0:
                        for pro: Province in dataPro {
                            if pro.id == addressId {
                                provinceModel = pro
                                provinceName = pro.name
                                provinceId = pro.id
                                address.append(pro.name)
                                break
                            }
                    }
                    case 1:
                        for city: City in provinceModel!.city {
                            if city.id == addressId {
                                cityModel = city
                                cityName = city.name
                                cityId = city.id
                                address.append(city.name)
                                break
                            }
                    }
                    case 2:
                        for area: Area in cityModel!.area {
                            if area.id == addressId {
                                areaName = area.name
                                areaId = area.id
                                address.append(area.name)
                                break
                            }
                    }
                    default:
                    break
                }
                
            }
            
            let addressStr = address.joined(separator: separator)
            let add: Address = Address(address: addressStr, addressId: addressID, province: provinceName, provinceId: provinceId, city: cityName, cityId: cityId, area: areaName, areaId: areaId)

            //回到主线程
            DispatchQueue.main.async {
                doneBlock(add)
            }
            
        }
    }
    
    //根据地址找id
    class func getAddressIdFormAddress(address: String, separator:String, doneBlock: @escaping DoneAddressBlock){
        
        
        DispatchQueue.global().async {
            
            let path = Utils.getFilePath(fileName: "address", ofType: "json")
            var dataPro = Array<Province>()
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe){
                let dataArray = data.toArray()!
                dataPro = try! dataArray.mapFromJson([Province].self)
            }
            
            let arr:[String] = address.components(separatedBy: separator)
            
            var addressIdArray: [String] = Array()
            
            var provinceModel: Province? = nil
            var cityModel: City?
            var provinceName: String = "", provinceId: String = "", cityName: String = "", cityId: String = "", areaName: String = "", areaId: String = ""
            
            
            for temp: Int in 0..<arr.count{
                let tempName: String = arr[temp]
                
                switch temp{
                case 0:
                    for pro: Province in dataPro {
                        if pro.name == tempName {
                            provinceModel = pro
                            provinceName = pro.name
                            provinceId = pro.id
                            addressIdArray.append(pro.id)
                            break
                        }
                    }
                case 1:
                    for city: City in provinceModel!.city {
                        if city.name == tempName {
                            cityModel = city
                            cityName = city.name
                            cityId = city.id
                            addressIdArray.append(city.id)
                            break
                        }
                    }
                case 2:
                    for area: Area in cityModel!.area {
                        if area.name == tempName {
                            areaName = area.name
                            areaId = area.id
                            addressIdArray.append(area.id)
                            break
                        }
                    }
                default:
                    break
                }
                
            }
            
            let addressID = addressIdArray.joined(separator: separator)
            let add: Address = Address(address: address, addressId: addressID, province: provinceName, provinceId: provinceId, city: cityName, cityId: cityId, area: areaName, areaId: areaId)
            
            //回到主线程
            DispatchQueue.main.async {
                doneBlock(add)
            }
            
            
            
        }
    }
    
    
    
    
    
}
extension XCAddressPicker{
    func show(){
        
        backWindow.addSubview(self)
        backWindow.makeKeyAndVisible()
        frame = CGRect.init(x: XCAddressPickerMargin, y: backWindow.frame.height, width: backWindow.frame.width - XCAddressPickerMargin * 2, height: XCAddressPickerH)
        
        UIView.animate(withDuration: 0.3) {
            
            var bottom:CGFloat = 0
            if isiPhoneX {
                bottom = 44
            }
            
            self.frame = CGRect.init(x: XCAddressPickerMargin, y: self.backWindow.frame.height - XCAddressPickerH - bottom, width: self.backWindow.frame.width - XCAddressPickerMargin * 2, height: XCAddressPickerH)
        }
        
    }
    @objc public func dismiss() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = CGRect.init(x: XCAddressPickerMargin, y: self.backWindow.frame.height, width: self.backWindow.frame.width - XCAddressPickerMargin * 2, height: XCAddressPickerH)
        }) { (_) in
            self.removeFromSuperview()
            self.backWindow.resignKey()
        }
    }
}




struct Province: Mappable{
    var id: String
    var name: String
    var city: [City]

}

struct City: Mappable{
    var id: String
    var name: String
    var area: [Area]

}

struct Area: Mappable {
    var id: String
    var name: String
}


struct Address {
    var address: String
    var addressId: String
    var province: String
    var provinceId: String
    var city: String
    var cityId: String
    var area: String
    var areaId: String
}
