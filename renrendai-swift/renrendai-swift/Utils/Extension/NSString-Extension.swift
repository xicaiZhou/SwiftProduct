//
//  AppDelegate.swift
//  renrendai-swift
//
//  Created by 周希财 on 2019/8/6.
//  Copyright © 2019 VIC. All rights reserved.
//

import UIKit
import Foundation

extension NSString {
    
    // MARK: 自动计算Label文字决定宽高的封装
    class func getLabHeigh(labelStr:String,font:UIFont,width:CGFloat) -> CGFloat {
        
        let statusLabelText: NSString = labelStr as NSString
        
        let size = CGSize(width: width, height: 900)
        
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : Any], context:nil).size
        
        return strSize.height
        
    }

    
    func getLabWidth(labelStr:String,font:UIFont,height:CGFloat) -> CGFloat {
        
        let statusLabelText: NSString = labelStr as NSString
        
        let size = CGSize(width: 900, height: height)
        
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : Any], context:nil).size
        
        return strSize.width
        
    }
    /// 寻找某个字符在字符串中的位置
    fileprivate func findCharIndex(str: String, char: String) -> Int? {
        for (idx, item) in str.enumerated() {
            if String(item) == char {
                return idx
            }
        }
        return nil
    }
    
    ///是否包含字符串
    func containsIgnoringCase(find: String) -> Bool {
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    /// 获取字符串长度
    ///
    /// - Returns: 长度
    func length() -> Int {
        return (self as NSString).length
    }
    ///md5加密,添加这个方法后还要添加与oc的bridging文件
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8.rawValue)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8.rawValue))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for num in 0 ..< digestLen {
            hash.appendFormat("%02x", result[num])
        }
        result.deinitialize(count: 1)
        
        return String(format: hash as String)
    }
    static func convert(fromJSON object: Any) -> String? {
        if JSONSerialization.isValidJSONObject(object) {
            if let data = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted) {
                return String.init(data: data, encoding: .utf8)
            }
        }
        return nil
    }

    
    /// 正则相关
    private func isValidateBy(regex: String) -> Bool{
        let predicate = NSPredicate(format: "SELF MATCHES " + regex)
        return predicate.evaluate(with: self)
    }
        /// 是否是手机号 分服务商
    func isMobileNumberClassification() -> Bool{
        /**
         * 手机号码
         * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,1705
         * 联通：130,131,132,152,155,156,185,186,1709
         * 电信：133,1349,153,180,189,1700
         */
        //    NSString * MOBILE = @"^1((3//d|5[0-35-9]|8[025-9])//d|70[059])\\d{7}$";//总况
        
        /**
         10         * 中国移动：China Mobile
         11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188，1705
         12         */
        let CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d|705)\\d{7}$"
        /**
         15         * 中国联通：China Unicom
         16         * 130,131,132,152,155,156,185,186,1709
         17         */
        let CU = "^1((3[0-2]|5[256]|8[56])\\d|709)\\d{7}$"
        /**
         20         * 中国电信：China Telecom
         21         * 133,1349,153,180,189,1700
         22         */
        let CT = "^1((33|53|8[09])\\d|349|700)\\d{7}$"
        
        
        /**
         25         * 大陆地区固话及小灵通
         26         * 区号：010,020,021,022,023,024,025,027,028,029
         27         * 号码：七位或八位
         28         */
        let PHS = "^0(10|2[0-5789]|\\d{3})\\d{7,8}$"
        
        
        //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        
        if self.isValidateBy(regex: CM)
            || self.isValidateBy(regex: CU)
            || self.isValidateBy(regex: CT)
            || self.isValidateBy(regex: PHS)
        {
            return true
        }else{
            return false
        }
    }
    /// 是否是手机号
    func isMobileNumber() -> Bool{
        let regex = "^(0|86|17951)?(13[0-9]|15[012356789]|17[0678]|18[0-9]|14[57])[0-9]{8}$"
        return self.isValidateBy(regex: regex)
    }
    /// 是否是邮箱号
    func isEmail() -> Bool{
        let regex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return self.isValidateBy(regex: regex)
    }
    /// 是否是身份证
    func isIDCard() -> Bool{
        let regex = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        return self.isValidateBy(regex: regex)
    }
    /// 是否是网址
    func isUrl() -> Bool{
        let regex = "^((http)|(https))+:[^\\s]+\\.[^\\s]*$"
        return self.isValidateBy(regex: regex)
    }
    /// 是否是邮编
    func isPostalcode() -> Bool{
        let regex = "^[0-8]\\d{5}(?!\\d)$";
        return self.isValidateBy(regex: regex)
    }
    
}
