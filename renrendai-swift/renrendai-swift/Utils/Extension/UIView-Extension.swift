//
//  UIView-Extension.swift
//  renrendai-swift
//
//  Created by 周希财 on 2019/8/7.
//  Copyright © 2019 VIC. All rights reserved.
//

import UIKit

let kWidth:CGFloat = UIScreen.main.bounds.size.width
let kHeight:CGFloat = UIScreen.main.bounds.size.height

extension UITableView {
    static func creatTableView(_ delegate: Any) -> UITableView {
        let tableView:UITableView = UITableView.init(frame: CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: CGSize.init(width: kWidth, height: kHeight)), style: .plain)
        tableView.delegate = delegate as? UITableViewDelegate
        tableView.dataSource = delegate as? UITableViewDataSource
        tableView.separatorStyle = .none
        tableView.scrollsToTop = true
        
        return tableView
    }
    func xc_registerCell<T:UITableViewCell>(cell:T.Type) {
        register(cell, forCellReuseIdentifier: cell.identifier)
    }
}
extension UITableViewCell {
    static var identifier:String {
        return String(describing: self)
    }
    
}
extension UILabel {
    static func label(title:String?, font:UIFont?, textColor:UIColor?) -> UILabel {
        let label = UILabel.init()
        label.text = title
        if let font = font {
            label.font = font
        }
        if let textColor = textColor {
            label.textColor = textColor
        }
        return label
    }
}
extension UITextField {
    static func textField(placeholder:String?, font:UIFont?, textColor:UIColor?) -> UITextField {
        let textFiled = UITextField.init()
        if let font = font {
            textFiled.font = font
        }
        if let textColor = textColor {
            textFiled.textColor = textColor
        }
        textFiled.placeholder = placeholder
        return textFiled
    }
}
extension UIButton {
    static func button(title:String?,font:UIFont?,titleColor:UIColor?) -> UIButton {
        let btn = UIButton.init(type: .custom)
        if let font = font {
            btn.titleLabel?.font = font
        }
        btn.setTitleColor(titleColor, for: .normal)
        btn.setTitle(title, for: .normal)
        return btn
    }
}
extension UIView {
//    public class func instantiateFromNib() -> UIView {
//        let className = type(of:self)
//        let bundle = Bundle(for:className as! AnyClass)
//        let name = NSStringFromClass(className as! AnyClass).components(separatedBy: ".").last
//        let nib = UINib(nibName: name!, bundle: bundle)
//        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
//        
//        return view
//    }
    public func viewCorner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.bounds = self.frame
        maskLayer.position = self.center
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    public func viewBoardAll(width:CGFloat , color:UIColor){
        self.layer.borderWidth = width
        self.layer.borderColor =  color.cgColor
    }
    /// 找到当前控件所在的控制器
    func getCurrentViewController() -> UIViewController? {
        var nextResponder = next
        repeat {
            let isVC = nextResponder?.isKind(of: UIViewController.self)
            if isVC != nil {
                return nextResponder as? UIViewController
            }
            nextResponder = nextResponder?.next
        }while (nextResponder != nil)
        return nil
    }
    
    var left:CGFloat {
        set {
            self.frame.origin.x = newValue
        }
        get {
            return self.frame.origin.x
        }
    }
    var right:CGFloat {
        set {
            self.frame.origin.x = newValue - self.frame.size.width
        }
        get {
            return self.frame.origin.x + self.frame.size.width
        }
    }
    var top:CGFloat {
        set {
            self.frame.origin.y = newValue
        }
        get {
            return self.frame.origin.y
        }
    }
    var bottom:CGFloat {
        set {
            self.frame.origin.y = newValue - self.frame.size.height
        }
        get {
            return self.frame.origin.y + self.frame.size.height
        }
    }
    var centerX : CGFloat {
        set {
            self.center = CGPoint.init(x: newValue, y: self.center.y)
        }
        get {
            return self.center.x
        }
    }
    var centerY:CGFloat {
        set {
            self.center = CGPoint.init(x: self.center.x, y: newValue)
        }
        get {
            return self.center.y
        }
    }
    var width:CGFloat {
        set {
            self.frame.size.width = newValue
        }
        get {
            return self.frame.size.width
        }
    }
    
    var height:CGFloat{
        set {
            self.frame.size.height = newValue
        }
        get {
            return self.frame.size.height
        }
    }
    var size:CGSize {
        set {
            self.frame.size = newValue
        }
        get {
            return self.frame.size
        }
    }
    var origin:CGPoint {
        set {
            self.frame.origin = newValue
        }
        get {
            return self.frame.origin
        }
    }
    
}
