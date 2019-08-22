//
//  JSONKit.swift
//  renrendai-swift
//
//  Created by 周希财 on 2019/8/9.
//  Copyright © 2019 VIC. All rights reserved.
//

import Foundation
fileprivate enum MapError: Error {
    case jsonToModelFail    //json转model失败
    case jsonToDataFail     //json转data失败
    case dictToJsonFail     //字典转json失败
    case jsonToArrFail      //json转数组失败
    case modelToJsonFail    //model转json失败
}

protocol Mappable: Codable {
    func modelMapFinished()
    mutating func structMapFinished()
}

extension Mappable {
    
    func modelMapFinished() {}
    
    mutating func structMapFinished() {}
    
    //模型转字典
    func reflectToDict() -> [String:Any] {
        let mirro = Mirror(reflecting: self)
        var dict = [String:Any]()
        for case let (key?, value) in mirro.children {
            dict[key] = value
        }
        return dict
    }
    
    
    //字典转模型
    static func mapFromDict<T : Mappable>(_ dict : [String:Any], _ type:T.Type) throws -> T {
        guard let JSONString = dict.toJSONString() else {
            print(MapError.dictToJsonFail)
            throw MapError.dictToJsonFail
        }
        guard let jsonData = JSONString.data(using: .utf8) else {
            print(MapError.jsonToDataFail)
            throw MapError.jsonToDataFail
        }
        let decoder = JSONDecoder()
        
        if let obj = try? decoder.decode(type, from: jsonData) {
            var vobj = obj
            let mirro = Mirror(reflecting: vobj)
            if mirro.displayStyle == Mirror.DisplayStyle.struct {
                vobj.structMapFinished()
            }
            if mirro.displayStyle == Mirror.DisplayStyle.class {
                vobj.modelMapFinished()
            }
            return vobj
        }
        print(MapError.jsonToModelFail)
        throw MapError.jsonToModelFail
    }
    
    
    //JSON转模型
    static func mapFromJson<T : Mappable>(_ JSONString : String, _ type:T.Type) throws -> T {
        guard let jsonData = JSONString.data(using: .utf8) else {
            print(MapError.jsonToDataFail)
            throw MapError.jsonToDataFail
        }
        let decoder = JSONDecoder()
        if let obj = try? decoder.decode(type, from: jsonData) {
            return obj
        }
        print(MapError.jsonToModelFail)
        throw MapError.jsonToModelFail
    }
    
    
    //模型转json字符串
    func toJSONString() throws -> String {
        if let str = self.reflectToDict().toJSONString() {
            return str
        }
        print(MapError.modelToJsonFail)
        throw MapError.modelToJsonFail
    }
}


extension Array {
    
    func toJSONString() -> String? {
        if (!JSONSerialization.isValidJSONObject(self)) {
            print("dict转json失败")
            return nil
        }
        if let newData : Data = try? JSONSerialization.data(withJSONObject: self, options: []) {
            let JSONString = NSString(data:newData as Data,encoding: String.Encoding.utf8.rawValue)
            return JSONString as String? ?? nil
        }
        print("dict转json失败")
        return nil
    }

    func mapFromJson<T : Decodable>(_ type:[T].Type) throws -> Array<T> {
        guard let JSONString = self.toJSONString() else {
            print(MapError.dictToJsonFail)
            throw MapError.dictToJsonFail
        }
        guard let jsonData = JSONString.data(using: .utf8) else {
            print(MapError.jsonToDataFail)
            throw MapError.jsonToDataFail
        }
        let decoder = JSONDecoder()
        if let obj = try? decoder.decode(type, from: jsonData) {
            return obj
        }
        print(MapError.jsonToArrFail)
        throw MapError.jsonToArrFail
    }
}


extension Dictionary {
    func toJSONString() -> String? {
        if (!JSONSerialization.isValidJSONObject(self)) {
            print("dict转json失败")
            return nil
        }
        if let newData : Data = try? JSONSerialization.data(withJSONObject: self, options: []) {
            let JSONString = NSString(data:newData as Data,encoding: String.Encoding.utf8.rawValue)
            return JSONString as String? ?? nil
        }
        print("dict转json失败")
        return nil
    }
}


extension String {
    func toDict() -> [String:Any]? {
        guard let jsonData:Data = self.data(using: .utf8) else {
            print("json转dict失败")
            return nil
        }
        if let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) {
            return dict as? [String : Any] ?? ["":""]
        }
        print("json转dict失败")
        return nil
    }
}
extension Data {
    func toModel<T:Codable>(modelType:T.Type) -> T? {
        do {
            return try JSONDecoder.init().decode(modelType, from: self)
        } catch {
            debugPrint(error.localizedDescription)
            return  nil
        }
    }
    func toDictionary() -> Dictionary<String,Any>? {
        if let dic = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) {
            if let result = dic as? Dictionary<String,Any>{
                return result
            }
        }
        return nil
    }
    func toArray() -> Array<Any>? {
        if let arr = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) {
            if let result = arr as? Array<Any>{
                return result
            }
        }
        return nil
    }
    func toString() -> String? {
        return String.init(data: self, encoding: .utf8)
    }
    
}
