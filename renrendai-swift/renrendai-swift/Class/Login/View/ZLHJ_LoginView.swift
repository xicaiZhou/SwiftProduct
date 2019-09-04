//
//  ZLHJ_LgoinView.swift
//  renrendai-swift
//
//  Created by 周希财 on 2019/9/4.
//  Copyright © 2019 VIC. All rights reserved.
//

import UIKit

class ZLHJ_LoginView: UIView, NIBLoadable {
    
    
//    @IBOutlet var contentView: UIView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("走了")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }
}
