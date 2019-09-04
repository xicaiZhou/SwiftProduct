//
//  NIBLoadable.swift
//  renrendai-swift
//
//  Created by 周希财 on 2019/9/4.
//  Copyright © 2019 VIC. All rights reserved.
//

import UIKit

protocol NIBLoadable {
    
}

extension NIBLoadable where Self: UIView {
    static func loadFromNib(_ nibname : String? = nil) -> Self {
        let loadName = nibname == nil ? "\(self)" : nibname!
        print(loadName)
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
}
