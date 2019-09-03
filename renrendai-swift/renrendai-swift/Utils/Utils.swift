//
//  Utils.swift
//  renrendai-swift
//
//  Created by 周希财 on 2019/8/13.
//  Copyright © 2019 VIC. All rights reserved.
//

import Foundation
import UIKit


let Window = UIApplication.shared.delegate?.window!

//判断机型
let isPad = UIDevice.current.userInterfaceIdiom == .pad
let isPhone = UIDevice.current.userInterfaceIdiom == .phone
let isiPhoneX :Bool = UIApplication.shared.statusBarFrame.height >= 44

//屏幕宽高
let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height
let KStatusHeight = UIApplication.shared.statusBarFrame.size.height
let KHeight_NavBar: CGFloat = isiPhoneX ? 88.0 : 64.0
let KHeight_TabBat: CGFloat = isiPhoneX ? 83.0 : 49.0


//GCD - 返回主线程
func main(mainTodo:@escaping ()->()){
    DispatchQueue.main.async {
        mainTodo();
    }
}

//GCD - after延时
func after(_ seconds: Int, _ afterToDo: @escaping ()->()) {
    let deadlineTime = DispatchTime.now() + .seconds(seconds)
    DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
        afterToDo()
    }
}

class Utils{
    
    /// 打电话
    class func callToNum( PhoneNumber: String){
    
        let telNumber = "tel:"+PhoneNumber
        let callWebView = UIWebView()
        callWebView.loadRequest(URLRequest.init(url: URL.init(string: telNumber)!))
        UIApplication.shared.keyWindow?.addSubview(callWebView)
    }
    
    /// 获取APP版本号
    class func appVersion() -> String{
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    class func getFilePath(fileName: String, ofType: String) ->(String){
        return  Bundle.main.path(forResource: fileName, ofType: ofType)!
    }
    
    /// 获取buildID
    class func appBuildID() -> String{
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }
    
    /// 获取UUID（设备唯一编码）
    class func UUID() ->String{
        return (UIDevice.current.identifierForVendor?.uuidString)!
    }
    
    /// NSUserDefault --- save
    class func userDefaultSave(Key: String, Value: Any){
        return UserDefaults.standard.setValue(Value, forKey: Key)
    }
    
    /// NSUserDefault --- read
    class func userDefaultRead(key:String) -> Any{
        return UserDefaults.standard.object(forKey: key) as Any
    }
    
    /// NSUserDefault --- Remove
    class func userDefaultRemove(key: String) {
         UserDefaults.standard.removeObject(forKey: key)
         UserDefaults.standard.synchronize()
    }
    
    /// NSUserDefault --- saveUserInfo
    class func saveUserInfo(info: Any) {
        Utils.userDefaultSave(Key: "USER", Value: info)
    }
    
    /// NSUserDefault --- getUserInfo
    class func getUserInfo() -> UserModel {
        return ((Utils.userDefaultRead(key: "USER")) as! [String: Any]).kj.model(UserModel.self)
    }
    
    /// NSUserDefault --- cleanUserInfo
    class func cleanUserInfo(){
        return Utils.userDefaultRemove(key: "USER")
    }
    
    /// NSUserDefault --- getToken
    class func getToken() ->String{
        return getUserInfo().token
    }
    
    /// NSUserDefault --- isLogin?
    class func isLogin() ->Bool {
        var isLogin = false
        let token = self.getToken()
        print("token:", token)
        isLogin = token.count > 0 ? true : false
        return isLogin
    }
    /// mark RGB -> UIColor
    class func colorFromRGB(colorStr: String, alpha: CGFloat) -> UIColor{
        var Str: NSString = colorStr.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased() as NSString
        if colorStr .hasPrefix("#") {
            Str = (colorStr as NSString).substring(from: 1) as NSString
        }
        let redStr = (Str as NSString).substring(to: 2)
        let greenStr = ((Str as NSString).substring(from: 2) as NSString).substring(to: 2)
        let blueStr = ((Str as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0,g:CUnsignedInt = 0,b:CUnsignedInt = 0
        Scanner(string: redStr).scanHexInt32(&r)
        Scanner(string: greenStr).scanHexInt32(&g)
        Scanner(string: blueStr).scanHexInt32(&b)

        return UIColor(red: CGFloat(r)/255.0, green:  CGFloat(g)/255.0, blue:  CGFloat(b)/255.0, alpha: alpha)
        
    }
    ///mark UIColor -> UIImage
    class func imageFormColor(color:UIColor) -> UIImage{
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0);
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context!.fill(rect)
        let image :UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    

}


